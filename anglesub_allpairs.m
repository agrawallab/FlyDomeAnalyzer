% Load the tracking data
load('registered_trx.mat')  % Contains tracking data

% Get the number of flies
nflies = length(trx);

% Initialize an empty cell array to store field names
fieldnames = [];

% Generate field names for each fly
for n = 1:nflies
    flyname = append('Fly', string(n));
    fieldnames = [fieldnames, flyname];
end

% Determine the minimum number of frames across all flies
nframes = length(trx(1).x);
for n = 1:nflies
    if nframes > length(trx(n).x)
        nframes = length(trx(n).x);
    end
end

% Preallocate the anglesub_all structure
anglesub_all(nflies).Fly1 = [];

% Parallel loop over all flies
parfor n = 1:nflies
    % Loop over all other flies
    for f = 1:nflies
        if n ~= f  % Exclude self-pairs
            % Calculate the angle difference for each fly pair and store it
            anglesub_all(n).(fieldnames{f}) = anglesub_pair_custom(trx, n, f);
        end
    end
end

% Specify the units of the angle data
units = 'rad';

% Save the angle differences and units to a .mat file
save('anglesub_allpairs.mat', "anglesub_all", "units")
