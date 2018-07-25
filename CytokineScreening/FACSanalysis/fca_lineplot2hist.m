function fca_lineplot2hist()

% get the x, y data to be exported
current_line_handle =  findobj(gca,'type','line','linestyle','-');
xout = get(current_line_handle,'XData');
yout = get(current_line_handle,'yData');

% get the name of the current lm. parameter
current_xlabel = get(get(gca,'xlabel'),'string');

% get the file name of the lm. files(without extension) to create
% the xls file name
fca_main_h = findobj('tag','fca_main_figure');
main_gui_handles = guidata(fca_main_h);

mns='@'; %mnemonic separator
fcsh = [mns,'$BYTEORD',mns,'1,2,3,4'];
fcsh = [fcsh, mns,'$NEXTDATA',mns,'0'];
fcsh = [fcsh, mns,'$DATATYPE',mns,'I'];
fcsh = [fcsh, mns,'$TOT',mns,num2str(sum(yout))];
fcsh = [fcsh, mns,'$MODE',mns,'U'];
fcsh = [fcsh, mns,'$PAR',mns,'1'];
fcsh = [fcsh, mns,'$BTIM',mns,'00:00:00'];
fcsh = [fcsh, mns,'$ETIM',mns,'00:00:00'];
fcsh = [fcsh, mns,'$P1R',mns,num2str(max(xout))];
fcsh = [fcsh, mns,'$P1B',mns,'32'];
fcsh = [fcsh, mns,'$P1E',mns,'0.0,0.0'];
fcsh = [fcsh, mns,'$P1M',mns,'0'];
fcsh = [fcsh, mns,'$P1N',mns,current_xlabel];
fcsh = [fcsh, mns,'$P1S',mns,'Empty'];
fcsh = [fcsh, mns,'$P1W',mns,'0-',num2str(max(xout)-1)];
fcsh = [fcsh, mns,'$DATE',mns,date()];
fcsh = [fcsh, mns,'$SYS',mns,computer()];
fcsh = [fcsh, mns,'CREATOR',mns,'Matlab fca 2.1'];
fcsh = [fcsh, mns,'$FIL',mns, main_gui_handles.fcshdr.filename];
fcsh = [fcsh, mns,'TITLE',mns,''];
fcsh = [fcsh, mns,'$CYT',mns,main_gui_handles.fcshdr.cytometry];
fcsh = [fcsh, mns,'PROCESSED',mns,datestr(now),mns]; 

mainhdr_length = length(fcsh);
FcsHeaderStartPos = 256;
fcsheader_1stline = ['FCS2.0', ...
    char(32),char(32),char(32),char(32),char(32),char(32),char(32),char(32),char(32) ...
    ,num2str(FcsHeaderStartPos)];

FcsHeaderStopPos = FcsHeaderStartPos + mainhdr_length -1;
NumOfSpace = 8-length(num2str(FcsHeaderStopPos));
fcsheader_1stline = [fcsheader_1stline, char(32*ones(NumOfSpace,1)'),num2str(FcsHeaderStopPos)];

FcsDataStartPos = FcsHeaderStopPos + 1;
NumOfSpace = 8-length(num2str(FcsDataStartPos));
fcsheader_1stline = [fcsheader_1stline, char(32*ones(NumOfSpace,1)'),num2str(FcsDataStartPos)];

FcsDataStopPos = FcsDataStartPos + 4*max(xout);
NumOfSpace = 8-length(num2str(FcsDataStopPos));
fcsheader_1stline = [fcsheader_1stline, char(32*ones(NumOfSpace,1)'),num2str(FcsDataStopPos)];

fcsheader_1stline = [fcsheader_1stline, char(32*ones(7,1)'),'0'];
fcsheader_1stline = [fcsheader_1stline, char(32*ones(7,1)'),'0'];
curr_length = length(fcsheader_1stline);
fcsheader_1stline = [fcsheader_1stline, char(32*ones(FcsHeaderStartPos-curr_length,1)')];

fcsheader_dec = double([fcsheader_1stline,fcsh]);

% start saving
currend_dir = cd;
cd(main_gui_handles.fcshdr.filepath);
[histfilename, pathname] = uiputfile('*.fcs', 'Save lineplot as FCS histogram file');
if isequal(histfilename,0) | isequal(pathname,0)
    return;
end
cd(currend_dir);
[pathstr,filemainname,ext,vers] = fileparts(histfilename);

fid = fopen([pathname,filemainname,ext],'w','ieee-le');
count =  fwrite(fid,fcsheader_dec,'char');
count =  fwrite(fid,yout,'uint32');
fclose(fid);

