function [H, Hnorm, X, Xtrue, procData, LinearRange] = HistAsinh(Data, varargin)
%  Extracts Data in a TAG channel (similar to GetFACSdataFromMatLabStructByTag)  and evaluates histograms in a quasi Logicle presentation
% The required parameter is Data which can be either a vector of measured
% values or a data structure loaded by LoadFACSfromFlowJoWorkspace_v
% program
%  Other Parameters come in pairs:
%   'Tag'  - same as in GetFACSdataFromMatLabStructByTag
%   'Nbins' - the requested number of histogram bins (default Nbins = 300)
%  'LinearRange' - the requested range of linear scale in the data
%  representation: the data are going to be rescaled according to X =
%  asinh(data/LinearRange) . If not provided, LinearRange is calculated
%  from the 5th percentile of negative data.
%   'RangeMax'  - the maximal value of the histogram bin (to limit the effect of outliers on the bin size, default RangeMax = 250000)
%   'RangeMin' - the minimal value of the histogram bin (default = -LinearRange)
%
% Outputs:
%  X - bins in Xscale
% Xtrue - bins in the original scale, i.e. Xtrue = LinearRange*sinh(X)
% H - the histogram over X
% Hnorm- histogram normalized to the width of Xtrue bins
% procData - data structure containing other outputs
% LinearRange - calculated or supplied linear range.
% Example of application
% [H, Hnorm, X, Xtrue, proc_ExposedToIL2_5CC7, LinearRange] = HistAsinh(ExposedToIL2_5CC7, 'Tag','PE', 'Linear Range', LinearRange);

    
    j1=find(strcmp(varargin, 'Linear Range'));
    if length(j1)>1,
        error('Too many Linear Range inputs!')
    elseif length(j1)==1,
        LinearRange = varargin{j1+1};
    else %default: find from the 5% of negative points       
        if isnumeric(Data)&isvector(Data), % If Data is just a numeric vector
            tempData = Data(Data < 0);
            tempData = sort(tempData);
            LinearRange = - tempData(round(length(tempData)*0.05)); % 5th negative percentile
        elseif isstruct(Data)&isfield(Data, 'data'), % data as loaded by LoadFACSfromFlowJoWorkspace_v2 function
                j1=find(strcmp(varargin, 'Tag'));
                if length(j1)>1,
                    error('Too many Tag inputs!')
                elseif length(j1)==1,
                    Tag = varargin{j1+1};
                    TagData = GetFACSdataFromMatLabStructByTag(Data, Tag);
                    tempData = [];
                    for i = 1:length(TagData),
                        tempData = [tempData; TagData(i).(Tag)];
                    end;
                    tempData = tempData(tempData < 0);
                    tempData = sort(tempData);
                    LinearRange = - tempData(round(length(tempData)*0.05)); % 5th negative percentile
                else
                    error('You have to supply Tag input!')
                end;
        end;
    end;
  

    j1=find(strcmp(varargin, 'Nbins'));
    if length(j1)>1,
        error('Too many Nbins inputs!')
    elseif length(j1)==1,
        Nbins = varargin{j1+1};
    else %default
        Nbins = 300;
    end;
    
    j1=find(strcmp(varargin, 'RangeMax'));
    if length(j1)>1,
        error('Too many RangeMax inputs!')
    elseif length(j1)==1,
        RangeMax = varargin{j1+1};
    else %default
        RangeMax = 250000;
    end;
    
    j1=find(strcmp(varargin, 'RangeMin'));
    if length(j1)>1,
        error('Too many RangeMin inputs!')
    elseif length(j1)==1,
        RangeMin = varargin{j1+1};
    else %default
        RangeMin = -LinearRange;
    end;
    
