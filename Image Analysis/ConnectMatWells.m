function CM = ConnectMatWells(W,n1,n2)
if n2<=n1
    error('Damn fool!')
end
CM = double(W{n1}.Link21Mat');
for i=n1+1:n2-1
    try
    CM=CM*double(W{i}.Link21Mat');
    catch
        CM=0;
        return;
    end
end
end