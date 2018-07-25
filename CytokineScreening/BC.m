
function bvector = BC(t0, tf, yi, yf) 
% 
% This is where the boundary conditions are specified 
% The conditions are specified such that the right hand sides are zero 
%  This will allow mixed BC's
one = yi(1) ; 
two = yi(2) ; 
three = yf(2) -1.0; 
 

bvector = [one two three];

 
 