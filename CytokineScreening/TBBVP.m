% Solution to TBBVP ( Two Point Boundary value Problem) for ODE 
% 
% Dr. P.Venkataraman, RIT Mechanical Engineering 
%  June 1998 
% 
% Using ODE45 and FMINS (non-stiff differential equations) 
% Problem must be described in state space as a 
% System of first order equations in a function M-file - state.m 
%----------- 
%  STATE.m  | 
%----------- 
% [ STATE.m is similar to Function F(T,Y) described in ODE45] 
% except the differential system must be normalized with respect 
% to final time - i.e. the final time is one (1)-final time not known before 
% 
% function dsys = state(x, y, flag, tf) 
% where x: independent variable 
%       y: dependent vector - state derivatives 
%       flag: ignore 
%       tf:  final time 
% ----   all derivatives must be multipled by tf --- 
% This is useful for unknown final time problems 
% 
% Boundary Conditions are described in a function M-file  - BC.m 
%-------- 
% BC.m  | 
%------- 
%  function bvector = BC(t0,tf, yi, yf) 
%           Y(T0) = Vector of initial conditions of state 
%           Y(Tf) = Vector of Final conditions of state after call to ODE45 
% The function should return returns an vector of 
%  Boundary Conditions set up with the 
%  Right Hand Side to be 0 (ZERO) when satisfied 
% 
%----------- 
% MinFun.m 
%---------- 
% Calls the Runge-Kutta method  and sets up the optimization problem 
% based on the least square error in the boundary conditions 
% and final time 
% function ReturnVal = MinFun(yd,NS,ftime) 
% 
  
 
% input the starting design vector - intial conditions fo the problem

global x y        % global makes the variables available 
                % in the other functions 
                % otherwise variables only have function scope 
  
 

ok = 1; 
while (ok)  % this is true 
   string1 = ['\nInput a starting guess for the initial value vector' ... 
         '\nThis is mandatory as the length of the vector indicates the ' ... 
         '\norder of the system. Please enter it now and hit return : \n'];

   yinit = input(string1); 
   if (isempty(yinit) == 0) 
      break; 
   end 
end 
NSYS = length(yinit); 
fprintf('\nThe initial state vector(guessed) is : \n'); 
disp(yinit); 
fprintf('\n')  %  line feed in the display

% check if final time is unknown 
finaltime = input('Is final time unknown ? (y/n)','s');

if finaltime == 'y' | finaltime == 'Y' | finaltime == 'yes' ... 
      | finaltime == 'YES' 
   tfguess  = input('final time - if unknown then this is a guess [1]: ') 
   ftm = tfguess; 
   if isempty(tfguess) 
      tfguess = 1; 
      ftm = tfguess; 
   end 
   fprintf('\n'); 
   y0 = [yinit tfguess] 
else 
    ftm = input('final time :  ') 
   y0 = yinit; 
end

% call the fmins function with additional parameters 
[YD, OPT] = fmins('MinFun',y0,[0 , 1.0e-08],[], NSYS,ftm);

fprintf('\nNumber of iterations : %i5 ',OPT(10)); % this ia s format specifier 
fprintf('\n\n') 
fprintf('The final values for the design vector: \n') 
disp(YD)

fprintf('\nStrike any key to continue \n') 
fprintf('The last element above is the final time \n') 
pause

z = [ x y]; 
disp (z); 
%  you can plot if you like the output 
 
