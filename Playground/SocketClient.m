
%%
byteStream = getByteStreamFromArray(Stk);
t = tcpip('localhost', 30000, 'NetworkRole', 'client', 'OutputBufferSize',2.1*10^9)
fopen(t)
pause(1)
fwrite(t,byteStream)
fclose(t)