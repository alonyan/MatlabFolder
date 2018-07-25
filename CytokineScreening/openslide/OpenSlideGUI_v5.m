function FigHdl = OpenSlideGUI_v5(PathNchannels)
% the cell array PathNchannels contains the file paths to different channel
% data and channel names
% v4 added a possibilty to pick several areas to correlate/align images
% v5 the offsets to these areas are incorporated into image

Nchan = length(PathNchannels);
for i=1:Nchan,
    fpath{i} = PathNchannels(i).fpath;
    chanName{i} = PathNchannels(i).chanName;
    offset(i, :) = [0 0];
end;

lbl = CheckLabelConsistency(PathNchannels);

ArrayToImage = [];
BeforeZoomRect = [];
ROIhdl = [];
BaseFontSize =  16;
MaxOffset = 500;
MarginSize = 1; %size of margins relative to the image size. Margins allow us to pan image seemlessly.
AxPosition = [0.02    0.1100    0.7    0.8150];
FigHdl = figure('Toolbar', 'figure', 'Units', 'normalized', ...
    'position', [0    0.0391    1.0000    0.8737]);
AxHdl = axes('Parent', FigHdl, 'Position', AxPosition, 'FontSize', 12);
hZoom = zoom(FigHdl); % zoom handle
set(hZoom, 'ActionPreCallback', @GetAxesPriorZoom, 'ActionPostCallback', @UpdateSlideReg);
hPan = pan(FigHdl); % pan handle
set(hPan, 'ActionPreCallback', @GetAxesPriorZoom, 'ActionPostCallback', @UpdateSlideReg);

% replace standard Zoom Out tool on the toolbar with my pushbutton
hToolbar = findall(FigHdl,'tag','FigureToolBar');
hZoomOut = findall(hToolbar, 'TooltipString', 'Zoom Out');
ZoomOutIcon = get(hZoomOut, 'CData');
hUnzoom = uipushtool(hToolbar, 'TooltipString', 'Unzoom', 'CData', ZoomOutIcon, 'ClickedCallback', @UnZoomCBack);
hButtons = findall(hToolbar);
ZoomOutInd = find(hButtons == hZoomOut);
%hButtons = [hButtons(1:(ZoomOutInd-1)); hButtons(end); hButtons((ZoomOutInd+1):(end-1))];


% Add uicontrols on the figure
TxtPosition = [AxPosition(1) (AxPosition(2)+AxPosition(4)+0.02) AxPosition(3) (0.98-AxPosition(2)-AxPosition(4))];
PanelShift = 0.1;
RedChRect = [0.05 0.1 0.55 0.8];
RedContrRect = [0.6 0.1 0.35 0.8];
%TempRect = NormToPix(RedChRect);
RedPanelRect = [0.75 0.9 0.23 0.1];
GreenPanelRect = RedPanelRect - [0 PanelShift 0 0];
BluePanelRect = GreenPanelRect - [0 PanelShift 0 0];
AlignPanelRect = BluePanelRect - [0 PanelShift 0 0];
DownSampleRect = AlignPanelRect - [0 PanelShift 0 0];
LabelRectSize = DownSampleRect(3);
LabelRect = DownSampleRect - [0 PanelShift+LabelRectSize 0 0];
LabelRect(4) = LabelRectSize; 
LabelRect(3) = LabelRectSize;

LabelHdl = axes('Parent', FigHdl, 'Position', LabelRect);
imagesc(uint8(lbl(end:-2:1, end:-2:1, 1:3)));
axis image;
axis off;
axes(AxHdl)

TxtHdl = uicontrol('Parent', FigHdl, 'Style','text', 'Units', 'normalized',...
    'Position', TxtPosition, 'String', '', 'FontSize', BaseFontSize);


ColorVal = 1:3;
ColorVal = min(ColorVal, Nchan+1);

RedChPanel = uipanel('Parent', FigHdl, 'FontSize', BaseFontSize, 'Title', 'Red ch', 'Position', RedPanelRect);

RedCh = uicontrol('Parent', RedChPanel, 'Style','popupmenu', 'Value', ColorVal(1), 'Units', 'normalized',...
    'Position', RedChRect, 'String', ['None' chanName], 'FontSize', BaseFontSize);
