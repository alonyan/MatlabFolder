function E=Cost(x,t,fun,y)
% if exist argin
% fx = fun(x,t,argin);
% else
fx = fun(x,t);

E = (norm(y-fx))^2;