%%
fpath = '/Users/labuser/Desktop/'
cd  '/Users/labuser/Documents/MATLAB/FACSanalysis_061011'

[~,~,rawdata] = xlsread([fpath 'SchDATA.xls'],1);
%%

for j = 2:size(rawdata,1)
for i = 1:size(rawdata,2)
     rawdata{1,i}(rawdata{1,i}==' ') = [];
     rawdata{1,i}(rawdata{1,i}=='[') = [];
     rawdata{1,i}(rawdata{1,i}==']') = [];
     rawdata{1,i}(rawdata{1,i}=='/') = [];
     rawdata{1,i}(rawdata{1,i}=='-') = [];
     rawdata{1,i}(rawdata{1,i}=='(') = [];
     rawdata{1,i}(rawdata{1,i}==')') = [];
     rawdata{1,i}(rawdata{1,i}=='*') = [];

     Data{j-1}.(rawdata{1,i}) = rawdata{j,i};
end;
end;
%% Save
Filename = 'SchDATA';
save([fpath Filename])  
%% get mRNA lifetimes, sort by it and Remove NANs
mRNATag = 'mRNAhalflifeaverageh';
proteinTag = 'Proteinhalflifeaverageh';
for i = 1:length(Data)
     mRNALife(i) = sum(isfloat(Data{i}.(mRNATag))*(Data{i}.(mRNATag)));
     ProtLife(i) = sum(isfloat(Data{i}.(proteinTag))*(Data{i}.(proteinTag)));
end
%[mRNALifeSort,I] = sort(mRNALife,'descend');
%DataSort = Data(I);
%DataSort(mRNALifeSort==0) = [];
%mRNALifeSort(mRNALifeSort==0) = [];
%%
Data(mRNALife==0)=[];
ProtLife(mRNALife==0)=[];
mRNALife(mRNALife==0)=[];
%%


[h1,x1]=hist(log(mRNALife),50); %figure(gcf)
%annotation('textbox',[0.55 0.8 0.3 0.05],'string',['Mean mRNA Halfife =' num2str(mean(mRNALife))])
%annotation('textbox',[0.55 0.75 0.3 0.05],'string',['mRNA Halfife Std =' num2str(std(mRNALife))])
[h2,x2]=hist(log(ProtLife),50); %figure(gcf)
plot(x1,h1,x2,h2); figure(gcf)
ylabel('#')
xlabel('log(Halflife)');
legend('mRNA','Protein')
    set(gca,'FontSize', 18)
    
%% Set threshold for high mRNA lifetime
    Thresh = 0.15;
    
   % find()
    
    ThreshmRNA = exp(x1(find(cumsum(h1)./sum(h1)>=(1-Thresh),1,'first')))
    ThreshProtein = exp(x2(find(cumsum(h2)./sum(h2)<=(Thresh),1,'last')))

    
   I = (1:length(Data)).*(mRNALife>=ThreshmRNA).*(ProtLife<=ThreshProtein);
   I(I==0)=[];
   DataLongmRNAShortProt = Data(I);

%%
for i=1:length(DataLongmRNAShortProt)
    nameList{i} = DataLongmRNAShortProt{i}.ProteinNames;
    mRNALifeList{i} = DataLongmRNAShortProt{i}.mRNAhalflifeaverageh;
    proteinLifeList{i} = DataLongmRNAShortProt{i}.Proteinhalflifeaverageh;
end;
%%
fid = fopen('ProtnameList.txt', 'wt' );
for i = 1:length(nameList)
  fprintf( fid, '%s, \n  mRNA Lifetime: %f, protein Lifetime: %f  \n\n', nameList{i},mRNALifeList{i},proteinLifeList{i});
end
fclose(fid);