RedContrastHdl = uicontrol('Parent', RedChPanel, 'Style','edit', 'Units', 'normalized',...
    'Position', RedContrRect, 'String', '1', 'FontSize', BaseFontSize);

GreenChPanel = uipanel('Parent', FigHdl, 'FontSize', BaseFontSize, 'Title', 'Green ch', 'Position', GreenPanelRect);

GreenCh = uicontrol('Parent', GreenChPanel, 'Style','popupmenu', 'Value', ColorVal(2), 'Units', 'normalized',...
    'Position', RedChRect, 'String', ['None' chanName], 'FontSize', BaseFontSize);
GreenContrastHdl = uicontrol('Parent', GreenChPanel, 'Style','edit', 'Units', 'normalized',...
    'Position', RedContrRect, 'String', '1', 'FontSize', BaseFontSize);

BlueChPanel = uipanel('Parent', FigHdl, 'FontSize', BaseFontSize, 'Title', 'Blue ch', 'Position', BluePanelRect);

BlueCh = uicontrol('Parent', BlueChPanel, 'Style','popupmenu', 'Value', ColorVal(3), 'Units', 'normalized',...
    'Position', RedChRect, 'String', ['None' chanName], 'FontSize', BaseFontSize);
BlueContrastHdl = uicontrol('Parent', BlueChPanel, 'Style','edit', 'Units', 'normalized',...
    'Position', RedContrRect, 'String', '1', 'FontSize', BaseFontSize);

%set([RedChNameHdl RedCh GreenChNameHdl GreenCh BlueChNameHdl BlueCh], 'Units', 'normalized')
set([RedCh GreenCh  BlueCh RedContrastHdl GreenContrastHdl BlueContrastHdl], 'Callback', @ColorCallback);


AlignPanel = uipanel('Parent', FigHdl, 'FontSize', BaseFontSize, 'Title', 'Align channels', 'Position', AlignPanelRect);
AlignChkBx = uicontrol('Parent', AlignPanel, 'Style','checkbox', 'Units', 'normalized',...
    'Position', [0.12 0.22 0.26 0.45], 'Value', 0, 'FontSize', BaseFontSize, 'Callback', @AlignCallback);
AlignAcceptBtn = uicontrol('Parent', AlignPanel, 'Style','pushbutton', 'Units', 'normalized',...
    'Position', [0.52 0.02 0.46 0.96], 'String', 'Accept', 'FontSize', BaseFontSize, 'Callback', @AcceptAlignCallback);



slide = openslide_opens(fpath{1});
[mppX, mppY, slideW, slideH, ~, downsampleFactors, ~] = openslide_get_slide_properties(slide);
openslide_close(slide);
Xmin = MaxOffset;
Ymin = MaxOffset;
Xmax = slideW - MaxOffset - 1;
Ymax = slideH - MaxOffset - 1;

display(['microns per X pixel:  ' num2str(mppX)]);
display(['microns per Y pixel:  ' num2str(mppY)]);

TempRect = NormToPix(DownSampleRect);
DownSampleNameHdl = uicontrol('Parent', FigHdl, 'Style','text','Units', 'pixels',...
    'Position', [TempRect(1) TempRect(2)+BaseFontSize+2 TempRect(3) BaseFontSize+2], 'String', 'Downsample',...
    'FontSize', BaseFontSize);
DownSampleHdl = uicontrol('Parent', FigHdl, 'Style','popupmenu', 'Value', 1, 'Units', 'pixels',...
    'Position', [TempRect(1:3) BaseFontSize+2], 'String', num2str(downsampleFactors), ...
    'FontSize', BaseFontSize, 'Value', UsefulDownsample([slideW slideH]));

