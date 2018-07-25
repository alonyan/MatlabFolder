function [binnedData, Xbins, Nbins] = BinData_v2(Data, varargin)

%args are: Tag, Nbins, LinearRange, Xbins

%parameter to bin by in Tag
        j1=find(strcmp(varargin, 'Tag'));
        if length(j1)>1,
            error('Too many Tag inputs!')
        elseif isempty(j1),
            error('Tag has to be provided for structure data')
        else
            Tag = varargin{j1+1}
            TagName = strrep(Tag,'-','');
%             if iscell(Tag) & length(Tag) > 2,
%                 errordlg('Only one or two tags are allowed!'),
%             elseif ~iscell(Tag) , %tag is a string
%                 TagData = GetFACSdataFromMatLabStructByTag(Data, Tag);
%                 dataType = 'structure1D';
%             else % two Tags for two channels
%                  TagData1 = GetFACSdataFromMatLabStructByTag(Data, Tag{1}) ;
%                  TagData2 = GetFACSdataFromMatLabStructByTag(Data, Tag{2});
%                  dataType = 'structure2D';
%            end;
        end;
        
        
%linear range
                LinearRange = 150;%default LR
        j1=find(strcmp(varargin, 'LinearRange'));
            if length(j1)>1,
                error('Too many LinearRange inputs!')
            elseif length(j1)==1,
                LinearRange = varargin{j1+1};
            end;
            
%Nbins     
                Nbins = 10; %default is 10 bins
        j1=find(strcmp(varargin, 'Nbins'));
            if length(j1)>1,
                error('Too many Nbins inputs!')
            elseif length(j1)==1,
                Nbins = varargin{j1+1};
            end;
            
            
            match1 = strfind(Data(1).ListofChannelsWithLabels , Tag);

        for i=1:length(Data(1).ListofChannelsWithLabels),
            if(~isempty(match1{i})), 
                ch1 = i;
                Data(1).ListofChannelsWithLabels(i) ;       
            end;
        end;
        

%Need to remove outliers in data before getting bins
%Xbins            
        j1=find(strcmp(varargin, 'Xbins'));
            if length(j1)>1,
                error('Too many Xbins inputs!')
            elseif length(j1)==1,
                Xbins = varargin{j1+1};
                
                if length(Xbins)-1~=Nbins
                    warning('Using supplied Xbins, Nbins input ignored')%Xbins overruns Nbins
                end
                Nbins = length(Xbins)-1;
                HistAsinh3(Data, 'Tag' ,Tag,'LinearRange', LinearRange, 'Bins', asinh(Xbins./LinearRange));
                pause(0.1)

            elseif isempty(j1),
                DataTemp = Data;
                dataHistTemp = HistAsinh3(DataTemp, 'Tag' ,Tag,'LinearRange', LinearRange, 'Nbins', 100);
                Thresh = logical((cumsum(dataHistTemp.(TagName).H)>0.005).*(cumsum(dataHistTemp.(TagName).H)<0.995));
             
                %%Xtrue = LinearRange*sinh(X)
                Limits = dataHistTemp.(TagName).Xtrue(Thresh(:,1));
                Limits = Limits(1);
                RangeMin = min(Data(1).data(Data(1).data(:,ch1)>Limits,ch1));
                for i = 2:length(Data)      
                     Limits = dataHistTemp.(TagName).Xtrue(Thresh(:,i));
                     Limits = Limits(1);
                    RangeMin = min(RangeMin, min(Data(i).data(Data(i).data(:,ch1)>Limits,ch1)));
                    clear Limits
                end;
             %   RangeMin = asinh(RangeMin./LinearRange);
                
                Limits = dataHistTemp.(TagName).Xtrue(Thresh(:,1));
                Limits = Limits(end);
                RangeMax = min(Data(1).data(Data(1).data(:,ch1)>Limits,ch1));
                for i = 2:length(Data)      
                     Limits = dataHistTemp.(TagName).Xtrue(Thresh(:,i));
                     Limits = Limits(end);
                    RangeMax = max(RangeMax, max(Data(i).data(Data(i).data(:,ch1)<Limits,ch1)));
                    clear Limits
                end;
             %   RangeMax = asinh(RangeMax./LinearRange);
                
                DataHist = HistAsinh3(Data, 'Tag' ,Tag,'LinearRange', LinearRange, 'Nbins', Nbins+1, 'RangeMin' , RangeMin,'RangeMax', RangeMax);
                Xbins = DataHist.(TagName).Xtrue;
            end;
            
            

%binnedData = Data;
    for j = 1:length(Xbins)-1
        for i = 1:length(Data)

        if j == 1
               binnedData(j, i).data = Data(i).data(logical((Data(i).data(:,ch1)<=Xbins(j+1))),:);
               binnedData(j, i).LowerLimit = min(binnedData(j, i).data(:,ch1));
               binnedData(j, i).UpperLimit = Xbins(j+1);
        elseif j == length(Xbins)-1
               binnedData(j, i).data = Data(i).data(logical((Xbins(j)<=Data(i).data(:,ch1))),:);
               binnedData(j, i).LowerLimit = Xbins(j);
               binnedData(j, i).UpperLimit = max(binnedData(j, i).data(:,ch1));
        else   
               binnedData(j, i).data = Data(i).data(logical((Xbins(j)<=Data(i).data(:,ch1)).*(Data(i).data(:,ch1)<=Xbins(j+1))),:);
               binnedData(j, i).LowerLimit = Xbins(j);
               binnedData(j, i).UpperLimit = Xbins(j+1);
        end;
              
    
            binnedData(j, i).ListofChannelsWithLabels = Data(i).ListofChannelsWithLabels;
        binnedData(j, i).name = Data(i).name;
        binnedData(j, i).fname = Data(i).fname;
        binnedData(j, i).binNum = j;
        end
    end
end
