function CM = ConnectivityMat(LinkMatCell,n1,n2)
if n2<=n1
    error('Damn fool!')
end
CM = double(LinkMatCell{n1});
for i=n1+1:n2-1
    CM=double(LinkMatCell{i})*CM;
end
end