% Define the path to your Rscript executable (adjust the path accordingly)
rscriptPath = 'C:\PROGRA~1\R\R-4.3.2\bin\Rscript.exe';

% Define the path to your R code
rCodePath = 'E:\NPS\Codes\Flybubble\network_parameters.R';

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
