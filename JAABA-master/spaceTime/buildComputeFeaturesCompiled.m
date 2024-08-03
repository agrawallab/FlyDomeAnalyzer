% Uncomment below if "cannot figure out class error"
% http://in.mathworks.com/matlabcentral/answers/137332-error-using-matlab-compiler-app-applicationcompiler-dependency-analysis

% f = dir(fullfile(matlabroot, 'toolbox', 'slvnv'));
% for i=1:length(f)
% rmpath(fullfile(matlabroot, 'toolbox', 'slvnv', f(i).name));
% end
% 

mcc -o computeFeaturesCompiled -W main:computeFeaturesCompiled ...
  -T link:exe -d /home/mayank/work/FlySpaceTime/code/ ...
  -v /home/mayank/work/FlySpaceTime/code/computeFeaturesCompiled.m ...
  -a /home/mayank/work/FlySpaceTime/code/deepmatching/deepmex.mexa64 ...
  -a /home/mayank/work/FlySpaceTime/code/filehandling ...
  -a /home/mayank/work/FlySpaceTime/code/misc ...
  -a /home/mayank/work/FlySpaceTime/code/optflow_deqing ...
  -a /home/mayank/work/FlySpaceTime/code/toolbox 

delete('readme.txt')
delete('mccExcludedFiles.log')
delete('requiredMCRProducts.txt')
delete('PackagingLog.txt')
