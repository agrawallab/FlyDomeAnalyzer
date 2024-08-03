% Load necessary data files
load('registered_trx.mat')  % Contains tracking data
load('anglesub_allpairs.mat')  % Contains angle data for all pairs of flies
load('dnose2ell_allpairs.mat')  % Contains nose-to-ellipse distance data for all pairs of flies

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

% Initialize sum variable to count certain conditions
sum = 0;

% Preallocate the angle_distance_combined_all structure
angle_distance_combined_all(nflies).Fly1 = [];

% Parallel loop over all flies
parfor n = 1:nflies
    % Loop over all other flies
    for f = 1:nflies
        if n ~= f  % Exclude self-pairs
            % Loop over all frames
            for frame = 1:nframes
                % Check angle and distance conditions
                if anglesub_all(n).(fieldnames{f})(frame) > 0
                    if nose2ell_all(n).(fieldnames{f})(frame) < 8
                        % Set condition flag and increment sum
                        angle_distance_combined_all(n).(fieldnames{f})(frame) = 1;
                        sum = sum + 1;
                    else
                        % Set condition flag
                        angle_distance_combined_all(n).(fieldnames{f})(frame) = 0;
                    end
                else
                    % Set condition flag
                    angle_distance_combined_all(n).(fieldnames{f})(frame) = 0;
                end
            end
        end
    end
end

% Display the total sum of conditions met
disp(sum);

% Save the combined angle-distance data to a .mat file
save('angle_distance_combined_allpairs.mat', "angle_distance_combined_all")
