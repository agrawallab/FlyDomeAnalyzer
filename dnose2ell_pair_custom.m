function d = dnose2ell_pair_custom(trx, fly1, fly2, istry)

% DNose2Ell_Pair_Custom Calculate the distance between a fly's nose and an ellipse
% for two different flies over overlapping frames. The distance is calculated
% using a custom function `ellipsedist_hack` and returns an array of distances.

nsamples = 20; % Number of samples used for distance calculation

% Initialize the distance array with NaN values
d = nan(1, trx(fly1).nframes);

% Determine the overlapping time frames between the two flies
t0 = max(trx(fly1).firstframe, trx(fly2).firstframe);
t1 = min(trx(fly1).endframe, trx(fly2).endframe);

% If there is no overlap, exit the function
if t1 < t0
    return;
end

% Calculate the position of the nose of fly1
xnose = trx(fly1).x_mm + 2 * trx(fly1).a_mm .* cos(trx(fly1).theta_mm);
ynose = trx(fly1).y_mm + 2 * trx(fly1).a_mm .* sin(trx(fly1).theta_mm);

% Get the ellipse parameters for fly2
x_mm1 = trx(fly2).x_mm;
y_mm1 = trx(fly2).y_mm;
a_mm1 = trx(fly2).a_mm;
b_mm1 = trx(fly2).b_mm;
theta_mm1 = trx(fly2).theta_mm;

% Offsets for the frames
off2 = trx(fly2).off;
off1 = trx(fly1).off;

% Determine the frames to process
if nargin < 4
    tstry = t0:t1; % Use the full overlap range if no specific frames are provided
else
    tstry = istry(:)' - off1; % Use the provided specific frames adjusted for fly1's offset
end

% Loop through each frame in the specified range
for t = tstry
    i = t + off2; % Adjust the frame index for fly2
    j = t + off1; % Adjust the frame index for fly1
    % Calculate the distance using the custom `ellipsedist_hack` function
    d(i) = ellipsedist_hack(x_mm1(i), y_mm1(i), ...
        2 * a_mm1(i), 2 * b_mm1(i), theta_mm1(i), ...
        xnose(j), ynose(j), nsamples);
end