%     j1=find(strcmp(varargin, 'Outliers Fraction'));
%     if length(j1)>1,
%         error('Too many Outliers Fraction inputs!')
%     elseif length(j1)==1,
%         OutliersFraction = varargin{j1+1};
%     else %default
%         OutliersFraction = 2e-3;
%     end;
    
    dX = (asinh(RangeMax/LinearRange) - asinh(RangeMin/LinearRange))/Nbins;
    Xe = asinh(RangeMin/LinearRange):dX:asinh(RangeMax/LinearRange);
    dXnorm = LinearRange*diff(sinh(Xe));
    X = Xe(1:Nbins) + dX/2;
    X = X(:);
    Xtrue = LinearRange*sinh(X);
    
    
    % Trying to understand Data 
    
    
    if isnumeric(Data)&isvector(Data), % If Data is just a numeric vector       
        H = hist(asinh(Data/LinearRange), X);
        H = H/sum(H);
        Hnorm = H./dXnorm;
    elseif isstruct(Data)&isfield(Data, 'data'), % data as loaded by LoadFACSfromFlowJoWorkspace_v function
%         fldNames = fieldnames(Data(1));
%         NumOfNumericFldNames = 0;
%         NumericFldName = '';
%         
%         for i=1:length(fldNames),
%             if isnumeric(Data(1).(fldNames{i})),
%                 NumOfNumericFldNames = NumOfNumericFldNames + 1;
%                 NumericFldName = fldNames{i};
%             end;
%         end;
%         
%         if NumOfNumericFldNames > 1,
%             error('Too many Numeric field in the Data structure'),
%         elseif NumOfNumericFldNames == 0,
%             error('Have not found any Numeric fields in the Data structure'),
%         elseif ~isvector(Data(1).(NumericFldName)) %if the wrong Data type and the Numeric field contains an array
%             error('The Numeric field should be a vector'),
%         end;
        
        H = [];
        Hnorm = [];
        meanD = [];
        medianD = [];
        geomeanD = [];
        CVD = [];
        cellNo = [];
        
        if ~exist('TagData'), %If Linear Range is loaded in the function call
            j1=find(strcmp(varargin, 'Tag'));
            if length(j1)>1,
                error('Too many Tag inputs!')
            elseif length(j1)==1,
                Tag = varargin{j1+1};
                TagData = GetFACSdataFromMatLabStructByTag(Data, Tag);
              else
                error('You have to supply Tag input!')
            end;
        end;
        
        for i=1:length(TagData),
            Htemp = hist(asinh(TagData(i).(Tag)/LinearRange), X);
            cellNoTemp = sum(Htemp);
            
            Htemp = Htemp/sum(Htemp);
            HnormTemp = Htemp./dXnorm;
            
            H = [H Htemp(:)];
            Hnorm = [Hnorm HnormTemp(:)];
            cellNo = [cellNo cellNoTemp];
            
            meanD = [meanD mean(TagData(i).(Tag))];
            medianD = [medianD median(TagData(i).(Tag))];
            geomeanD = [geomeanD exp(mean(log(TagData(i).(Tag))))];
            CVD = [CVD std(TagData(i).(Tag))/meanD(i)];
            
        end;
                    
        procData.(Tag).H = H;
        procData.(Tag).Hnorm = Hnorm;
        procData.(Tag).X = X;
        procData.(Tag).Xtrue = Xtrue; 
        procData.(Tag).meanD = meanD;
        procData.(Tag).medianD = medianD;
        procData.(Tag).geomeanD = geomeanD;
        procData.(Tag).CVD = CVD; 
        procData.(Tag).LinearRange = LinearRange;
        procData.(Tag).cellNo = cellNo;
        
    else
        error('Unknown Data type')       
    end;

    plot(X, H);
    figure(gcf);
    a1 = - (1:9)'*10.^(1:3);a1(:);
    a1 = sort(- (1:9)'*10.^(1:2)); 
    a2 =(1:9)'*10.^(1:5);
    a = [sort(a1(:)); 0; a2(:)];
    
    emptyStr = {''; ''; '';''; ''; '';''; ''};
    XTickLabel = [emptyStr; '-100'; emptyStr; {''}; '0'; {''}; emptyStr; '100'; emptyStr; '1,000'; emptyStr; '10,000'; emptyStr; '100,000'; emptyStr];

    XTicks = asinh(a/LinearRange);
    
    set(gca, 'XTick', XTicks, 'XTickLabel', XTickLabel);


end