set([DownSampleNameHdl DownSampleHdl], 'Units', 'normalized');

    
    function lbl = CheckLabelConsistency(PathNchannels);
        h = figure('Name', 'Check label consistency and close the window!!!')
        Ncols = 2;
        Nrows = ceil(length(PathNchannels)/Ncols);
        for i=1:length(PathNchannels), 
            slide = openslide_opens(PathNchannels(i).fpath);
            lbl =openslide_read_associated_image(slide, 'label');
            subplot(Nrows, Ncols, i);
            imagesc(lbl(end:-1:1, end:-1:1, 1:3));
            axis image;
            title(PathNchannels(i).chanName);
            %temp1=openslide_get_property_names(slide)
            openslide_close(slide);
        end;
        set(h,'WindowStyle','modal');
        uicontrol(h, 'Style', 'text', 'String', 'Check consistency of the labels and close this window', ...
            'Units', 'normalized', 'Position', [0.02 0.02 0.8 0.08], 'FontSize', 16)
        uiwait;
    end

    function Lev = UsefulDownsample(RealSize)
        AxSize = GetFigSizePix(FigHdl).*AxPosition(3:4); %place left on Fig for axes. As axes change when plotting this value is kept constant
        [~, Lev] = min(abs(log(downsampleFactors) - mean(log(double(RealSize)./AxSize)))); %closest downsample factor in log sense
    end

    function GetAxesPriorZoom(hFig, evd)
         v = axis;
         BeforeZoomRect = [v(1) v(3) diff(v(1:2)) diff(v(3:4))];
        % set(AxHdl, 'Position', AxPosition);
    end


    function FigSize = GetFigSizePix(hFig)
        set(hFig, 'Units', 'pixels');
        pos = get(hFig, 'Position');
        FigSize = pos(3:4);
        set(hFig, 'Units', 'normalized');
    end

    function pixPos = NormToPix(normPos)
       pixPos = normPos.*[GetFigSizePix(FigHdl) GetFigSizePix(FigHdl)];
    end

    function PicOut = RescaleColor(PicIn, ContrastHdl)
        PicIn = double(PicIn);
        g = str2num(get(ContrastHdl, 'String'));
        PicOut = (PicIn/(max(PicIn(:)))).^g;
