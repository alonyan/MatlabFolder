function A = ReadZhiduoCVSfiles(fname, clmnNos)

fid = fopen(fname);
flstr = fscanf(fid, '%s');
fclose(fid)

% find start of the data
startStr = '===================='
strtInd = findstr(flstr, startStr);

commas = findstr(flstr, ',');
commas= [(strtInd+length(startStr)-1), commas];

% read column names
clmnName = '';
ColumnNames = {};
i = 1;
clmnName = flstr((commas(i)+1):(commas(i+1)-1));
while isempty(str2num(clmnName)),
    ColumnNames{i} = clmnName ;
    i = i+1;
    clmnName = flstr((commas(i)+1):(commas(i+1)-1));
end

% get data by column numbers
%clmnNos = [1 2 3];
rows = (length(commas)-1)/length(ColumnNames);
%commasMtrx = reshape(commas(1:(end-1)), length(ColumnNames), rows)';

J = (length(ColumnNames)+1):length(ColumnNames):(length(commas)-1); 
A = [];
for j = J,   
    A = [A; sscanf(flstr(commas(j):(commas(j+3)-1)), repmat(',%f',1, length(clmnNos)))'];
end