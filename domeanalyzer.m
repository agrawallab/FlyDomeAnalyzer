parent_dir = uigetdir;
myfolders = dir(parent_dir);

fprintf("generating compiled score parameters and perframe features\n")

for f = 3:length(myfolders)
    if myfolders(f).isdir()
        trackingfolder = strcat(parent_dir,'/',myfolders(f).name,'/FixTrax')
        
        try
            cd (trackingfolder);
        catch
            fprintf("Folder not found\n Exiting DomeAnalyzer\n Check input requirements\n")
        end

       
        try
            fprintf("Extracting scores and perframe data\n")
            extractscoreperframe;
        catch
            fprintf("extractscoreperframe could not be run\n Skipping step\n Check if JAABAPlot was run correctly\n")
        end

        try
            fprintf("Creating interaction matrix\n")
            dnose2ell_allpair;
            anglesub_allpairs;
            angle_distance_combined_allpairs;
            interaction_matrix;
        catch
            fprintf("interaction_matrix could not be generated\n Skipping step\n Error to be troubleshooted\n")
        end

        try
            fprintf("Generating Network Parameters\n")
            network_parameters;
        catch
            fprintf("Network parameters could not be generated\n Skipping step\n Check for R code compatibility\n")
        end

        try
            fprintf("Rearranging data according to the order in headers_text_file.csv\n")
            pyrunfile("E:\FlyDome\FlyDomeAnalyzer\rearrange_Analyzed_scores.py")
        catch
            fprintf("Analyzed_scores.csv could not be generated\n Skipping step\n Check Python installation\n")
        end
    end
end

clear

