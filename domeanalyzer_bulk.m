% Prompt user to select the parent directory
parent_dir = uigetdir;

% List all folders and files in the selected directory
myfolders = dir(parent_dir);

fprintf("Generating compiled score parameters and perframe features\n");

% Loop through each folder in the parent directory
for n = 3:length(myfolders) % Skip '.' and '..' entries
    if myfolders(n).isdir()
        fprintf("Processing folder: %s\n", myfolders(n).name); % Print current folder name
        mysubfolders = dir(fullfile(myfolders(n).folder, myfolders(n).name)); % List subdirectories

        % Loop through each subdirectory
        for f = 3:length(mysubfolders)
            if mysubfolders(f).isdir()
                % Construct the path to the 'FixTrax' subfolder
                trackingfolder = fullfile(mysubfolders(f).folder, mysubfolders(f).name, 'FixTrax');

                % Attempt to change the directory
                try
                    cd(trackingfolder);
                catch
                    fprintf("Folder not found: %s\n Exiting DomeAnalyzer\n Check input requirements\n", trackingfolder);
                    continue; % Skip to the next subdirectory
                end

                % Extract scores and per-frame data
                try
                    fprintf("Extracting scores and perframe data\n");
                    extractscoreperframe;
                catch
                    fprintf("extractscoreperframe could not be run\n Skipping step\n Check if JAABAPlot was run correctly\n");
                end

                % Create interaction matrix
                try
                    fprintf("Creating interaction matrix\n");
                    dnose2ell_allpair;
                    anglesub_allpairs;
                    angle_distance_combined_allpairs;
                    interaction_matrix;
                catch
                    fprintf("interaction_matrix could not be generated\n Skipping step\n Error to be troubleshooted\n");
                end

                % Generate network parameters
                try
                    fprintf("Generating Network Parameters\n");
                    network_parameters;
                catch
                    fprintf("Network parameters could not be generated\n Skipping step\n Check for R code compatibility\n");
                end

                % Rearrange data
                try
                    fprintf("Rearranging data according to the order in headers_text_file.csv\n");
                    rearrange_Analyzed_scores;
                    % Uncomment and update this line if needed
                    % pyrunfile("E:\FlyDome\FlyDomeAnalyzer\rearrange_Analyzed_scores.py");
                catch
                    fprintf("Analyzed_scores.csv could not be generated\n Skipping step\n Check Python installation\n");
                end
            end
        end
    end
end

% Clear all variables from the workspace
clear;
