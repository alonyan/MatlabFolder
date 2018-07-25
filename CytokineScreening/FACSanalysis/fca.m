function fca_fcahdrinfo = fca;
% fca - flow cytometric analysis
% 
% This Matlab GUI enables you to perform evaluation on FCS format 
% data files  measured by flow cytometry. The following featured are
% included (version 2.1):
%
% - reading FCS 2.0 and FCS 3.0 list mode (LM) file format. The user can
%   multiselect more LM files in the "Open LM File" dialog box defining a set 
%   of LM files to be evaluate. 
%
% - lineplot, dotplot and 3Dplot can be defined with easy way by a special GUI
%   1.  To define lineplot you should select the desired LM parameter by left 
%       click and define it as lineplot by right click 
%   2.  To define dotplot or 3Dplot you should select the desired LM parameteres
%       by left click WITH pressing the CTRL key down and define them as dotplot 
%       or 3Dplot by right click
%   3. To delete a lineplot, dotplot or 3Dplot you should select the desired plot
%   by left click and remove by right click
% /For more info, press the Help button on the HistogramSetup window/ 
%   
% - ROIs can be drawn on the dotplots to define filtered population. Use normal 
%   (left)button clicks to add vertices to the polygon and right-click close the
%   vertex. If more ROI you have at different dotplot, the intersection will be 
%   determined of the events. Only the filtered events will be displayed 
%   on lineplots and they will have red color in dotplot figures.
%
% - the mean and the stdev parameters are always displayed in all lineplot
%
% - the setup of histograms (definition of lineplots, dotplots, ROIs) 
%   can be saved and reloaded for later processing
%
% - statistical results (mean, stdev) can be saved directly to an Excel sheet, 
%   including optional header line. The current excel sheet can be defined by 
%   the "Select excel File for Results" menu item or it is generated automatically 
%   under the directory where the opened LM files exist. In the second case the 
%   name of the excel sheet will be given for the next way: fca_'LMmainname'.xls,
%   where 'LMmainname' means the filename of the currently opened LM file without 
%   extension. The program writes the results to the worksheet named 'results'. 
%
% - the user can export the histogram data (X,Y coordinates) of a lineplot to Excel
%   file for creating custom plots with different lineplots. The naming convention 
%   of the Excel file is same as above, but the worksheet name will be
%   different: 'LMfilname_8dot3format'+'PARname', where 'PARname' is the LM parameter
%   name of the current lineplot, and 'LMfilname_8dot3_format' is the short version
%   (old DOS 8.3 format) of the opened LM file name.      
%   
% - the user can navigate across the current set of LM files using the "Previous LM" 
%   and "Next LM" buttons, enabling an efficient way to evaluate the next(previous)
%   LM file.
%
% On the main window the buttons have "ToolTip String" describing the purpuse of the 
% given button. Some menu item are defined helping the work with FCA. The next 
% section gives a short description of the Menu Items:
%   File | Open FCS file
%       LM file or a set of LM files can be select using a standard dialog box. The 
%       user can select multiple files by holding down the Shift or Ctrl key 
%       and clicking on a file. 
%   File | Show FCS hdr
%       Selcting this item the most imprtant LM header info can be displayed. This 
%       is a special matlab structure, which also contains the whole data part 
%       of the LM file.
%   File | Close FCS file
%       The current LM file can be closed along with deleting the all histograms and
%       variables
%   File | Save FCS as txt
%       The LM data can be saved as tab separated txt file. If ROIs are defined on 
%       histograms only the filtered events will be selected for saving.
%   File | Exit
%       Quit the "fca" program.
%   Excel options | Select Excel File for Results
%       Defining an Excel file for the results the user should activate this item. 
%       New or existing excel file can be selected both. If the user select 
%       an existing file the program will prompt a warning  as "Do you want
%       to replace it?", but it does mean to delete the previous one. The program just
%       read the name of the file.
%   Excel options | Open Current Excel File
%       During the data evaluation the current excel file should be closed
%       enabling the Matlab to write the data to the xls file. To check the
%       content of the xls file the user can select this menu item, the
%       program will open the excel file. The user have to close the xls file 
%       again before continue the data evaluation. 
%       /hint: the current excel file can be also opened by selecting and right
%       clicking on the "Current excel file name" edit box./
%   Excel options | Set Current Excel Row
%       The first 'active' row in the current execl file can be displayed or
%       redefined selecting this menu item. This is "row number" where the 
%       next datat will be written when the user press the "Result2xls" or 
%       "Hdr2xls" button.
%   Help
%       Html format help can be displayed. 
%              

%
%  This program is distributed in the hope that it will be useful, 
%  but not all situation has been checked. 
%
% University of Debrecen, PET Center/Laszlo Balkay 2005
% Author: Laszlo Balkay.
% email: balkay@pet.dote.hu
global fca_fcahdrinfo;
fca_gui;