%         OF = str2num(get(ContrastHdl, 'String'));
%         C = sort(PicIn(:));
%         len = length(C);
%         Clim = C([ceil(len*OF) floor(len*(1-OF))]);
%         %PicOut = (PicIn - Clim(1))/(Clim(2) - Clim(1));
%         PicOut = PicIn/Clim(2);
%         PicOut = max(min(PicOut, 1), 0);
    end

    function DoImage 
        ArrayToImage = zeros(size(ImArray(:, :, 1:3)));
        
        tempCh = get(RedCh, 'Value');
        if tempCh > 1, %not NONE
            ArrayToImage(:, :, 1) = RescaleColor(ImArray(:, :, tempCh-1), RedContrastHdl) ;
        end
        tempCh = get(GreenCh, 'Value');
        if tempCh > 1, %not NONE
            ArrayToImage(:, :, 2) = RescaleColor(ImArray(:, :, tempCh-1), GreenContrastHdl) ;
        end
        tempCh = get(BlueCh, 'Value');
        if tempCh > 1, %not NONE
            ArrayToImage(:, :, 3) = RescaleColor(ImArray(:, :, tempCh-1), BlueContrastHdl) ;
        end
        
        %imagesc(uint8(ArrayToImage));
        image(ArrayToImage);
    end

    function ImArray = LoadImageData(RealPositionRect, level)
        RealX = RealPositionRect(1);
        RealY = RealPositionRect(2); 
        RealW = RealPositionRect(3);
        RealH = RealPositionRect(4);
        %introduce offsets
        % 
        for i=1:length(PathNchannels),
            slide = openslide_opens(fpath{i});
            [~, ~, tempWidth, tempHeight, ~, tempDownsampleFactors, ~] = openslide_get_slide_properties(slide);
            if (tempWidth~= slideW) | (tempHeight~= slideH) | (downsampleFactors ~= tempDownsampleFactors),
                error('Inconsistent dimensions or Downsampling Factors between different channels!');
            end
            zoomingLevel = downsampleFactors(level);
            IM_Rect = round((double(RealPositionRect) - [offset(i, :) 0 0])/zoomingLevel - 1);
            xPos = IM_Rect(1)+1;
            yPos = IM_Rect(2)+1;
            IM_wdth = IM_Rect(3);
            IM_hght = IM_Rect(4);


            [ARGB] = openslide_read_region(slide, xPos, yPos, IM_wdth, IM_hght, 'level', level-1);
            ImArray(:, :, i) = ARGB(:, :, 3); %in a single channel recording it is placed into the fourth layer
            openslide_close(slide);
        end
    end

   function UpdateSlideReg(hFig, evd)
      % disp('zooming')
       %RealPositionRect
        watchon;
        v = axis;
        NewRealW = diff(v(1:2))/BeforeZoomRect(3)*RealPositionRect(3);
        NewRealW = min(NewRealW, Xmax-Xmin+1);
        NewRealH = diff(v(3:4))/BeforeZoomRect(4)*RealPositionRect(4);
        NewRealH = min(NewRealH, Ymax-Ymin+1);
        NewRealX = RealPositionRect(1) + (v(1) - BeforeZoomRect(1))/BeforeZoomRect(3)*RealPositionRect(3);
        NewRealY = RealPositionRect(2) + (v(3) - BeforeZoomRect(2))/BeforeZoomRect(4)*RealPositionRect(4); 
        NewRealX = max(NewRealX, Xmin);
        NewRealX = min(NewRealX, Xmax);
        NewRealY = max(NewRealY, Ymin);
        NewRealY = min(NewRealY, Ymax);
        
        %now try with margins
        NewMarginX = max(NewRealX - NewRealW*MarginSize, Xmin);
        maxX = NewRealX + NewRealW*(1 + MarginSize) - 1;
        maxX = min(maxX, Xmax);
        NewMarginW = maxX - NewMarginX + 1;
        
        NewMarginY = max(NewRealY - NewRealH*MarginSize, Ymin);
        maxY = NewRealY + NewRealH*(1 + MarginSize) - 1;
        maxY = min(maxY, Ymax);
        NewMarginH = maxY - NewMarginY + 1;
        
        MarginPositionRect = [NewMarginX NewMarginY NewMarginW NewMarginH];
        
        RealPositionRect = [NewRealX NewRealY NewRealW NewRealH];
        level = UsefulDownsample(RealPositionRect(3:4));
        set(DownSampleHdl, 'Value', level);
        %ImArray = LoadImageData(RealPositionRect, level);
        
        ImArray = LoadImageData(MarginPositionRect, level);
        DoImage;

        
        zoomingLevel = downsampleFactors(level);
        axis([NewRealX-NewMarginX NewRealX-NewMarginX+NewRealW-1 NewRealY-NewMarginY NewRealY-NewMarginY+NewRealH-1]/zoomingLevel);
        %axis image
        v = axis;
        aspRat = (v(2)-v(1))/(v(4)-v(3));
        PixAxPos = NormToPix(AxPosition);
        PixRat = PixAxPos(3)/PixAxPos(4);
        if ( aspRat > PixRat ), %set axis size by the X axis
            tempAxpos = [AxPosition(1:3) AxPosition(3)/aspRat*PixRat];
        else  %set axis size by the Y axis
            tempAxpos = [AxPosition(1:2) AxPosition(4)*aspRat/PixRat AxPosition(4)];
        end;
        set(AxHdl, 'Position', tempAxpos);
        set(TxtHdl, 'String', ['x0 = ' num2str(NewRealX) '   y0 = ' num2str(NewRealY)...
            '   width = ' num2str(NewRealW) '   height = ' num2str(NewRealH)]);
        watchoff;
        figure(FigHdl);
        ExportData = guidata(FigHdl);
        ExportData.ImArray = ImArray;
        ExportData.X0 = MarginPositionRect(1);
        ExportData.Y0 = MarginPositionRect(2);
        ExportData.width = MarginPositionRect(3);
        ExportData.height = MarginPositionRect(4);
        ExportData.level = level;
        
        guidata(FigHdl, ExportData)
   end

   function ColorCallback(obj, clbdata)
        v = axis;
        DoImage;
        axis(v);
        figure(gcf)       
   end

    function UnZoomCBack(obj, clbdata)
        v = axis;
        BeforeZoomRect = [v(1) v(3) diff(v(1:2)) diff(v(3:4))];
        axis([0 size(ImArray, 2) 0  size(ImArray, 1)]);
        UpdateSlideReg(FigHdl, clbdata);
    end
    
    function xcorr_ab = freqxcorr(a,b)   %taken from normxcorr2
        outsize = size(a) + size(b) - 1;
        % calculate correlation in frequency domain
        Fa = fft2(rot90(a,2),outsize(1),outsize(2));
        Fb = fft2(b,outsize(1),outsize(2));
        xcorr_ab = real(ifft2(Fa .* Fb));
    end;
    
    function offset = Align2Imgs(Im1, Im2, z0)
        max1 = double(max(Im1(:)));
        max2 = double(max(Im2(:)));
        Im1 = double(Im1)/max1;
        Im2 = double(Im2)/max2;
        
        rect1 = [0.5 0.5 size(Im1, 2) size(Im1, 1)];
        rect2 = [0.5 0.5 size(Im2, 2) size(Im2, 1)];
        
        % calculate correlation
        c = normxcorr2(Im1, Im2);
