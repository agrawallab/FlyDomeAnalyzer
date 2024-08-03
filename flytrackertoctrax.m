%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%flytrackertoctrax - This code converts theh trx.mat format into a ctrax%
%movie.mat output format to make it compatible with FixTrax% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Running flytackertoctrax\n')

%Loading the trx.mat file from the output of FlyTracker
load('trx.mat')

%Getting total number of flies
nflies = length(trx);

% Some flies are tracked for a few frames less for some reason, so getting
% the maximum number of frames.
nframes = length(trx(1).x);
for n = 1:nflies
    if nframes > length(trx(n).x)
        nframes = length(trx(n).x);
    end
end

% Getting x_pos of each of the fly
x_pos=[];
parfor n=1:nframes
    for f=1:nflies
        x_pos = [x_pos,trx(f).x(n)];
    end
end
x_pos = transpose(x_pos);
fprintf('x_pos derived\n')

y_pos=[];
parfor n=1:nframes
    for f=1:nflies
        y_pos = [y_pos,trx(f).y(n)];
    end
end
y_pos = transpose(y_pos);
fprintf('y_pos derived\n')

timestamps_new =[];
parfor n=1:nframes
    timestamps_new = [timestamps_new,timestamps(n)];
end
timestamps = transpose(timestamps_new);
fprintf('timestamps derived\n')

maj_ax=[];
parfor n=1:nframes
    for f=1:nflies
        maj_ax = [maj_ax,trx(f).a(n)];
    end
end
maj_ax = transpose(maj_ax);
fprintf('maj_ax derived\n')

min_ax=[];
parfor n=1:nframes
    for f=1:nflies
        min_ax = [min_ax,trx(f).b(n)];
    end
end
min_ax = transpose(min_ax);
fprintf('min_ax derived\n')

ntargets=[];
parfor n=1:nframes
     ntargets = [ntargets, nflies];
end
ntargets = transpose(ntargets);
fprintf('ntargets derived\n')

identity =[];
parfor n=1:nframes
    for f=1:nflies
        identity = [identity,f-1];
    end
end
identity = transpose(identity);
fprintf('identity derived\n')

angle=[];
parfor n=1:nframes
    for f=1:nflies
        angle = [angle,trx(f).theta(n)];
    end
end
angle = transpose(angle);
fprintf('angle derived\n')

startframe = 0;

%flipped variable determines how the FixTrax code percieves these
%movie.mat. Basically the points of tracking are sometimes thhe mirror
%image of the flies in the video - Do not change this unless absolutely
%required if running data from FlyTracker
flipped = 1;

save('movie.mat', 'timestamps', 'x_pos', 'y_pos', 'ntargets', 'min_ax', 'maj_ax', 'identity', 'angle', 'startframe', 'flipped')

fprintf('Conversion from trx.mat to movie.mat successful\n')





