function options_def = DefaultOptions()

% default options
options_def.granularity = 10000;
options_def.num_chunks  = [];
options_def.num_cores   = 1;
options_def.max_minutes = inf;
options_def.fr_samp     = 100;
options_def.save_JAABA  = false;
options_def.save_xls    = false;
options_def.save_seg    = false;
options_def.f_parent_calib = '';
options_def.force_calib = false;
options_def.expdir_naming = false;
options_def.isdisplay = true;
options_def.force_tracking = false;
options_def.force_all = false;
options_def.force_features = false;
options_def.startframe = 1;