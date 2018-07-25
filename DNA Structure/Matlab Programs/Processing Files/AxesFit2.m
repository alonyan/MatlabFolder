function FitParam=AxesFit2(x, y, FUN, BETA0, sigma, param);

    weighted = (nargin >= 5)&(~isempty(sigma));
    if (nargin == 6)
        AdditionalParam = (~isempty(param));
    else
        AdditionalParam = 0;
    end;
    
    F=axis;
   
    SizeX=length(x);
    SizeY=length(y);  
    
    minval = min(find(x>F(1)));
    maxval = max(find(x<F(2)));
    
    NewX = x(minval:maxval);
    NewY = y(minval:maxval);
    
    if weighted
        NewS = sigma(minval:maxval);
        
        if AdditionalParam 
            [BETA, delta, resid] = nlinfitWeight1(NewX,NewY, FUN, BETA0, NewS, param);
        else
            [BETA, delta, resid] = nlinfitWeight1(NewX,NewY, FUN, BETA0, NewS);
        end;
        
        if AdditionalParam
            semilogx( x, y, NewX, feval(FUN, BETA, NewX, param));
        else
            semilogx( x, y, NewX, feval(FUN, BETA, NewX));
        end;
        
        FitParam.beta = [BETA delta];
        FitParam.errBeta = delta;
        FitParam.chiSqNorm = sum(resid.^2)/(maxval-minval);
        FitParam.x = NewX;
        FitParam.residNorm = resid;
        if AdditionalParam
            FitParam.y = feval(FUN, BETA, NewX, param);
        else
           FitParam.y = feval(FUN, BETA, NewX);
        end;
    else
    end;