
function dsys = state(x, y, flag, tf) 
% the state space definition of the system 
dsys =tf* [ y(2), y(3), ( -y(1)*y(3))]';
