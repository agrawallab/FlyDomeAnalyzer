load('registered_trx.mat')
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

parfor n=1:nflies
    for f=1:nflies
        if n ~= f
            anglesub_all(n).(fieldnames{f}) = anglesub_pair_custom(trx,n,f);
        end
    end
end
units = 'rad';

save('anglesub_allpairs.mat',"anglesub_all", "units")