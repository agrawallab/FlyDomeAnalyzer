% Load the original CSV file into a table
df = readtable('Analyzed_scores.csv');

% Read the desired order of column headers from a text file
fid = fopen('E:/NPS/Codes/Flybubble/headers_text_file.txt', 'r');
desired_order = textscan(fid, '%s', 'Delimiter', ',');
desired_order = desired_order{1};
fclose(fid);

% Add missing fields with NaN values
missing_cols = setdiff(desired_order, df.Properties.VariableNames);
for col = missing_cols
    df.col{1} = NaN;
end

% Rearrange columns based on the desired order
df_reordered = df(:, desired_order);

% Save the rearranged table to a new CSV file
writetable(df_reordered, 'Analyzed_scores.csv', 'Delimiter', ',');

disp('Script executed successfully.');