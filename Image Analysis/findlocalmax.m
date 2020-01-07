function outim = findlocalmax(inim)
[Nx, Ny, Nz]=size(inim);
x=2:Nx+1;
y=2:Ny+1;
z=2:Nz+1;
%augim(x,y,z)=inim;
augim = padarray(inim,[1 1 1], max(inim(:))+1);
outim = ones([Nx Nz Ny], 'uint8');
for i=-1:1
    for j=-1:1
        for k=-1:1
            outim(augim(x+i,y+j,z+k)>inim) = 0;
        end
    end
end