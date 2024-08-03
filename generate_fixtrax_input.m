function generate_fixtrax_input()
    % Generate Fixtrax Input MATLAB script
    
    % Selecting the folder
    input_folder = uigetdir('', 'Select the folder containing all the recordings tracked with FlyTracker to create input folders for Fixtrax');
    
    if input_folder == 0
        disp('No folder selected. Exiting...');
        return;
    end

    % Iterate through directories
    input_dirs = dir(input_folder);
    input_dirs = input_dirs([input_dirs.isdir]); % Filter out non-directories
    input_dirs = input_dirs(~ismember({input_dirs.name}, {'.', '..'})); % Remove '.' and '..'
    
    for i = 1:length(input_dirs)
        dir_path = fullfile(input_folder, input_dirs(i).name);
        if isfolder(dir_path)
            subdirs = dir(dir_path);
            
            moviefile = '';
            moviefileextension = '';
            for j = 1:length(subdirs)
                if contains(subdirs(j).name, '.mp4')
                    [~, moviefile, moviefileextension] = fileparts(subdirs(j).name);
                    moviepath = fullfile(dir_path, subdirs(j).name);
                    break;
                end
            end
            
            subdirs = subdirs([subdirs.isdir]); % Filter out non-directories
            subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'})); % Remove '.' and '..'

            % Find movie file in the current directory
            

            for j = 1:length(subdirs)
                subdir_path = fullfile(dir_path, subdirs(j).name);
                if isfolder(subdir_path)
                    folders = dir(subdir_path);
                    folders = folders([folders.isdir]); % Filter out non-directories
                    folders = folders(~ismember({folders.name}, {'.', '..'})); % Remove '.' and '..'

                    for k = 1:length(folders)
                        folder_path = fullfile(subdir_path, folders(k).name);
                        if isfolder(folder_path)
                            cd(folder_path);
                            disp(['Working on ', folder_path]);

                            try
                                flytrackertoctrax();
                            catch
                                disp('Please add flytrackertoctrax MATLAB script to the path in MATLAB');
                                return;
                            end

                            % Move movie.mat and create annotation file
                            mat_files = dir(fullfile(folder_path, 'movie.mat'));
                            if ~isempty(mat_files)
                                new_path = fullfile(dir_path, 'Fixtrax');
                                if ~isfolder(new_path)
                                    mkdir(new_path);
                                    disp('Fixtrax directory created');
                                else
                                    disp('Fixtrax directory already exists');
                                end

                                output_file_path = fullfile(new_path, 'movie.mp4.ann');
                                if ~isfile(output_file_path)
                                    fid = fopen(output_file_path, 'w');
                                    fprintf(fid, 'Ctrax header\nversion:0.5.18\n\nend header');
                                    fclose(fid);
                                    disp('Empty annotation file created');
                                else
                                    disp('Annotation file already exists');
                                end

                                new_name = fullfile(new_path, 'movie.mat');
                                try
                                    movefile(fullfile(folder_path, 'movie.mat'), new_name);
                                    disp('movie.mat moved to Fixtrax folder');
                                catch
                                    disp('movie.mat already exists');
                                end

                                % Renaming the video file to movie.mp4
                                new_movie_name = fullfile(new_path, ['movie', moviefileextension]);
                                try
                                    movefile(moviepath, new_movie_name);
                                    disp('movie file renamed and moved to Fixtrax folder');
                                catch
                                    disp('movie not found or already moved');
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
