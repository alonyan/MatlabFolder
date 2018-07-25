function LiveSnapWindow(Scp)
global KEY_IS_PRESSED

figure(417)
set(417,'color','w','Windowstyle','normal','toolbar','none','menubar','none','Position',[863 892 250 150],'Name','Snap Snap','NumberTitle','off')

h = uicontrol(417,'Style', 'pushbutton','Position',[50 75 150 50],'fontsize',13, 'String', 'Snap', 'callback',@(x,y) SnapCallback(x,y,Scp));
    function SnapCallback(hObject, event, Scp)
        Scp.snapImage;
    end

%Live
h = uicontrol(417,'Style', 'togglebutton','Position',[50 25 150 50],'fontsize',13, 'String', 'Live', 'Value',1,'callback',@(x,y) LiveClbk(x,y,Scp));
KEY_IS_PRESSED = h.Value;

    function stpLiveClbk(hObject, event, Scp)
        KEY_IS_PRESSED  = 1;
        h = uicontrol(417,'Style', 'togglebutton','Position',[50 25 150 50],'fontsize',13, 'String', 'Live', 'Value',1,'callback',@(x,y) LiveClbk(x,y,Scp));
    end

    function LiveClbk(hObject, event, Scp)
        
        h = uicontrol(417,'Style', 'togglebutton','Position',[50 25 150 50],'fontsize',13, 'String', 'Stop', 'Value',0,'callback',@(x,y) stpLiveClbk(x,y,Scp));
        KEY_IS_PRESSED = h.Value;
        try
            calllib('SpinnakerC_v140','spinCameraBeginAcquisition',Scp.Camera.Camera);
            while ~KEY_IS_PRESSED
                drawnow
                hResultImage  =  libpointer('voidPtr');
                        Scp.mmc.setShutterOpen(true);
                calllib('SpinnakerC_v140','spinCameraGetNextImage',Scp.Camera.Camera,hResultImage);
                        Scp.mmc.setShutterOpen(false);
                hConvertedImage = libpointer('voidPtr');%This does not live on the camera
                calllib('SpinnakerC_v140','spinImageCreateEmpty',hConvertedImage);
                calllib('SpinnakerC_v140','spinImageConvert',hResultImage,'PixelFormat_Mono16',hConvertedImage);
                
                gData = libpointer('int16Ptr',zeros(Scp.Camera.Width*Scp.Camera.Height,1));
                calllib('SpinnakerC_v140','spinImageGetData',hConvertedImage,gData);
                Scp.studio.displayImage(gData.Value);
                
                calllib('SpinnakerC_v140','spinImageRelease',hResultImage);
            end
            
            calllib('SpinnakerC_v140','spinCameraEndAcquisition',Scp.Camera.Camera);
        catch
            disp('something went horribly wrong!')
            %calllib('SpinnakerC_v140','spinImageDestroy',hConvertedImage);
            calllib('SpinnakerC_v140','spinImageRelease',hResultImage);
            calllib('SpinnakerC_v140','spinCameraEndAcquisition',Scp.Camera.Camera);
        end
    end
end