% Load the CSV file into a table (equivalent to DataFrame in Python)
filename = 'Analyzed_scores.csv';
df = readtable(filename,VariableNamingRule="preserve");

% Read the column headers from the text file into a cell array
headers_file = strcat(get_flydomeanalyzer_path, '\headers_text_file.csv');

% Check if file exists
if exist(headers_file, 'file') ~= 2
    error('File %s does not exist.', headers_file);
end

% Open file for reading
fid = fopen(headers_file, 'r');
if fid == -1
    error('Unable to open file %s for reading.', headers_file);
end

% Read headers into a cell array
try
    headers_cell = textscan(fid, '%s', 'Delimiter', '\n');
    fclose(fid);  % Close file after reading
    desired_order = headers_cell{1};
catch ME
    fclose(fid);  % Ensure file is closed if an error occurs
    rethrow(ME);  % Rethrow the exception to see the error message
end

% Add missing fields with NaN values
existing_columns = df.Properties.VariableNames;
for i = 1:length(desired_order)
    if ~ismember(desired_order{i}, existing_columns)
        df.(desired_order{i}) = NaN(height(df), 1); % Use NaN for clarity and consistency with MATLAB
    end
end

% Rearrange columns based on desired order
df_reordered = df(:, desired_order);

% Save the rearranged table to a new CSV file
output_filename = 'Analyzed_scores.csv';
writetable(df_reordered, output_filename);
