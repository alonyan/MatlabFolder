function [Pict1, Norm1, Pict2, Norm2, LineScaleV, ColScaleV, err] = ReconstructImage_v8(AI, Cnt, Nplane, ScanParam, varargin)
% Last parameter PixSize in um is optional
if length(varargin) >1,
    error('Too many input parameters!');
elseif length(varargin) == 1,
    PixSize = varargin{1}; %
else
    PixSize = ScanParam.Dimension2_col_um/(ScanParam.Lines - 1);
end;

% Determine stage type
if isfield(ScanParam, 'whatStage'),
    MCLstage = strcmp(ScanParam.whatStage, 'MadCityLabs');
else
    answ = input('Are you running MadCityLab stage ? (y/n)  ');
    MCLstage = strcmp(answ, 'y');
end;
    
    


if strcmp(ScanParam.ScanType, 'ZXscan' ),
    PixInd = 3;
    StepInd = 1;
    Xc = ScanParam.Offset_AIZ;
    if MCLstage,
        um_per_V = 101.327/10;
    else
        um_per_V = 8;
    end;
elseif strcmp(ScanParam.ScanType, 'XYscan' ),
    PixInd = 1;
    StepInd = 2;
    Xc = ScanParam.Offset_AIX;
     if MCLstage,
        um_per_V = 76.175/10;
    else
        um_per_V = 8;
    end;
elseif strcmp(ScanParam.ScanType, 'YZscan' ),
    PixInd = 2;
    StepInd = 3;
    Xc = ScanParam.Offset_AIY;
    if MCLstage,
        um_per_V = 76.12/10;
    else
        um_per_V = 8;
    end;
end;

PixSizeV = PixSize/um_per_V;
if isfield(ScanParam, 'Ponits_per_Line'),
    ppL  = ScanParam.Ponits_per_Line;
else
    ppL = ScanParam.Points_per_Line;
end;

Lines=ScanParam.Lines;
LineLenV=(ScanParam.Dimension1_lines_um)/um_per_V;

PointsInPlane = Lines*ppL;
j0 =  (Nplane - 1)*PointsInPlane;
J = (1:PointsInPlane) +j0;
if length(Cnt) < J(end),
    err = -1; %acquisition terminated error
    display('apparently acquistion was terminated prematurely');
    [Pict1, Norm1, Pict2, Norm2, LineScaleV, ColScaleV] = errOutput;
    return
end;
if Nplane ==1,
    Cnt  = diff([0 Cnt(J)]);
    X = AI(PixInd, J) - [0 diff(AI(PixInd,J))]/2; % coordinate marks the end of count
    Y = AI(StepInd, J);
else
     Cnt = diff(Cnt([j0 J]));
     X = AI(PixInd, J) -  diff(AI(PixInd, [j0 J]))/2; % coordinate marks the end of count
     Y = AI(StepInd, J);
end;

X = reshape(X, ppL, Lines);
Y = reshape(Y, ppL, Lines);
ColScaleV = mean(Y);
Counts = reshape(Cnt, ppL, Lines);
Ic = round(ppL/2);
X1 = X(1:Ic, :);
X2 = X(ppL:(-1):(Ic+1), :);
Counts1 = Counts(1:Ic, :);
Counts2 = Counts(ppL:(-1):(Ic+1), :);

Xmin = Xc - LineLenV/2;
PixPerLine = round(LineLenV/PixSizeV) +1;

if mod(Nplane,2),     % even and odd planes are scanned in the opposite directions
    K=1:Lines;
else
    K = Lines:-1:1;
end;

clear Pict1;
for j= K,
     tempCnt=zeros(1, PixPerLine);
     tempNum = zeros(1, PixPerLine);
     for i=1:Ic,
          ind = round((X1(i, j) - Xmin)/PixSizeV) + 1;
          if((ind>0) & (ind<= PixPerLine)),
                tempCnt(ind) = tempCnt(ind) + Counts1(i, j);
                tempNum(ind) = tempNum(ind) +1;
          end;
     end;
     Pict1(K(j), :) = tempCnt;
     Norm1(K(j), :) = tempNum ;   
end;

clear Pict2;
for j= K,
     tempCnt=zeros(1, PixPerLine);
     tempNum = zeros(1, PixPerLine);
     for i=1:Ic,
          ind = round((X2(i, j) - Xmin)/PixSizeV);
          if((ind>0) & (ind<= PixPerLine)),
                tempCnt(ind) = tempCnt(ind) + Counts2(i, j);
                tempNum(ind) = tempNum(ind) +1;
          end;
     end;
     Pict2(K(j), :) = tempCnt;
     Norm2(K(j), :) = tempNum;   
end;

LineScaleV = Xmin + (0:(PixPerLine-1))*PixSizeV;
err = 0;

function [Pict1, Norm1, Pict2, Norm2, LineScaleV, ColScaleV] = errOutput;
Pict1 = NaN;
Norm1 = NaN;
Pict2 = NaN;
Norm2 = NaN; 
LineScaleV = NaN;
ColScaleV = NaN;