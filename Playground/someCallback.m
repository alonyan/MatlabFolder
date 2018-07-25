function someCallback(Scp)
global KEY_IS_PRESSED

figure(417)
set(417,'Windowstyle','normal','toolbar','none','menubar','none','Position',[863 892 250 75],'Name','Snap Snap','NumberTitle','off')
h = uicontrol(417,'Style', 'togglebutton','Position',[50 0 150 50],'fontsize',13, 'String', 'Stop', 'Value',0,'callback',@(x,y) myKeyPressFcn(x,y,Scp));
KEY_IS_PRESSED = h.Value;

try
    calllib('SpinnakerC_v140','spinCameraBeginAcquisition',Scp.Camera.Camera);
    while ~KEY_IS_PRESSED
        drawnow
        hResultImage  =  libpointer('voidPtr');
        calllib('SpinnakerC_v140','spinCameraGetNextImage',Scp.Camera.Camera,hResultImage);
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

disp('loop ended')

    function myKeyPressFcn(hObject, event, Scp)
        KEY_IS_PRESSED  = 1;
        h = uicontrol(417,'Style', 'togglebutton','Position',[50 0 150 50],'fontsize',13, 'String', 'Live', 'Value',1,'callback',@(x,y) onLoopingFcn(x,y,Scp));
        disp('key is pressed')
    end

    function onLoopingFcn(hObject, event, Scp)
        
        h = uicontrol(417,'Style', 'togglebutton','Position',[50 0 150 50],'fontsize',13, 'String', 'Stop', 'Value',0,'callback',@(x,y) myKeyPressFcn(x,y,Scp));
        KEY_IS_PRESSED = h.Value;
        
        try
            calllib('SpinnakerC_v140','spinCameraBeginAcquisition',Scp.Camera.Camera);
            while ~KEY_IS_PRESSED
                drawnow
                hResultImage  =  libpointer('voidPtr');
                calllib('SpinnakerC_v140','spinCameraGetNextImage',Scp.Camera.Camera,hResultImage);
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
        
        disp('loop ended')
    end
end