function compileCSVFiles()
    % COMPILECSVFILES Compile multiple CSV files into a single file for each replicate
    % This function allows the user to select multiple text files. Each text file
    % contains a list of paths to CSV files. The function reads the CSV files,
    % combines their content, and saves the combined data into a new CSV file
    % for each input text file.

    % Use uigetfile to open a file dialog for selecting multiple text files
    [fileNames, filePath] = uigetfile('*.csv', 'Select compiled Fixtrax paths file for multiple replicates (Multiple can be selected)', 'MultiSelect', 'on');
    
    % Check if multiple files are selected
    if iscell(fileNames)
        inputFiles = fullfile(filePath, fileNames);
    else
        inputFiles = {fullfile(filePath, fileNames)};
    end

    % Loop through each selected input file
    for i = 1:length(inputFiles)
        inputFile = inputFiles{i};
        disp(inputFile);
        
        % Read the list of CSV file paths from the text file into a MATLAB cell array
        fid = fopen(inputFile, 'r');
        csvFilePaths = textscan(fid, '%s', 'Delimiter', '\n');
        fclose(fid);
        
        csvFilePaths = csvFilePaths{1};
        
        % Create an empty cell array to store the tables
        dataTables = {};

        % Iterate over the list of CSV file paths and read each CSV file into a table
        for j = 1:length(csvFilePaths)
            csvFilePath = strtrim(csvFilePaths{j}); % Remove any leading/trailing whitespace
            csvFile = fullfile(csvFilePath, 'Analyzed_scores.csv');
            dataTable = readtable(csvFile);
            dataTables{end+1} = dataTable; %#ok<*AGROW>
        end

        % Concatenate the tables using the MATLAB vertcat function
        combinedTable = vertcat(dataTables{:});

        % Generate the output file name
        [~, name, ~] = fileparts(inputFile);
        outputFile = fullfile(filePath, [name '_Compiled.csv']);

        % Save the combined table to a new CSV file
        writetable(combinedTable, outputFile);
    end
end
