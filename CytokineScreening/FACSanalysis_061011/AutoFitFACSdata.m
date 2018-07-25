function [ BETA procData ] = AutoFitFACSdata( histData , Tag, FitFunc, varargin)
% Fits histogram data as produced by HistAsinh function and plots the fits
% to all of the sets of data.
%  Required parameters
% histData  - histogram  data as produced by  HistAsinh
% Tag - the field name to fit
% FitFunc - pointer to the fitting function
%
% One of the two options to evaluate Initial values of the fitting
% parameters has to be provided:
% 1) 'InitParam' followed by the initial guess of the parameters
% 2) 'InitParamFunc' followed by pointer to the function that evaluates the
% inital parameters from the data sets.
% 
% Optional parameters come in pairs
% 'Outliers Fraction' - the fraction of data points to discount as outliers
%    on both sides of the histogram (default value: 2e-3)
%   'Lower Bounds' and 'Upper Bounds' - the bounds for the fit parameters
% 
% Output parameters:
% BETA : the fitted parameters
% procData - the same data as histData but with the added field of fit
% parameters
%
% Oleg Krichevsky  Aug. 2011 krichevo@mskcc.org
% okrichev@bgu.ac.il
%
    j1=find(strcmp(varargin, 'InitParam'));
    if length(j1)>1,
        error('Too many InitParam inputs!')
    elseif length(j1)==1,
        BETA0 = varargin{j1+1};
    end;
    
    j1=find(strcmp(varargin, 'InitParamFunc'));
    if length(j1)>1,
        error('Too many InitParamFunc inputs!')
    elseif length(j1)==1,
        InitParamFunc = varargin{j1+1};
    end;

    if(~exist('BETA0') & (~exist('InitParamFunc'))),
        error('Either initial fitting parameters or a function calculating them have to be specified!');
    end;
    
    j1=find(strcmp(varargin, 'Outliers Fraction'));
    if length(j1)>1,
        error('Too many Outliers Fraction inputs!')
    elseif length(j1)==1,
        OutliersFraction = varargin{j1+1};
    else %default
        OutliersFraction = 2e-3;
    end;
    
    j1=find(strcmp(varargin, 'Lower Bounds'));
    if length(j1)>1,
        error('Too many Lower Bounds inputs!')
    elseif length(j1)==1,
        LB = varargin{j1+1};
    end; 
    
    j1=find(strcmp(varargin, 'Upper Bounds'));
    if length(j1)>1,
        error('Too many Upper Bounds inputs!')
    elseif length(j1)==1,
        UB = varargin{j1+1};
    end; 
    
    j1=find(strcmp(varargin, 'Range'));
    if length(j1)>1,
        error('Too many Range inputs!')
    elseif length(j1)==1,
        Range = varargin{j1+1};
    else %default
        Range = [-inf inf];
    end; 

    
    BETA = [];
    H = histData.(Tag).H;
    X = histData.(Tag).X;
    
    for i=1:size(H, 2),
        %remove outliers
        h = H(:, i);
        cumh = cumsum(h);
        if OutliersFraction >0,
            J = min(find(cumh >= OutliersFraction)) : max(find(cumh <= (1-OutliersFraction)));
        else
            J = 1:length(X);
        end;
         x = X(J);
         h = h(J);
        
        J = ( x > Range(1)) & (x < Range(2));
        x = x(J);
        h = h(J);
        

        if exist('InitParamFunc'),
            BETA0 = eval([InitParamFunc '(x, h)']);
            [i BETA0]
        end;
        
        if exist('LB'), 
            beta = lsqcurvefit(FitFunc, BETA0 ,x, h, LB, UB)
        else
            beta = lsqcurvefit(FitFunc, BETA0 ,x, h);
        end;
        
        
        BETA = [BETA beta(:)];

        plot(x, h, 'o', x, FitFunc(beta, x));
              
        title(i);
        figure(gcf);
        pause;
        
        
    end;
   
   procData = histData;
   procData.(Tag).fitParam = BETA;


end

