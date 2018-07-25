function [h1, h2, x] = histcompare(data1, data2, varargin)

nbins = 10;
normalize = 0;
embed = 0;
j1=find(strcmp(varargin, 'nbins'));
if length(j1)>1,
    error('Too many nbins inputs!')
elseif length(j1)==1,
    nbins = varargin{j1+1};
end;

j1=find(strcmp(varargin, 'xbins'));
if length(j1)>1,
    error('Too many xbins inputs!')
elseif length(j1)==1,
    xbins = varargin{j1+1};
else
[~,xbins] = hist([reshape(data1,1,[]), reshape(data2,1,[])],nbins);
end;

j1=find(strcmp(varargin, 'normalize'));
if length(j1)>=1
    normalize = 1;
end

j1=find(strcmp(varargin, 'embed'));
if length(j1)>=1
    embed = 1;
end
   
[h1,x] = hist(data1,xbins);
[h2] = hist(data2,x);

if normalize
    h1 = h1./sum(h1);
    h2 = h2./sum(h2);
end;

if ~embed
    figure('color',[1 1 1]);
end

width1 = 0.9;
b1 = bar(x,h1,width1,'FaceColor',[1,0,0],....
                     'EdgeColor','none');
                 set(get(b1,'Children'),'FaceAlpha',0.4);
hold on
width2 = width1;
b1 = bar(x,h2,width2,'FaceColor',[0,0,1],...
                     'EdgeColor','none');
     set(get(b1,'Children'),'FaceAlpha',0.4);

hold off
set(gca,'box','off','ylim',[-0.01 1.01*max([h1 h2])]);
legend('First Series','Second Series'); % add legend
legend boxoff;
shg;
end