function generateLollipopGraph()
    % GENERATELOLLIPOPGRAPH Create a lollipop graph comparing z-scores from two CSV files
    % This function prompts the user to select two CSV files containing z-scores,
    % compares the z-scores between the two files, and plots a lollipop graph
    % with mean z-scores, standard errors of the mean (SEM), and significance
    % markers.

    % Open a file dialog to select exactly two CSV files
    [fileNames, filePath] = uigetfile('*.csv', 'Select two CSV files with Z-scores', 'MultiSelect', 'on');
    
    % Ensure exactly two files are selected
    if iscell(fileNames) && length(fileNames) == 2
        inputFiles = fullfile(filePath, fileNames);
    else
        error('Please select exactly two CSV files.');
    end

    % Read the selected CSV files into tables
    df1 = readtable(inputFiles{1});
    df2 = readtable(inputFiles{2});
    
    % Check that the tables have the same variable names (columns)
    if ~isequal(df1.Properties.VariableNames, df2.Properties.VariableNames)
        error('The selected files do not have matching columns.');
    end
    
    % Calculate the mean and SEM of z-scores for each parameter
    mean_zscores1 = mean(table2array(df1), 1);
    mean_zscores2 = mean(table2array(df2), 1);
    sem_zscores1 = std(table2array(df1), 0, 1) / sqrt(size(df1, 1));
    sem_zscores2 = std(table2array(df2), 0, 1) / sqrt(size(df2, 1));
    
    % Perform t-tests for each parameter to get p-values
    [~, p_values] = arrayfun(@(i) ttest2(table2array(df1(:,i)), table2array(df2(:,i))), 1:width(df1));

    % Replace underscores with spaces in parameter names for better readability
    parameterNames = strrep(df1.Properties.VariableNames, '_', ' ');

    % Replace underscores with spaces in file names for legend
    legendNames = strrep(fileNames, '_', ' ');

    % Create the lollipop graph
    createLollipopGraph(parameterNames, mean_zscores1, sem_zscores1, mean_zscores2, sem_zscores2, p_values, legendNames);
end

function createLollipopGraph(parameterNames, zscores1, sem1, zscores2, sem2, p_values, legendNames)
    % CREATELOLLIPOPGRAPH Plot a lollipop graph comparing z-scores
    % This function generates a lollipop graph to visualize and compare the
    % z-scores from two different datasets, including mean z-scores, SEM,
    % and significance markers.

    % Convert parameter names to categorical for plotting
    y = categorical(parameterNames);
    y = reordercats(y, parameterNames);

    % Create a new figure for the plot
    figure;
    
    % Hold on to overlay multiple plots
    hold on;
    
    % Plot faint horizontal dotted lines for reference
    for i = 1:length(y)
        plot([-2, 2], [y(i), y(i)], 'Color', [0.9, 0.9, 0.9], 'LineStyle', ':'); % Faint dotted lines
        
        % Plot points with error bars for the first set of z-scores
        plot(zscores1(i), y(i), 'bo', 'MarkerFaceColor', 'b');
        line([zscores1(i) - sem1(i), zscores1(i) + sem1(i)], [y(i), y(i)], 'Color', 'b', 'LineWidth', 2); % Thick horizontal error bars
        
        % Plot points with error bars for the second set of z-scores
        plot(zscores2(i), y(i), 'ro', 'MarkerFaceColor', 'r');
        line([zscores2(i) - sem2(i), zscores2(i) + sem2(i)], [y(i), y(i)], 'Color', 'r', 'LineWidth', 2); % Thick horizontal error bars
        
        % Add asterisk for significant p-values
        if p_values(i) < 0.05
            % Determine position for the asterisk for better visibility
            x_position = max([zscores1(i) + sem1(i), zscores2(i) + sem2(i)]) + 0.1; % Offset
            text(x_position, y(i), '*', 'FontSize', 12, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', 'k');
        end
    end

    % Set x-axis limits
    xlim([-2, 2]);
    
    % Add labels and title
    xlabel('Z-Score');
    ylabel('Parameters');
    title('Lollipop Graph of Z-Scores');
    
    % Add legend with colored dots
    h1 = plot(nan, nan, 'bo', 'MarkerFaceColor', 'b');
    h2 = plot(nan, nan, 'ro', 'MarkerFaceColor', 'r');
    legend([h1, h2], legendNames, 'Location', 'Best');

    % Disable default grid
    grid off;
    
    % Release hold on the plot
    hold off;
end
