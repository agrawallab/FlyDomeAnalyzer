% Prompt user to select the parent directory
parent_dir = uigetdir;

% Get a list of all folders and files in the selected directory
myfolders = dir(parent_dir);

fprintf("generating compiled score parameters and perframe features\n");

% Loop through each folder in the parent directory
for f = 3:length(myfolders) % Skip '.' and '..' entries
    if myfolders(f).isdir()
        % Construct the path to the 'FixTrax' subfolder
        trackingfolder = strcat(parent_dir, '/', myfolders(f).name, '/FixTrax');
        
        % Try to change the current directory to 'FixTrax'
        try
            cd(trackingfolder);
        catch
            % If changing directory fails, print an error message and continue to the next folder
            fprintf("Folder not found\nExiting DomeAnalyzer\nCheck input requirements\n");
            continue; % Skip to the next folder
        end
        
        % Try to execute the script for extracting scores and per-frame data
        try
            fprintf("Extracting scores and perframe data\n");
            extractscoreperframe;
        catch
            % If script execution fails, print an error message and continue
            fprintf("extractscoreperframe could not be run\nSkipping step\nCheck if JAABAPlot was run correctly\n");
        end

        % Try to create various matrices and perform calculations
        try
            fprintf("Creating interaction matrix\n");
            dnose2ell_allpair;
            anglesub_allpairs;
            angle_distance_combined_allpairs;
            interaction_matrix;
        catch
            % If any of these functions fail, print an error message and continue
            fprintf("interaction_matrix could not be generated\nSkipping step\nError to be troubleshooted\n");
        end

        % Try to generate network parameters
        try
            fprintf("Generating Network Parameters\n");
            network_parameters;
        catch
            % If this function fails, print an error message and continue
            fprintf("Network parameters could not be generated\nSkipping step\nCheck for R code compatibility\n");
        end

        % Try to rearrange data according to a specific order
        try
            fprintf("Rearranging data according to the order in headers_text_file.csv\n");
            rearrange_Analyzed_scores;
            % Uncomment and update this line if you need to run a Python script
            % pyrunfile("C:\Users\Admin\Documents\MATLAB\FlyDomeAnalyzer\rearrange_Analyzed_scores.py");
        catch
            % If data rearrangement fails, print an error message and continue
            fprintf("Analyzed_scores.csv could not be generated\nSkipping step\nCheck Python installation\n");
        end
    end
end

% Clear variables from the workspace
clear;
