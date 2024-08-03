function set_flydomeanalyzer_path
    flydomeanalyzer_dir = uigetdir;
    save('flydomeanalyzer_path.mat', 'flydomeanalyzer_dir');
    disp(['Flydomeanalyzer path set to: ', flydomeanalyzer_dir ]);
end
