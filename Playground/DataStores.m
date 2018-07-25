

NFrames = 428;
%%
%Scp.studio.displays().createDisplay(store);

%profile on
function snapSeqDatastore(Scp,pth,NFrames)
store = Scp.studio.data().createMultipageTIFFDatastore(pth,false,false);
builder = Scp.studio.data().getCoordsBuilder().z(0).channel(0).stagePosition(0);
curFrame = 0;
Scp.mmc.startSequenceAcquisition(NFrames, 0, false);
while((Scp.mmc.getRemainingImageCount()>0) || (Scp.mmc.isSequenceRunning(Scp.mmc.getCameraDevice())))
    if (Scp.mmc.getRemainingImageCount()>0)
        timg = Scp.mmc.popNextTaggedImage();
        img = Scp.studio.data().convertTaggedImage(timg, builder.time(curFrame).build(),'');
        store.putImage(img);
        curFrame=curFrame+1;
    else
        Scp.mmc.sleep(min(0.5*Scp.Exposure,2))
    end
end
Scp.mmc.stopSequenceAcquisition();
Scp.studio.displays().manage(store);
store.close();
end