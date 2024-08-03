%%%%%% Extracting score percentages for individual flies %%%%%%

%Get all the mat files
myFiles = dir('*.mat');
Compiled = [];
colnames = {};
for k = 1:length(myFiles)
    %Filter out the score files and loop through them
    if contains(myFiles(k).name, "scores") 
        colnames{end+1} = erase(erase(erase(myFiles(k).name, '.mat'),"scores"),"_"); 
        load(myFiles(k).name);
        percents = [];
        %Loop through the number of flies
        parfor n = 1:length(allScores.scores)
            % No. of frame showing behaviour divided by total number of frames
            percentage = mean(allScores.postprocessed{n})*100; 
            percents = [percents, percentage]; 
        end
        % Compile percentages of different behaviours
        Compiled = [Compiled; percents];
    else
    end
end

%%%%%% Extracting score frequencies for individual flies %%%%%%

%Get all the mat files
myFiles = dir('*.mat');
for k = 1:length(myFiles)
    %Filter out the score files and loop through them
    if contains(myFiles(k).name, "scores")
        %fprintf(myFiles(k).name + "\n")
        colnames{end+1} = strcat(erase(erase(erase(myFiles(k).name, '.mat'),"scores"),"_"),' frequency');
        load(myFiles(k).name);
        freqs = [];
        %Loop through the number of flies
        parfor n = 1:length(allScores.scores)
            % No. of bouts showing behaviour divide by total number of minutes hardcoded to 20 (Change if required) 
            freq = length(allScores.t0s{1,n})/20;
            freqs = [freqs, freq];
        end
        % Compile bout frequencies of different behaviours
        Compiled = [Compiled; freqs];
    else
    end
end

%%%%%% Extracting score bout length for individual flies %%%%%%

%Get all the mat files
myFiles = dir('*.mat');
for k = 1:length(myFiles)
    %Filter out the score files and loop through them
    if contains(myFiles(k).name, "scores")
        fprintf(myFiles(k).name + "\n")
        colnames{end+1} = strcat(erase(erase(erase(myFiles(k).name, '.mat'),"scores"),"_"),' bout length');
        load(myFiles(k).name);
        boutlens = [];
        %Loop through the number of flies
        parfor n = 1:length(allScores.scores)
            % Average bout length of each fly - t1s -t0s 
            avgboutlen = mean(allScores.t1s{1,n}-allScores.t0s{1,n});
            boutlens = [boutlens, avgboutlen];
        end
        % Compile bout frequencies of different behaviours
        Compiled = [Compiled; boutlens];
    else
    end
end

%%%%%% Extracting average perframe features of individual flies %%%%%%

%List all the perframe features you want to extract data for in this variable
perframes = {'absdtheta.mat', 'anglesub.mat', 'velmag.mat', 'danglesub.mat', 'nflies_close.mat', 'dist2wall.mat', 'ddcenter.mat', 'dcenter.mat', 'dphi.mat', 'anglefrom1to2_anglesub.mat', 'dtheta.mat', 'anglefrom1to2_nose2ell.mat', 'absphidiff_anglesub.mat', 'absphidiff_nose2ell.mat','absthetadiff_nose2ell.mat', 'angleonclosestfly.mat', 'absthetadiff_anglesub.mat', 'absanglefrom1to2_nose2ell'};
for n=1:length(perframes)
    perframevals = [];
    %Loading all the files mentioned above from the perframe directory
    load (strcat("perframe/", perframes{n}));
    %Adding column names as perframe features
    colnames{end+1} = erase(perframes{n}, '.mat');
    parfor m = 1:length(data);
        averageperframevals = mean(data{1,m});
        perframevals = [perframevals, averageperframevals];
    end 
    Compiled = [Compiled; perframevals];
end

Compiled = Compiled.';

%Giving column names as flies with numbers
try
    rownames = [];
    for n = 1:length(allScores.scores)
        rownames = [rownames, "Fly" + int2str(n)];
    end
catch
end

% Make a 2D array
Compiled_table = array2table(Compiled, "RowNames", rownames, "VariableNames",colnames);
% Write to excel file
writetable(Compiled_table,"Analyzed_Scores.csv","WriteRowNames",1, "WriteVariableNames",1);
