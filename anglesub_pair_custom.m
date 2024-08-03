function anglesub = anglesub_pair_custom(trx, fly1, fly2)
% ANGLESUB_PAIR_CUSTOM Calculate the subtended angle between two flies
%   anglesub = anglesub_pair_custom(trx, fly1, fly2) computes the subtended
%   angle between fly1 and fly2 over their overlapping frames.

% Initialize the anglesub array with NaNs
anglesub = nan(1, trx(fly1).nframes);

% Get the start and end frames of overlap
t0 = max(trx(fly1).firstframe, trx(fly2).firstframe);
t1 = min(trx(fly1).endframe, trx(fly2).endframe);

% If there is no overlap, return
if t1 < t0
    return;
end

% Extract positional and orientation data for fly1
x_mm1 = trx(fly1).x_mm;
y_mm1 = trx(fly1).y_mm;
a_mm1 = trx(fly1).a_mm;
b_mm1 = trx(fly1).b_mm;
theta_mm1 = trx(fly1).theta_mm;

% Extract positional and orientation data for fly2
x_mm2 = trx(fly2).x_mm;
y_mm2 = trx(fly2).y_mm;
a_mm2 = trx(fly2).a_mm;
b_mm2 = trx(fly2).b_mm;
theta_mm2 = trx(fly2).theta_mm;

% Define the field of view
fov = pi;

% Get the offset values for each fly
off1 = trx(fly1).off;
off2 = trx(fly2).off;

% Loop over each overlapping frame
for t = t0:t1
    % Adjust indices for the offset
    i = t + off1;
    j = t + off2;
    
    % Calculate the subtended angle at time t and store in anglesub
    anglesub(i) = anglesubtended(...
        x_mm1(i), y_mm1(i), 2*a_mm1(i), 2*b_mm1(i), theta_mm1(i), ...
        x_mm2(j), y_mm2(j), 2*a_mm2(j), 2*b_mm2(j), theta_mm2(j), ...
        fov);
end
end