%        c = freqxcorr(Im1, Im2);
%         figure;
%         imagesc(c)

        % find offsets
        % offset found by correlation
        [max_c, imax] = max(abs(c(:)));
        [ypeak, xpeak] = ind2sub(size(c),imax(1));
        corr_offset = [(xpeak-size(Im1,2))
                       (ypeak-size(Im1,1))];

        % relative offset of position of subimages
        rect_offset = [(rect2(1)-rect1(1) - z0(1))
                       (rect2(2)-rect1(2) - z0(2))];

        % total offset
        offset = corr_offset + rect_offset;
%         xoffset = round(offset(1));
%         yoffset = round(offset(2));

    end %Align2Imgs
    
    function AlignCallback(obj, clbdata)
        ROIsize = 500;
        zoomingLevel = downsampleFactors(level);
        ROIsizeScaled = ROIsize/zoomingLevel;
        if get(AlignChkBx, 'Value'),
            % check downsampling level
      
            set(TxtHdl, 'String','Pick points and press Space bar when done. Then press Accept button.');
            SpacePressed = 0;
            
           % iptPointerManager(FigHdl, 'disable');
            while ~SpacePressed
                [Xc, Yc, btn] = myginput(1, 'crosshair');
                if btn == 32,
                    SpacePressed = 1;
                else
                    tempHdl = imrect(AxHdl, [(Xc-ROIsizeScaled/2) (Yc-ROIsizeScaled/2) ROIsizeScaled ROIsizeScaled]);
                    ROIhdl = [ROIhdl tempHdl];
                end
            end
           % iptPointerManager(FigHdl, 'enable');
        end
    end
    
    function [ROI_MarginPos ROI_RealPos] = ROIcoordToRealCoord(roirect)
        Xlim = get(AxHdl, 'Xlim');
        Ylim = get(AxHdl, 'Ylim');
        
        NewRealW = roirect(3)/diff(Xlim)*RealPositionRect(3);
        NewRealW = min(NewRealW, slideW);
        NewRealH = roirect(4)/diff(Ylim)*RealPositionRect(4);
        NewRealH = min(NewRealH, slideH);
        NewRealX = RealPositionRect(1) + (roirect(1) - Xlim(1))/diff(Xlim)*RealPositionRect(3);
        NewRealY = RealPositionRect(2) + (roirect(2) - Ylim(1))/diff(Ylim)*RealPositionRect(4); 
        NewRealX = max(NewRealX, 0);
        NewRealX = min(NewRealX, slideW-1);
        NewRealY = max(NewRealY, 0);
        NewRealY = min(NewRealY, slideH-1);
        
        %now try with margins
        NewMarginX = max(NewRealX - NewRealW*MarginSize, 0);
        maxX = NewRealX + NewRealW*(1 + MarginSize) - 1;
        maxX = min(maxX, slideW-1);
        NewMarginW = maxX - NewMarginX + 1;
        
        NewMarginY = max(NewRealY - NewRealH*MarginSize, 0);
        maxY = NewRealY + NewRealH*(1 + MarginSize) - 1;
        maxY = min(maxY, slideH-1);
        NewMarginH = maxY - NewMarginY + 1;
        
        ROI_MarginPos = [NewMarginX NewMarginY NewMarginW NewMarginH];
        
        ROI_RealPos = [NewRealX NewRealY NewRealW NewRealH];
        
    end

    function AcceptAlignCallback(obj, clbdata)
        ExportData = guidata(FigHdl);
        if isfield(ExportData, 'offsetArray'), 
            OldOffsetLen =  length(ExportData.offsetArray.x);
        else
            OldOffsetLen = 0;
        end
        while ~isempty(ROIhdl),
            roirect = getPosition(ROIhdl(1));
            [ROI_MarginPos ROI_RealPos] = ROIcoordToRealCoord(roirect);
            ROIhdl(1) = [];
            ROIim = LoadImageData(ROI_MarginPos, 1);
            % "real" size cut
            R1 = round(size(ROIim, 1)*MarginSize/(1+2*MarginSize)+1);
            C1 = round(size(ROIim, 2)*MarginSize/(1+2*MarginSize)+1);
            R2 = round(size(ROIim, 1)*(1+MarginSize)/(1+2*MarginSize));
            C2 = round(size(ROIim, 2)*(1+MarginSize)/(1+2*MarginSize));
            
            iRed = get(RedCh, 'Value')-1;
            iGreen = get(GreenCh, 'Value')-1;
            iBlue = get(BlueCh, 'Value')-1;
            
            if (iRed*iGreen > 0), % if both are not None
                Im1 = RescaleColor(ROIim(:, :, iRed), RedContrastHdl);
                Im2 = RescaleColor(ROIim(R1:R2, C1:C2, iGreen), GreenContrastHdl);                
                offset1 = Align2Imgs(Im2, Im1, [C1 R1]);
                
                Im1 = RescaleColor(ROIim(R1:R2, C1:C2, iRed), RedContrastHdl);
                Im2 = RescaleColor(ROIim(:, :, iGreen), GreenContrastHdl);            
                offset2 = -Align2Imgs(Im1, Im2, [C1 R1]);
                offset12 = round((offset1 + offset2)/2);
                if ((R1-offset12(2)) < 0) | ((R2-offset12(2)) > size(ROIim, 1)) | ...
                      ((C1-offset12(1)) < 0) | ((C2-offset12(1)) > size(ROIim, 2)),
                  offset12 = [NaN; NaN];
                end
            else
                offset12 = [NaN; NaN];
            end
            
            if (iRed*iBlue > 0), % if both are not None
                Im1 = RescaleColor(ROIim(:, :, iRed), RedContrastHdl);
                Im2 = RescaleColor(ROIim(R1:R2, C1:C2, iBlue), BlueContrastHdl);               
                offset1 = Align2Imgs(Im2, Im1, [C1 R1]);
                
                Im1 = RescaleColor(ROIim(R1:R2, C1:C2, iRed), RedContrastHdl);
                Im2 = RescaleColor(ROIim(:, :, iBlue), BlueContrastHdl);            
                offset2 = -Align2Imgs(Im1, Im2, [C1 R1]);
                offset13 = round((offset1 + offset2)/2);
                if ((R1-offset13(2)) < 0) | ((R2-offset13(2)) > size(ROIim, 1)) | ...
                      ((C1-offset13(1)) < 0) | ((C2-offset13(1)) > size(ROIim, 2)),
                  offset13 = [NaN; NaN];
                end                
            else
                offset13 = [NaN; NaN];
            end
            
            if (iGreen*iBlue > 0), % if both are not None
                Im1 = RescaleColor(ROIim(:, :, iGreen), GreenContrastHdl);
                Im2 = RescaleColor(ROIim(R1:R2, C1:C2, iBlue), BlueContrastHdl);               
                offset1 = Align2Imgs(Im2, Im1, [C1 R1]);
                
                Im1 = RescaleColor(ROIim(R1:R2, C1:C2, iGreen), GreenContrastHdl);
                Im2 = RescaleColor(ROIim(:, :, iBlue), BlueContrastHdl);            
                offset2 = -Align2Imgs(Im1, Im2, [C1 R1]);
                offset23 = round((offset1 + offset2)/2);
                if ((R1-offset23(2)) < 0) | ((R2-offset23(2)) > size(ROIim, 1)) | ...
                      ((C1-offset23(1)) < 0) | ((C2-offset23(1)) > size(ROIim, 2)),
                  offset23 = [NaN; NaN];
                end                

            else
                offset23 =  [NaN; NaN];
            end
                
              
            set(TxtHdl, 'String', ['offset12 = ' num2str((offset12)') ...
                '  offset13 = ' num2str((offset13)') '   # ROI left: ' num2str(length(ROIhdl))]);
            drawnow
            length(ROIhdl)
            tempFig = figure;
            if all(~isnan([offset12; offset13]));
                TempImage(:, :, 1) = RescaleColor(ROIim(R1:R2, C1:C2, iRed), RedContrastHdl);
                TempImage(:, :, 2) = RescaleColor(ROIim((R1:R2)-offset12(2), (C1:C2)-offset12(1), iGreen), GreenContrastHdl);
                TempImage(:, :, 3) = RescaleColor(ROIim((R1:R2)-offset13(2), (C1:C2)-offset13(1), iBlue), BlueContrastHdl);
                %TempImage(:, :, 3) = 0;
                imagesc(TempImage);
                axis image;
            end
                
            
            if isfield(ExportData, 'offsetArray'),
                ExportData.offsetArray.x = [ExportData.offsetArray.x; ROI_RealPos(1)+ROI_RealPos(3)/2];
                ExportData.offsetArray.y = [ExportData.offsetArray.y; ROI_RealPos(2)+ROI_RealPos(4)/2];
                ExportData.offsetArray.RGB = [ ExportData.offsetArray.RGB; [iRed iGreen iBlue]];
                ExportData.offsetArray.offset12 = [ExportData.offsetArray.offset12; offset12'];
                ExportData.offsetArray.offset13 = [ExportData.offsetArray.offset13; offset13'];
                ExportData.offsetArray.offset23 = [ExportData.offsetArray.offset23; offset23'];
            else
                ExportData.offsetArray.x = ROI_RealPos(1)+ROI_RealPos(3)/2;
                ExportData.offsetArray.y = ROI_RealPos(2)+ROI_RealPos(4)/2;
                ExportData.offsetArray.RGB = [iRed iGreen iBlue];
                ExportData.offsetArray.offset12 = offset12';
                ExportData.offsetArray.offset13 = offset13';
                ExportData.offsetArray.offset23 = offset23';
            end
            guidata(FigHdl, ExportData);                
        end  %while ~isempty(ROIhdl)
        disp('offset Red-Green:') 
        disp(num2str(ExportData.offsetArray.offset12((OldOffsetLen+1):end, :)));
        disp('');
        disp('offset Red-Blue') 
        disp(num2str(ExportData.offsetArray.offset13((OldOffsetLen+1):end, :)));
        disp('');
        disp('offset Green-Blue') 
        disp(num2str(ExportData.offsetArray.offset23((OldOffsetLen+1):end, :)));
        
        offsetRG = mean(ExportData.offsetArray.offset12((OldOffsetLen+1):end, :));
        offsetRB = mean(ExportData.offsetArray.offset13((OldOffsetLen+1):end, :));
        offsetGB = mean(ExportData.offsetArray.offset23((OldOffsetLen+1):end, :));
        set(TxtHdl, 'String', ['offset12 = ' num2str((offset12)') ...
                '  offset13 = ' num2str((offset13)') ]);
        %offset(iRed, :) = [0 0];
        offset(iGreen, :) = offset(iGreen, :) + offsetRG;
        offset(iBlue, :) = offset(iBlue, :) + offsetRB;
        
        set(AlignChkBx, 'Value', 0);
        UpdateSlideReg(obj, clbdata);
            
        
    end %AcceptAlignCallback

RealPositionRect = [0 0 slideW slideH];
%MarginPositionRect = RealPositionRect;
level =  UsefulDownsample([slideW slideH]);

ImArray = LoadImageData(RealPositionRect, level);
DoImage;
%UpdateSlideReg(FigHdl, [])
axis image;
%axis IJ
figure(gcf)

    
end