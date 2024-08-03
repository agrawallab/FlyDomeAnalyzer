% Define the path to your Rscript executable (adjust the path accordingly)
rscriptPath = strcat(get_flydomeanalyzer_path, '\R-4.4.0\bin\Rscript.exe')

% Define the path to your R code
rCodePath = strcat(get_flydomeanalyzer_path, '\network_parameters.R');

% Create the command to run the R script
command = [rscriptPath, ' ', rCodePath];

% Execute the R script from MATLAB
[status, result] = system(command);

% Check the status of the execution
if status == 0
    disp('R script executed successfully.');
else
    disp('Error executing R script.');
    disp(result); % Display the error message
end

