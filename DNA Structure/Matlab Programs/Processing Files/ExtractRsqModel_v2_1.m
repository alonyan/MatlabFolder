function y=ExtractRsqModel_v2(CFstruct, model, FitType, range, CorrTypeToDisplacement, varargin)
% 'model' should have two fields '.G' (normalized to unity at hSq=0) and
% '.hSq'.
% FitType is either 'TripletFit' or 'Average'
% range is fit range in ms
%optional argument wXYsq
% changes on 19.04.06
% added CorrTypeToDisplacement of 'CF_CR' or 'dIdI'
% v2 04.06.06 added treatment of both longitudinal and transverse
% displacement 
% 

model.name

if strcmp(CorrTypeToDisplacement, 'CF_CR'),
    CF=CFstruct;
elseif strcmp(CorrTypeToDisplacement, 'dIdI'),
    % workaround to avoid numerous changes further on
    CF.lag = CFstruct.lag;
    CF.AverageCF_CR = CFstruct.AveragedIdI;
    CF.AverageAllCF_CR = CFstruct.AverageAlldIdI;
    CF.errorCF_CR = CFstruct.errordIdI;
    CF.errorAllCF_CR = CFstruct.errorAlldIdI;
elseif strcmp(CorrTypeToDisplacement, 'Normalized'),
    % workaround to avoid numerous changes further on
    CF.lag = CFstruct.lag;
    CF.AverageCF_CR = CFstruct.Normalized;
    CF.AverageAllCF_CR = CFstruct.AverageAllCF_CR;
    CF.errorCF_CR = CFstruct.errorNormalized;
    CF.errorAllCF_CR = CFstruct.errorAllCF_CR;    
end;

if strcmp(FitType, 'Average'),
    [G0, G0all] = FindPlateauAve(CF, range);
elseif strcmp(FitType, 'TripletFit'), 
    [G0, G0all] = FindPlateauTripletFit(CF, range);
elseif strcmp(FitType, 'Fixed'),
    G0 = range(1);
    G0all = range(2);
end;

j=find(strcmp(varargin, 'wXYsq'));
if length(j)==1,
    wXYsq = varargin{j+1};
else wXYsq =1;
end;

if strcmp(model.name, 'Parallel-Perpendicular') | strcmp(model.name, 'diff3D_speed')  | strcmp(model.name,  'FJCreptation_speed'),
    y.Rsq = wXYsq * SolveRsqModel_2D(CF.AverageCF_CR, G0, model);
    y.Rsqbot = wXYsq * SolveRsqModel_2D(CF.AverageCF_CR+real(CF.errorCF_CR), G0, model);
    y.Rsqtop = wXYsq * SolveRsqModel_2D(CF.AverageCF_CR-real(CF.errorCF_CR), G0, model);
	%	y(i)
    y.RsqAll = wXYsq * SolveRsqModel_2D(CF.AverageAllCF_CR, G0all, model);
    y.RsqAllbot = wXYsq * SolveRsqModel_2D(CF.AverageAllCF_CR+real(CF.errorAllCF_CR), G0all, model);
    y.RsqAlltop = wXYsq * SolveRsqModel_2D(CF.AverageAllCF_CR-real(CF.errorAllCF_CR), G0all, model);

    y.error=abs(y.Rsqtop-y.Rsqbot)/2;
    y.errorAll=abs(y.RsqAlltop-y.RsqAllbot)/2;
   y.lag=CF.lag;
   if strcmp(model.name,  'FJCreptation_speed'), y.lag = model.lag;end;

    y.G0=G0;
    y.G0all=G0all;
    
