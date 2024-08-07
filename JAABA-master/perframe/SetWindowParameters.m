function [windows,window_radii,windowi2radiusi,nradii] = SetWindowParameters(...
  windows,window_offsets,...
  window_radii,min_window_radius,...
  max_window_radius,nwindow_radii)

if isempty(windows)
  
  % use radii and offsets if windows not input
  if isempty(window_radii)
    % use min, max, n if radii not input
    window_radii = unique(round(logspace(log10(min_window_radius+1),log10(max_window_radius+1),nwindow_radii)))-1;
  end
  if isempty(window_radii)
    error('window_radii is empty.');
  end
  if isempty(window_offsets)
    error('window_offsets is empty.');
  end
  
  % take all combinations of radii and offsets
  [all_radii,all_offsets] = meshgrid(window_radii,window_offsets);
  all_radii = all_radii(:);
  all_offsets = all_offsets(:);
  
  % offsets are fractions of radii
  all_offsets = round(all_offsets.*(max(all_radii,1)));

  % window is the pair of radius, offset
  windows = [all_radii,all_offsets];

  % make sure these are unique -- rounding to nearest frame might make them
  % not unique
  windows = unique(windows,'rows');
  
  % window i for frame t is
  % [t-windows(i,1)+windows(i,2), t+windows(i,1)+windows(i,2)]
  
end

if isempty(windows)
  error('windows is empty.');
end
if size(windows,2) ~= 2
  error('windows must be nwindows x 2.');
end

[window_radii,~,windowi2radiusi] = unique(windows(:,1));
nradii = numel(window_radii);
