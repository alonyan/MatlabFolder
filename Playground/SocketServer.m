%%
t = tcpip('0.0.0.0', 30000, 'NetworkRole', 'server', 'InputBufferSize',2.1*10^9);
fopen(t)
pause(1)
while t.BytesAvailable == 0
    pause(0.01)
end
data = uint8(fread(t,t.BytesAvailable));
fclose(t)