else
    y.Rsq = wXYsq * SolveRsqModel(CF.AverageCF_CR, G0, model);
    y.Rsqbot = wXYsq * SolveRsqModel(CF.AverageCF_CR+real(CF.errorCF_CR), G0, model);
    y.Rsqtop = wXYsq * SolveRsqModel(CF.AverageCF_CR-real(CF.errorCF_CR), G0, model);
	%	y(i)
    y.RsqAll = wXYsq * SolveRsqModel(CF.AverageAllCF_CR, G0all, model);
    y.RsqAllbot = wXYsq * SolveRsqModel(CF.AverageAllCF_CR+real(CF.errorAllCF_CR), G0all, model);
    y.RsqAlltop = wXYsq * SolveRsqModel(CF.AverageAllCF_CR-real(CF.errorAllCF_CR), G0all, model);

    y.error=abs(y.Rsqtop-y.Rsqbot)/2;
    y.errorAll=abs(y.RsqAlltop-y.RsqAllbot)/2;
    y.lag=CF.lag;

    y.G0=G0;
    y.G0all=G0all;
end;

y.hSq = y.Rsq /wXYsq;
y.errorHsq = y.error/wXYsq;


%**************************************************************************

function [G0, G0all, G0bot, G0allbot, G0top, G0alltop] = FindPlateauAve(CF, range)

t1=find(CF.lag >= range(1));
t2=find(CF.lag >= range(2));

CF.errorCF_CR = CF.errorCF_CR+eps; %to be on the safe side
CF.errorAllCF_CR = CF.errorAllCF_CR+eps;
%G0all=mean(CF.AverageAllCF_CR(t1(1):t2(1)));
%take weighted average
G0=sum(CF.AverageCF_CR(t1(1):t2(1))./CF.errorCF_CR(t1(1):t2(1)).^2)/sum(CF.errorCF_CR(t1(1):t2(1)).^(-2));
if ~isreal(G0),
    'not real G0'
    G0=mean(CF.AverageCF_CR(t1(1):t2(1))), 
end;
    
G0all=sum(CF.AverageAllCF_CR(t1(1):t2(1))./CF.errorAllCF_CR(t1(1):t2(1)).^2)/sum(CF.errorAllCF_CR(t1(1):t2(1)).^(-2));
G0all
if ~isreal(G0all),
    'not real G0all'
    G0all=mean(CF.AverageAllCF_CR(t1(1):t2(1))), 
    G0all
end;

semilogx(CF.lag, CF.AverageCF_CR, range, [G0 G0])
title('Fit Selection');

figure;
semilogx(CF.lag, CF.AverageAllCF_CR, range, [G0all G0all])
title('Fit All');

% G0bot=sum((CF.AverageCF_CR(t1(1):t2(1))+CF.errorCF_CR(t1(1):t2(1)))./CF.errorCF_CR(t1(1):t2(1)).^2)/sum(CF.errorCF_CR(t1(1):t2(1)).^(-2));
% if ~isreal(G0bot), 
%     G0bot=mean(CF.AverageCF_CR(t1(1):t2(1))+real(CF.errorCF_CR(t1(1):t2(1)))); 
% end;
% 
% G0top=sum((CF.AverageCF_CR(t1(1):t2(1))- CF.errorCF_CR(t1(1):t2(1)))./CF.errorCF_CR(t1(1):t2(1)).^2)/sum(CF.errorCF_CR(t1(1):t2(1)).^(-2));
% if ~isreal(G0top), 
%     G0top=mean(CF.AverageCF_CR(t1(1):t2(1))-real(CF.errorCF_CR(t1(1):t2(1)))); 
% end;
% 
% G0allbot=sum((CF.AverageAllCF_CR(t1(1):t2(1))+CF.errorAllCF_CR(t1(1):t2(1)))./CF.errorAllCF_CR(t1(1):t2(1)).^2)/sum(CF.errorAllCF_CR(t1(1):t2(1)).^(-2));
% G0alltop=sum((CF.AverageAllCF_CR(t1(1):t2(1))-CF.errorAllCF_CR(t1(1):t2(1)))./CF.errorAllCF_CR(t1(1):t2(1)).^2)/sum(CF.errorAllCF_CR(t1(1):t2(1)).^(-2));


%**************************************************************************

function [G0, G0all, G0bot, G0allbot, G0top, G0alltop] = FindPlateauTripletFit(CF, range)

