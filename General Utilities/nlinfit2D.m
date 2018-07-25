function     [BETA,R,J,SIGMA,MSE] = nlinfit2D(x,y, Z, modelFun, beta0, varargin) 
% the function uses standard nlinfit procedure to fit 
% function Z=f(X, Y)

 [X, Y] = meshgrid(x, y); 
 XY(:, :, 1) = X;
 XY(:, :, 2) = Y;
 Z1 = Z(:);
 
 [BETA,R,J,SIGMA,MSE] = nlinfit(XY, Z1, @MyModel, beta0, varargin) ;
 
 R= reshape(R, size(Z));
 
    function Z1 = MyModel(beta, XY)
        X = XY(:, :, 1);
        Y = XY(:, :, 2);
        Z = modelFun(beta, X, Y);
        Z1 = Z(:);
    end   
end

