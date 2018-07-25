%% Created by Alon Yaniv 12.31.13
%Read the TIF file
data=imread('/Users/Alonyan/Downloads/Plots of pSTAT1_14122013.tif'); %Change path to location of your file
data = data==0; %Where data is black (0), then it's data.  The tif is a matrix of 0 and 255.  White space is 255 and dark space is the line - 0.
topmargin = 18; %18pixels of junk (frames) at the top create a margin
data = data(topmargin:length(data)-1,2:649); %Get rid of the top margin and the bottom margin.  649 gets rid of the left and right margins.
%Each lane is saved as a matrix of 325 pixels over 648 pixels  
%325 includes an upper frame and a lower frame
Nlanes = 7;
hightlane = 325;
widthlane = 648;


%% %Separate everything into individual lanes. Also getting rid of margins/frames
clear lane;
for i = 1: Nlanes;
lane(i,:,:) = data(hightlane*(i-1)+1:hightlane*(i)-1,:);
end;
%%
Lane = zeros(Nlanes,widthlane);
for i = 1: Nlanes;
for j=1:widthlane;
ind = find(lane(i,:,j),1,'first');
if ind
Lane(i,j) = 324-ind ;
end
end;
end;