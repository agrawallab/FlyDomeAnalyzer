load('angle_distance_combined_allpairs.mat')
load('registered_trx.mat')

%Getting number of flies from the trx variable of registered_trx.mat
nflies = length(trx);

%Generating fieldnames: Fly1, Fly2,.....
fieldnames = [];
for n = 1:nflies
    flyname = append('Fly',string(n));
    fieldnames = [fieldnames, flyname];
end

%Extracting the number frames and making sure the maximum number across
%different flies is taken
nframes = length(trx(1).x);
for n = 1:nflies
    if nframes > length(trx(n).x)
        nframes = length(trx(n).x);
    end
end

% Interaction definition and parameters from Galit's paper: Change accordingly if required
minimum_frames_for_interaction = 60;
minimuum_numberof_gap_frames = 120;

max_interaction_possible_frames = (nframes-minimum_frames_for_interaction)/(minimum_frames_for_interaction+minimuum_numberof_gap_frames) + 1;

parfor n=1:nflies
    for f=1:nflies
        if n ~= f
            current_interaction_start = 0;
            current_interaction_end = 0;
            consecutive_zeroes = 0;
            current_interaction_ones = 0;
            total_interaction_frames = 0;
            total_numberof_interactions = 0;
            
            for frame = 1:nframes
                if angle_distance_combined_all(n).(fieldnames{f})(frame) == 0
                    consecutive_zeroes = consecutive_zeroes + 1;
                    if consecutive_zeroes == 120
                         current_interaction_end = frame-120;
                    end  
                end
                
                if angle_distance_combined_all(n).(fieldnames{f})(frame) == 1
                    if consecutive_zeroes < 120
                        current_interaction_ones = current_interaction_ones + 1;
                        total_interaction_frames = total_interaction_frames + 1;
                    end
                    if consecutive_zeroes >= 120
                        if current_interaction_ones > 60
                            %fprintf('%d, %d, %d, %d\n', current_interaction_start, current_interaction_end, current_interaction_ones, consecutive_zeroes);
                            total_numberof_interactions = total_numberof_interactions + 1;
                        end 
                        current_interaction_start = frame;
                        current_interaction_ones = 0;
                    end
                    consecutive_zeroes = 0;
                end
  
            end
            interaction_frames_allpairs(n).(fieldnames{f}) = total_interaction_frames/nframes;
            interaction_numbers_allpairs(n).(fieldnames{f}) = total_numberof_interactions/max_interaction_possible_frames;
            
        end
        if n == f
            interaction_frames_allpairs(n).(fieldnames{f}) = 0;
            interaction_numbers_allpairs(n).(fieldnames{f}) = 0;
        end
    end
end
fly = struct2cell(interaction_frames_allpairs);
csvfile = table(fly);
writetable(csvfile, 'interactionmatrix_LOI.csv')

clear fly;
fly = struct2cell(interaction_numbers_allpairs);
csvfile = table(fly);
writetable(csvfile, 'interactionmatrix_NOI.csv')

save('interaction_frames_allpairs.mat',"interaction_frames_allpairs")
save('interaction_numbers_allpairs.mat',"interaction_numbers_allpairs")


