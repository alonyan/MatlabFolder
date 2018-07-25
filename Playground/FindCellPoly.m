 function XY = FindCellPoly(RGB, nucMask,borderMask,cellMask,N,varargin)

j1=find(strcmp(varargin, 'Present'));
if length(j1)>1,
    error('Too many present inputs!')
elseif length(j1)==1,
    Present = true;
else
    Present = false;
end;

 %%
 
%N=50; 
Iter=75; 

A = regionprops(nucMask,'Centroid');
A.Centroid = round(A.Centroid);
xystart(1) = A.Centroid(1);
xystart(2) = A.Centroid(2);

R=zeros(size(nucMask)); 
R(xystart(2),xystart(1))=1; 
R=bwdist(R); 

[Xout,Yout]=meshgrid((1:size(nucMask,2))-xystart(1),(1:size(nucMask,1))-xystart(2));
Xout=Xout./R; 
Yout=Yout./R;
Xout(xystart(2),xystart(1))=0; 
Yout(xystart(2),xystart(1))=0; 


r=2; 
a=linspace(-pi,pi,N+1)';
a(end)=[]; 

%Potential barrier for cell edges
cellMap = 1-mat2gray(imfilter(GradMag_v2(cellMask),fspecial('gauss',5,1),0)); 
cellFlt = imfilter(cellMap,fspecial('gauss',5,1),'replicate');
[cellFlt_dX,cellFlt_dY]=gradient(cellFlt+exp(-R)); %Added some regulation

%Potential barrier for borders
borderMap = 1-mat2gray(imfilter(imdilate(borderMask,strel('disk',1)),fspecial('gauss',3,1),'replicate')); 
%borderFlt = imfilter(borderMap,fspecial('gauss',3,1),'replicate');
[borderFlt_dX,borderFlt_dY]=gradient(borderMap); %Added some regulation


%% Set force contributions
wF1 = 3*10^-1; 
wF2 = -1.8*10^-1; 
wF3 = -3;
wF4 = -2; 

Circ = 0;
%%
XY=repmat(xystart,N,1)+r.*[sin(a) cos(a)]; %starting snake

XYn = [];
jj=1;
for i=1:3000
    %%
    i
    ix=sub2ind(size(nucMask),min(max(ceil(XY(:,2)),1),size(nucMask,1)),min(max(ceil(XY(:,1)),1),size(nucMask,2))); 
%     Vnuc=NucMap(ix); 
    
    for ii=1:N, 
        if ii==1,
            abv=N; 
        else
            abv=ii-1; 
        end, 
        if ii==N,
            blw=1;
        else
            blw=ii+1;
        end
        XYn(ii,:)=mean(XY([abv blw],:)); 
    end
    F1=[Xout(ix) Yout(ix)]; %%force pushing outwards
    F2=(XY-XYn); %nearest neighbor interactions (spring model)   
    F3 = [cellFlt_dX(ix) cellFlt_dY(ix)];  %returning force - cell boundary
    F4 = [borderFlt_dX(ix) borderFlt_dY(ix)]; %returning force - margin
    
    Ftot = wF1*F1+wF2*F2+wF3*F3+wF4*F4;
    
    Circ0 = Circ; %Using circumference for stopping criteria
    XY=XY+Ftot; 
    
    Circ = sum(sqrt(diff(XY(:,1)).^2+diff(XY(:,2)).^2));

    if abs((Circ-Circ0)./Circ)<5E-5 || abs(Circ)<3;
        if Present
            figure(1)
            %set(gcf,'Position',[10 100 size(nucMask,2)*5 size(nucMask,1)*5])
            %clf
            %imagesc(RGB);
            XY(XY<1)=1;
            h1 = plot([XY(:,1); XY(1,1)],[XY(:,2); XY(1,2)],'.-');
            set(h1, 'linewidth', 1.5, 'color','w')
                    set(gca,'position',[0,0,1,1])
        end
        break
    end
    tzeva = makeColorMap([1 1 0],[1 0 0],12);
    
    %% from here on is just plotting
    if Present
        if ~ismember(i,ceil(logspace(0,3,20)))
            continue
        end
    dF1=wF1*sqrt(sum(F1.^2,2)); 
    dF2=wF2*sqrt(sum(F2.^2,2)); 
    dF3=wF3*sqrt(sum(F3.^2,2)); 
    dF4=wF4*sqrt(sum(F4.^2,2)); 

    dF=sqrt(sum(Ftot.^2,2)); 
    figure(1)
    set(gcf,'Position',[10 100 size(nucMask,2)*5 size(nucMask,1)*5])
    %clf
    if i==1
        axes('position',[0,0,1,1])
        imagesc(RGB);
    end
     axis equal
    hold on
    h1 = plot([XY(:,1); XY(1,1)],[XY(:,2); XY(1,2)],'.-')
    set(h1, 'linewidth', 1.5, 'color',tzeva(min(jj,12),:));
    abs((Circ-Circ0)./Circ)
    jj=jj+1;
    figure(2)
    set(gcf,'Position',[620 200 600 400])
    clf
    subplot(1,2,1)
    hold on
    plot(XY(:,1),XY(:,2),'.',XYn(:,1),XYn(:,2),'x')
    quiver(XY(:,1),XY(:,2),wF1*F1(:,1),wF1*F1(:,2),'b')
    quiver(XY(:,1),XY(:,2),wF2*F2(:,1),wF2*F2(:,2),'r')
    quiver(XY(:,1),XY(:,2),wF3*F3(:,1),wF3*F3(:,2),'g')
    quiver(XY(:,1),XY(:,2),wF4*F4(:,1),wF4*F4(:,2),'m')
    axis([-30 ,size(nucMask,1), -30, size(nucMask,2)])
    axis equal
    set(gca,'ydir','reverse')
    title(num2str(i))
    
    subplot(2,2,2)
    bar([dF1 dF2 dF3 dF4],'stacked')
    ylim([0 0.2])
    xlim([0, N])
    subplot(2,2,4)
    bar(dF)
    ylim([0 1])
    xlim([0, N])
    drawnow
    %pause;
    end
end

%bw = poly2mask(double(XY(:,1)),double(XY(:,2)),size(NucFrame,1),size(NucFrame,2));
%Wound = regionprops(bw,'Centroid','Area');
%Centroid = Wound.Centroid;
%Area = Wound.Area;
 end