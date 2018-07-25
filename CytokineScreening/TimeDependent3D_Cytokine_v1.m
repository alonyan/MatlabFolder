function S = TimeDependent3D_Cytokine_v1(t, x, J, varargin)
% solve 3D diffusion/consumption equation for flux J of molecules. See notes: 
% /Users/oleg/Documents/Derivations/Cytokine Distribution 1D/pSTAT5_1D.pdf
%
% The numeric solution is based on Matlab functions described in 
% http://www.mathworks.com/help/matlab/ref/pdepe.html
% optional parameters come in pairs
% 'Dimensionality' - m (2 by default) change between 0 to 2.
% 'Hill' - h (1 by default) the Hill coefficient
% 'ksi' - screening length i the units of R (1 by default)
% Distance is measured in the units of cell radius R, concentration in EC50
% and the total flux is in fact (the rate of cytokine secretion)/(4*pi*R*D*EC50)

    m = ParseInputs('Dimensionality', 2, varargin); % geometry of the problem
    h = ParseInputs('Hill', 1, varargin);
    ksi = ParseInputs('ksi', 1, varargin);
        doZeroPad = ParseInputs('ZeroPad', 1, varargin);
            InitCond = ParseInputs('Initial Conditions', NaN, varargin);
    
    if isnan(InitCond),
        C = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);
    else
        C = pdepe(m,@pdex1pde,@pdex1icNonZero,@pdex1bc,x,t);
    end

    S.profiles.t = t;
    S.profiles.r = x(:);
    S.profiles.C = C';
    % calculate response functions
    S.profiles.response = S.profiles.C./(1+S.profiles.C);
    
       %for zero-padding for Fourier transform
    minx = min(x);
    dx = median(diff(x));
    xpad = ((dx/2):dx:minx)';
    ypad = zeros(size(xpad));
    
    for i = 1:length(t),
        % CF of concentrations
        if doZeroPad,
            Y.r = [xpad; S.profiles.r];
            Y.fr = [ypad; S.profiles.C(:, i)];
        else
            Y.r = S.profiles.r;
            Y.fr = S.profiles.C(:, i); 
        end;
        
        FY = FourierTransform(Y, '3D');

        FYsq.r = FY.q;
        FYsq.fr = abs(FY.fq).^2;
        CF = FourierTransform(FYsq, '3D');
        S.CF.r = CF.q;
        S.CF.G(:, i) = CF.fq;
        
        % CF of response 
        if doZeroPad,
            Y.r = [xpad; S.profiles.r];
            Y.fr = [ypad; S.profiles.response(:, i)];
        else
            Y.r = S.profiles.r;
            Y.fr = S.profiles.response(:, i); 
        end;
        
        FY = FourierTransform(Y, '3D');

        FYsq.r = FY.q;
        FYsq.fr = abs(FY.fq).^2;
        CF = FourierTransform(FYsq, '3D');
        %S.CF.r = CF.q;
        S.CF.Gresponse(:, i) = CF.fq;
       
    end;
    
    
    
    function [a,f,s] = pdex1pde(x,t,u,DuDx) % The equation
        a = 1;
        f = ksi^2*DuDx;
        s = -1./(1+u.^(-h)); % the consumption term
    end
    % --------------------------------------------------------------
    function u0 = pdex1ic(x) % initial conditions
        u0 = 0;
    end
    % --------------------------------------------------------------
    function [pl,ql,pL,qL] = pdex1bc(xl,ul,xr,ur,t) % boundary conditions
        pl = J*ksi^2;
        ql = 1;
        pL = 0;
        qL = 1;
    end
    %---------------------------------------------------------------
        function u0 = pdex1icNonZero(X) % nonzero initial conditions
        u0 = interp1(x, InitCond, X);
    end
    % --------------------------------------------------------------
   
end
