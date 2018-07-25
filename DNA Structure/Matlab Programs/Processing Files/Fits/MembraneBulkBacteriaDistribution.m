function y = MembraneBulkBacteriaDistribution(beta, x, FieldParam)

wXY = FieldParam(1);
wSq = FieldParam(2);
MolBr = FieldParam(3); % molecular brightness
PixSize = FieldParam(4);
SamplTime = FieldParam(5); % time per pixel

Ns = beta(1); % No of molecules at the surface in pi wXY^2 area
Nb = beta(2); % No of molecules in the bulk in a full sampling volume pi^(3/2) wXY^2 wZ
R = beta(3); % radius of bacteria
Xc = beta(4); % center of bacteria

wXYSq = wXY^2;
wZSq = wXYSq*wSq;
x = (x-Xc) * PixSize; % pixels to um
for i = 1:length(x),
    y(i) = Ns*MolBr*2/sqrt(pi)*R/wXY*quadgk( @(phi) MembraneFunc(phi,  x(i), R, wXYSq, wZSq), 0, 2*pi ) + Nb*MolBr*2/(wXY*sqrt(wZSq)*pi)*dblquad( @(phi, r) BulkFunc(phi, r,  x(i), wXYSq, wZSq), 0, 2*pi, 0, R, 1e-7);
end;


function ys = MembraneFunc(phi, x0, R, wXYSq, wZSq)
ys = exp(- 2*(R*cos(phi) - x0).^2/wXYSq - 2*R^2*sin(phi).^2/wZSq);

function ys = BulkFunc(phi, r, x0, wXYSq, wZSq)
ys = r.*exp(- 2*(r.*cos(phi) - x0).^2/wXYSq - 2*r.^2.*sin(phi).^2/wZSq);
