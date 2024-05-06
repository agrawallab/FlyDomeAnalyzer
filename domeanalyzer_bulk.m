parent_dir = uigetdir;
myfolders = dir(parent_dir);

fprintf("generating compiled score parameters and perframe features\n")

for n = 3:length(myfolders)
    if myfolders(n).isdir()
        myfolders(n)
        mysubfolders = dir(strcat(myfolders(n).folder, '/',myfolders(n).name))
        for f = 3:length(mysubfolders)
            if mysubfolders(f).isdir()
                trackingfolder = strcat(mysubfolders(f).folder,'\',mysubfolders(f).name,'/FixTrax')
                
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
    end
end

clear

