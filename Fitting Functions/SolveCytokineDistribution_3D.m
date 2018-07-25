function SteadyState = SolveCytokineDistribution_3D(beta, L)
% calculation of steady state cytokine distributions in 3D geometry in conditions of
% nonlinear consumption. See notes pSTAT5_1D.pdf .
% The concentrations are expressed in terms of EC50.
% The boundary condtions are:
% 1) constant flux J at r = 0
% 2) zero flux at r = L, or z = L/xi => this condition is expressed through
%    a fitting parameter CL (see notes);
%
% ksi - is screening length in the units of cell radius R (1 by default)
% Distance is measured in the units of cell radius R, concentration in EC50
% and the total flux is in fact (the rate of cytokine
% secretion)/(4*pi*R*D*EC50). In the absence of screening this ratio gives
% (the cytokine concentration/EC50) at the cell surface.
Amp = beta(1);
J = beta(2);
ksi = beta(3);

L = [0.5 L 200];

solinit = bvpinit(L, @DiffConsInit);
sol = bvp4c(@DiffCons,@DiffConsBC,solinit);

SteadyState.r = sol.x';
SteadyState.C = sol.y(1, :)';
SteadyState.response = SteadyState.C./(1+SteadyState.C);


    function dydx = DiffCons(x, y) %Laplace eqn
    dydx = [y(2);
            y(1)./(1+y(1))/ksi^2-2*y(2)./x];
    end

    function res = DiffConsBC(ya, yb) %boundary conditions
        res = [ya(2)+2*J;
            yb(2)];
    end

    function yinit = DiffConsInit(x)
        yinit = [zeros(size(x));
            zeros(size(x))];
    end
end