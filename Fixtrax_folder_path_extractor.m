function Fixtrax_folder_path_extractor()
    % Fixtrax Folder Path Extractor MATLAB script

    % Select the parent folder
    input_folder = uigetdir('', 'Select the parent folder from which you want to extract the paths of all the Fixtrax folders');
    
    if input_folder == 0
        disp('No folder selected. Exiting...');
        return;
    end
    
    output_file_path = fullfile(input_folder, 'Fixtrax_paths.csv');
    fid = fopen(output_file_path, 'w');
    if fid == -1
        error('Cannot create output file.');
    end

    % Uncomment one of the following blocks according to your use case:

    % For 1 Day's experiments
    subdirs = dir(input_folder);
    subdirs = subdirs([subdirs.isdir]); % Filter out non-directories
    subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'})); % Remove '.' and '..'
    
    for i = 1:length(subdirs)
        subdir_path = fullfile(input_folder, subdirs(i).name);
        folders = dir(subdir_path);
        folders = folders([folders.isdir]); % Filter out non-directories
        folders = folders(~ismember({folders.name}, {'.', '..'})); % Remove '.' and '..'
        
        for j = 1:length(folders)
            folder_path = fullfile(subdir_path, folders(j).name);
            if contains(folders(j).name, 'Fixtrax')
                line = sprintf('%s, test, FF0000\n', folder_path);
                fprintf(fid, '%s', line);
            end
        end
    end

    % % For Combined of multiple day's experiments
    % dirs = dir(input_folder);
    % dirs = dirs([dirs.isdir]); % Filter out non-directories
    % dirs = dirs(~ismember({dirs.name}, {'.', '..'})); % Remove '.' and '..'
    % 
    % for i = 1:length(dirs)
    %     dir_path = fullfile(input_folder, dirs(i).name);
    %     subdirs = dir(dir_path);
    %     subdirs = subdirs([subdirs.isdir]); % Filter out non-directories
    %     subdirs = subdirs(~ismember({subdirs.name}, {'.', '..'})); % Remove '.' and '..'
    %     
    %     for j = 1:length(subdirs)
    %         subdir_path = fullfile(dir_path, subdirs(j).name);
    %         folders = dir(subdir_path);
    %         folders = folders([folders.isdir]); % Filter out non-directories
    %         folders = folders(~ismember({folders.name}, {'.', '..'})); % Remove '.' and '..'
    %         
    %         for k = 1:length(folders)
    %             folder_path = fullfile(subdir_path, folders(k).name);
    %             if contains(folders(k).name, 'Fixtrax')
    %                 line = sprintf('%s, test, FF0000\n', folder_path);
    %                 fprintf(fid, '%s', line);
    %             end
    %         end
    %     end
    % end
    
    fclose(fid);
    disp('A text file containing all the paths to the Fixtrax folders in the given directory has been made');
end
