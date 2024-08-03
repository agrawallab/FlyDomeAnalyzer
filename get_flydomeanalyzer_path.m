function flydomeanalyzer_dir = get_flydomeanalyzer_path()
    % Load the path from the .mat file
    if exist('flydomeanalyzer_path.mat', 'file') == 2
        load('flydomeanalyzer_path.mat', 'flydomeanalyzer_dir');
    else
        error('Flydomeanalyzer path has not been set. Use set_flydomeanalyzer_path to set it.');
    end
end