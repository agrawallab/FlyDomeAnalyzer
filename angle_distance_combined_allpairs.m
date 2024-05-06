load('registered_trx.mat')
load("anglesub_allpairs.mat")
load("dnose2ell_allpairs.mat")
nflies = length(trx);

fieldnames = [];
for n = 1:nflies
    flyname = append('Fly',string(n));
    fieldnames = [fieldnames, flyname];
end

nframes = length(trx(1).x);
for n = 1:nflies
    if nframes > length(trx(n).x)
        nframes = length(trx(n).x);
    end
end

sum = 0;

parfor n=1:nflies
    for f=1:nflies
        if n ~= f
            for frame = 1:nframes
                if anglesub_all(n).(fieldnames{f})(frame) > 0
                    if nose2ell_all(n).(fieldnames{f})(frame) < 8
                        angle_distance_combined_all(n).(fieldnames{f})(frame) = 1;
                        sum = sum + 1;
                    else
                        angle_distance_combined_all(n).(fieldnames{f})(frame) = 0;
                    end
                else
                    angle_distance_combined_all(n).(fieldnames{f})(frame) = 0;
                end
            end
        end
    end
end

sum;

save('angle_distance_combined_allpairs.mat',"angle_distance_combined_all")