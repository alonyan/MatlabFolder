
function ReturnVal = MinFun(yd, NS, ftime) 
% The function which will organize the optimal adjustment 
%  of the boundary conditions and final time 
global x y 
n= length(yd); 
nstate = n-1;
if n > NS 
 for i = 1:1:n-1 
    ys(i) = yd(i); 
   end 
else 
   for i = 1:1:n; 
      ys(i) = yd(i); 
   end 
end

if n > NS 
   tf = yd(n); 
else 
   tf = ftime; 
end

tspan = [0, 1]; 
 

[x y] = ode45('state', tspan,ys,[],tf);

nd = length(x);

for i = 1:1:n-1 
   yf(i) = y(nd,i); 
end

bvec = feval('Bc',0,tf,ys,yf);

% setting up the least square error 
NBC = length(bvec); 
sum = 0.0; 
for i = 1:NBC 
   sum = sum + bvec(i)*bvec(i); 
end

ReturnVal = sum; 
 
 

