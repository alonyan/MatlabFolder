function welllbl = WellsConstructor(fpath, Well,frame, FFBlue,FFRed)
   welllbl = WellsLbl;
    welllbl.PosName = Well;
    welllbl.Frame = frame;
    welllbl.pth = fpath;
    %%
    i=frame;
    MD=Metadata(fpath);   
    
    
    DataDeepBlue = stkread(MD,'Channel','DeepBlue', 'flatfieldcorrection', false,'blindflatfield',false, 'frame', frame, 'Position', Well,'register',false);
    DataRed = stkread(MD,'Channel','Red', 'flatfieldcorrection', false,'blindflatfield',false, 'frame', frame, 'Position', Well,'register',false);
   
    DataDeepBlue = DataDeepBlue-FFBlue;
    %DataDeepBlue = DataDeepBlue.*(DataDeepBlue>0);
    DataDeepBlue = DataDeepBlue+max(FFBlue(:));
    DataRed = DataRed-FFRed;
    %DataRed = DataRed.*(DataRed>0);
    DataRed = DataRed+max(FFRed(:));

    welllbl.ImageDims = size(DataDeepBlue);

    
    imageSize=welllbl.ImageDims;
    
    %SizeEst =     EstSizeImg(DataDeepBlue);
    [L, voronoiCells] = SegmentCellsImg(DataDeepBlue, 'EstSize',5);
 %   [LRed, ~] = SegmentCellsImg(DataRed, 'voronoiCells',voronoiCells);s
        
    
    
    A = regionprops(L,'Area');
    

    
    CCVoronoi = bwconncomp(~voronoiCells.RegionBounds); 

        
    S = regionprops(CCVoronoi,DataDeepBlue.*(L>0),'MeanIntensity','Centroid','Area','PixelValues');
    % filter CCNuclei keep only cells with volume in some range
    Areas = cat(1, S.Area);
    NuclearIntensities = cat(1, S.MeanIntensity);
    Centroids = cat(1,S.Centroid);
    Nuclei90Prctile = arrayfun(@(x) prctile(x.PixelValues(x.PixelValues~=0),90),S);
    nzAreas = arrayfun(@(x) nnz(x.PixelValues),S);
    S = regionprops(CCVoronoi,DataRed,'MeanIntensity','PixelValues');
    VirusIntensities = cat(1, S.MeanIntensity);
    %prctile(S(454).PixelValues,95);
    Virus90Prctile = arrayfun(@(x) prctile(x.PixelValues,90),S);

    
    %Apply drift correction to centroids!
    Tforms = MD.getSpecificMetadata('driftTform','Position',Well, 'frame', i);
    if ~isempty(Tforms)
        dY = Tforms{1}(7);
        dX = Tforms{1}(8);
        n = size(Centroids,1);
        Centroids = Centroids+repmat([dY, dX],n,1);
    else
        warning('No drift correction found')
    end
    welllbl.Centroids = Centroids;
    welllbl.NuclearIntensities = NuclearIntensities;
    welllbl.VirusIntensities = VirusIntensities;
    welllbl.Areas = Areas;
    welllbl.nzAreas = nzAreas;
    welllbl.Virus90Prctile = Virus90Prctile;
    welllbl.Nuclei90Prctile = Nuclei90Prctile;
    
    welllbl.num = numel(NuclearIntensities);

    %welllbl.CCNuclei = CCNuclei;
    %welllbl.CCVoronoi = CCVoronoi;

    i
    
    
    
    
end
