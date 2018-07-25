function fca_lineplot2xls()

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

% create the cell array to be exported
dataout = cell(length(xout)+2,2);
dataout(3:end,:) = num2cell([xout;yout]');
dataout(2,:) = {current_xlabel,'NumOfCell'};
dataout(1,:) = {'FCS File name:'; main_gui_handles.fcshdr.filename};

% get the file name of the lm. files(without extension) to create
% the xls file name
if isempty(main_gui_handles.excelinfo.selected_filename)
    current_filename = main_gui_handles.fcshdr.filename;
    current_path = main_gui_handles.fcshdr.filepath;
    [pathstr, name, ext, versn] = fileparts(current_filename);
    xlsoutname = [current_path,'fca_',name,'.xls'];
else
    xlsoutname = main_gui_handles.excelinfo.selected_filename;
end

fname = main_gui_handles.fcshdr.filename;
[pathstr, filename, ext, versn] = fileparts(fname);
if length(filename) > 8
    curdir = pwd;
    cd(main_gui_handles.fcshdr.filepath);
    [dosstatus, dosres] = system(['dir /x ',fname]);
    cd(curdir);
    stringpos = strfind(dosres,fname);
    spacespos = strfind(dosres(1:stringpos),' ');
    fname8_3 = dosres(spacespos(end-1):spacespos(end));
else
    fname8_3 = fname;
end
sheetoutname = [fname8_3,'_',current_xlabel];

% write the data to the excel file
[status, message] = xlswrite(xlsoutname, dataout, sheetoutname);
