function calculateZScores()
    % CALCULATEZSCORES Calculate z-scores for two CSV files and save results
    % This function allows the user to select two CSV files containing 
    % compiled scores for Test and Control groups. It calculates the z-scores 
    % for each column and saves the results to new CSV files.
    
    % Open a file dialog for selecting multiple files
    [fileNames, filePath] = uigetfile('*.csv', 'Select compiled score files of Test and Control', 'MultiSelect', 'on');
    
    % Check if multiple files are selected
    if iscell(fileNames)
        inputFiles = fullfile(filePath, fileNames);
    else
        inputFiles = {fullfile(filePath, fileNames)};
    end

    % Display the selected files
    disp(inputFiles);
    
    % Read the CSV files into tables
    df1 = readtable(inputFiles{1}, 'HeaderLines', 0);
    df2 = readtable(inputFiles{2}, 'HeaderLines', 0);
    
    % Remove the first column from the tables
    df1(:, 1) = [];
    df2(:, 1) = [];

    % Calculate the z-scores for each table
    [df_zscore1, df_zscore2] = calculateZScoresForTables(df1, df2);
    
    % Write the z-scores to new CSV files
    writetable(df_zscore1, strrep(inputFiles{1}, '.csv', '_zscores.csv'), 'WriteVariableNames', true);
    writetable(df_zscore2, strrep(inputFiles{2}, '.csv', '_zscore.csv'), 'WriteVariableNames', true);
end

function [df_zscore1, df_zscore2] = calculateZScoresForTables(df1, df2)
    % CALCULATEZSCORESFORTABLES Calculate z-scores for combined dataframes
    % This function concatenates the dataframes df1 and df2, calculates the 
    % z-scores for each column, and then splits the z-scores into two 
    % separate dataframes.
    
    % Concatenate the dataframes
    df = [df1; df2];
    
    % Calculate the z-scores for each column
    df_zscore = array2table(zscore(table2array(df)), 'VariableNames', df.Properties.VariableNames);
    
    % Split the z-scores back into two dataframes
    df_zscore1 = df_zscore(1:size(df1, 1), :);
    df_zscore2 = df_zscore(size(df1, 1) + 1:end, :);
end

function z = zscore(x)
    % ZSCORE Calculate z-scores
    % This function calculates the z-scores for the input array x. The 
    % z-score is defined as (x - mu) / sigma, where mu is the mean of x and 
    % sigma is the standard deviation of x.
    
    % Calculate the mean and standard deviation of x
    mu = mean(x);
    sigma = std(x);
    
    % Calculate the z-scores
    z = (x - mu) ./ sigma;
end