t1=find(CF.lag >= range(1));
t2=find(CF.lag >= range(2));

beta0(1) = CF.AverageCF_CR(t1(1)) - CF.AverageCF_CR(t2(1));
beta0(2) = 0.0002;
beta0(3) = CF.AverageCF_CR(t2(1));

betaExp=PlotFitCF(CF, range, @ExponentFit, beta0);
title('Fit Selection');
G0=betaExp.beta(3,1)


beta0(1) = CF.AverageAllCF_CR(t1(1)) - CF.AverageAllCF_CR(t2(1));
beta0(2) = 0.0002;
beta0(3) = CF.AverageAllCF_CR(t2(1));

figure;
betaExp=PlotFitCFAll(CF, range, @ExponentFit, beta0);
title('Fit All');
G0all=betaExp.beta(3,1)

% G0bot=sum((CF.AverageCF_CR(t1(1):t2(1))+CF.errorCF_CR(t1(1):t2(1)))./CF.errorCF_CR(t1(1):t2(1)).^2)/sum(CF.errorCF_CR(t1(1):t2(1)).^(-2));
% if ~isreal(G0bot), 
%     G0bot=mean(CF.AverageCF_CR(t1(1):t2(1))+real(CF.errorCF_CR(t1(1):t2(1)))); 
% end;
% 
% G0top=sum((CF.AverageCF_CR(t1(1):t2(1))- CF.errorCF_CR(t1(1):t2(1)))./CF.errorCF_CR(t1(1):t2(1)).^2)/sum(CF.errorCF_CR(t1(1):t2(1)).^(-2));
% if ~isreal(G0top), 
%     G0top=mean(CF.AverageCF_CR(t1(1):t2(1))-real(CF.errorCF_CR(t1(1):t2(1)))); 
% end;
% 
% G0allbot=sum((CF.AverageAllCF_CR(t1(1):t2(1))+CF.errorAllCF_CR(t1(1):t2(1)))./CF.errorAllCF_CR(t1(1):t2(1)).^2)/sum(CF.errorAllCF_CR(t1(1):t2(1)).^(-2));
% G0alltop=sum((CF.AverageAllCF_CR(t1(1):t2(1))-CF.errorAllCF_CR(t1(1):t2(1)))./CF.errorAllCF_CR(t1(1):t2(1)).^2)/sum(CF.errorAllCF_CR(t1(1):t2(1)).^(-2));



%**************************************************************************

function Hsq = SolveRsqModel(CF_CR, G0, model)

% 'model' should have two fields '.G' (normalized to unity at hSq=0) and '.hSq'. 

Hsq = interp1(model.G, model.hSq, CF_CR/G0);

%**************************************************************************

function Hsq = SolveRsqModel_2D(CF_CR, G0, model)
% 'model' should have two fields '.G' (normalized to unity at hSq=0) and '.hSq'. 
if strcmp(model.name, 'Parallel-Perpendicular'),
    num = find(~isnan(model.hSq));
    Hsq = NaN(size(CF_CR));
    for i=num',
        Hsq(i) = interp1(model.G(i,: ), model.hParSq, CF_CR(i)/G0);
    end;
elseif (strcmp(model.name, 'diff3D_speed')  | strcmp(model.name,  'FJCreptation_speed')),
    for i=1:length(model.lag),
%    for i=1:201,
         [temp, j]=max(model.G(i,: ));
         %[i, j]         
         if (j ==1),
             if temp > 0,
                    Hsq(i) = interp1(model.G(i,: ), model.hSq, CF_CR(i)/G0);
             else
                    Hsq(i) = NaN;
             end;
         elseif (j < length(model.hSq))
                 Hsq(i) = interp1(model.G(i,j:length(model.hSq) ), model.hSq(j:length(model.hSq) ), CF_CR(i)/G0);
         else
                 Hsq(i) = NaN;
         end;
    end;
else 
    error('nonexistant model');
end;