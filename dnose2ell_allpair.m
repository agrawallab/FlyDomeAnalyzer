function calculateDistanceMetrics()
    % CALCULATEDISTANCEMETRICS Compute distances between flies for all pairs
    % This function calculates the distance between the noses and ellipses
    % of all pairs of flies and saves the results to a MAT file.

    % Load the data from the specified MAT file
    load('registered_trx.mat');
    nflies = length(trx); % Number of flies

    % Generate field names for each fly
    fieldnames = [];
    for n = 1:nflies
        flyname = append('Fly', string(n)); % Create field name for each fly
        fieldnames = [fieldnames, flyname];
    end

    % Determine the minimum number of frames across all flies
    nframes = length(trx(1).x);
    for n = 1:nflies
        if nframes > length(trx(n).x)
            nframes = length(trx(n).x); % Update nframes to the minimum across all flies
        end
    end

    % Calculate the distance metrics for all pairs of flies
    parfor n = 1:nflies % Parallel loop for efficiency
        for f = 1:nflies
            if n ~= f
                % Compute the distance between noses and ellipses for each pair of flies
                nose2ell_all(n).(fieldnames{f}) = dnose2ell_pair_custom(trx, n, f);
            end
        end
    end

    % Specify the units of measurement
    units = 'mm';

    % Save the results to a MAT file
    save('dnose2ell_allpairs.mat', 'nose2ell_all', 'units');
end
