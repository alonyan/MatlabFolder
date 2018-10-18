function [segim,rootim, linkim] = watershed3D(inim)

[Nx, Ny, Nz] = size(inim);
%augim = zeros(Nx+2, Ny+2, Nz+2, class(I))+(max(inim(:))+1);
%malloc
x=2:Nx+1;
y=2:Ny+1;
z=2:Nz+1;
%augim(x,y,z)=inim;
augim = padarray(inim,[1 1 1], max(inim(:))+1);

minim=inim;
linkim0=uint32(reshape(find(inim>(min(inim(:))-1)),size(inim)));

linkim=linkim0;

for i=-1:+1
    for j=-1:+1
        for k=-1:+1
            shiftim = augim(x+i,y+j,z+k);
            ind = find(shiftim<minim);
            if ~isempty(ind)
                [u, v, w] = ind2sub([Nx,Ny,Nz], ind);
                minim(ind) = shiftim(ind);
                linkim(ind) = linkim0(sub2ind([Nx,Ny,Nz],u+i,v+j,w+k));
            end
        end
    end
end
clear augim minim shiftim x y z u v w i j k;

% propagate links
newlink = linkim(linkim);

while any(newlink(:)~=linkim(:))
    linkim = newlink;
    newlink = linkim(linkim);
end
clear newlink

rootim = uint32(bwlabeln(linkim==linkim0));
clear linkim0

segim = rootim(linkim);
