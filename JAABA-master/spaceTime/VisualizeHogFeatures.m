function VisualizeHogFeatures(bdir,fly,fnum,varargin)
% function VisualizeHogFeatures(expdir,fly,fnum,'jabfile',jabfile)

[moviename,trxfilename,params,jabfile] = myparse(varargin,...
  'moviename','movie.ufmf','trxfilename','trx.mat','params',getSTParams,...
  'jabfile','');

if ~isempty(jabfile)
   J = load(jabfile,'-mat');
   moviename = J.x.file.moviefilename;
   trxfilename = J.x.file.trxfilename;
   params = J.x.stInfo;
end

moviename = fullfile(bdir,moviename);
trackfilename = fullfile(bdir,trxfilename);

fname = 'hf';
%% params
psize = params.psize;
nbins = params.nbins; 
npatches_x = params.npatches_x;
npatches_y = params.npatches_y;
patchsz_x = psize*npatches_x;
patchsz_y = psize*npatches_y;
wd = params.wd;
scale = params.scale;

%% compute the bins

% this seems to be what the centers correspond to
bincenters = linspace(0,pi,nbins+1);
bincenters = bincenters(1:nbins);
dt = mean(diff(bincenters));
binedges = [bincenters(1)-dt/2,(bincenters(1:end-1)+bincenters(2:end))/2,bincenters(end)+dt/2];


%% 

tracks = load(trackfilename);
tracks = tracks.trx;

[readfcn,nframes,fid,headerinfo] = get_readframe_fcn(moviename);
im1 = readfcn(fnum);

trackndx = fnum - tracks(fly).firstframe + 1;
% locy = round(tracks(fly).y(trackndx));
% locx = round(tracks(fly).x(trackndx));
% im1 = extractPatch(im1,...
%   locy,locx,tracks(fly).theta(trackndx),patchsz);
locy = tracks(fly).y(trackndx);
locx = tracks(fly).x(trackndx);
im1 = CropImAroundTrx(im1,...
  locx,locy,tracks(fly).theta(trackndx)-pi/2,(patchsz_x-1)/2,(patchsz_y-1)/2);

H = zeros(npatches_y,npatches_x,nbins);
firstframe = tracks(fly).firstframe;
parfor yy = 1:npatches_y
  for xx = 1:npatches_x
    for oo = 1:nbins
      pfname = fullfile(bdir,'perframe',sprintf('st_%s_%02d_%02d_%d.mat',fname,yy,xx,oo));
      q = load(pfname);
      trackndx = fnum - firstframe + 1;
      H(yy,xx,oo) = q.data{fly}(trackndx);
      
    end
  end
end
  
% plot
hfig = figure();%'Visible','off');
clf;
hax = axes('Position',[0,0,1,1]);
set(hfig,'Units','pixels','Position',get(0,'ScreenSize'));

im1curr = im1;

him = imshow(imresize(im1curr,scale));
axis image;
truesize;
colormap gray;
hold on;
axis off;

colors = hsv(nbins);
colors = colors([ (end/2+1):end 1:end/2],:);

[nr,nc,~] = size(im1);
% maxv2 = max(H(:));
maxv2 = 0.03;

hogpatch = [wd wd -wd -wd wd;-psize psize psize -psize -psize]/2;
h = [];
for xi = 1:ceil(nc/psize),
  cx = (psize/2 + (xi-1)*psize)*scale+ 1 ;
  if cx+psize/2 > nc*scale,
    break;
  end
  for yi = 1:ceil(nr/psize),
    cy = (psize/2 + (yi-1)*psize)*scale+ 1 ;
    if cy+psize/2 > nr*scale,
      break;
    end
    
    for bini = 1:nbins,
      tmp = bincenters(bini);
      curpatch = [cos(tmp) -sin(tmp); sin(tmp) cos(tmp)]*hogpatch;
      xcurr = cx + curpatch(1,:)*scale;
      ycurr = cy + curpatch(2,:)*scale;
      h(yi,xi,bini) = patch(xcurr,ycurr,colors(bini,:),'LineStyle','none','FaceAlpha',min(1,H(yi,xi,bini)/maxv2));
    end
    
  end
end
truesize(hfig);
% im = getframe(hax);
