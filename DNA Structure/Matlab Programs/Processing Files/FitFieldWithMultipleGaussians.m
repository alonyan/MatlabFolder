function y = FitFieldWithMultipleGaussians(beta, t_ind,  param)

type = param{1};
if strfind(type, 'Uniform'),
    N = param{2};
    w0= beta(1);
    sigma = beta(2);
    Gstruc = param{3};
    slow = param{4};
    fast = param{5};
    wSq = param{6};
    
    w= w0 + (-N:N)/N*3*sigma;
% tabulate Rsq for zero speed;
    Rsq_tab = 10.^(-3:0.01:0);
    [RSQtab, W] = meshgrid(Rsq_tab, w);
    if strcmp(type, 'UniformField'),
        G0_tab = sum(1./(W.^2 + 2/3*RSQtab))/sum(1./w.^2);
    elseif strcmp(type, 'UniformSum'),
        G0_tab = sum(1./(1 + 2/3*RSQtab./W.^2))/length(w);
    end;
    clear RSQtab W;
% calculate Rsq from G0 and a table;
    Rsq = interp1(G0_tab, Rsq_tab, Gstruc.ReNormalized(t_ind, slow), 'linear', 'extrap');
% calculate G for speed:
    [RSQ, W] = meshgrid(Rsq, w);
    VT = meshgrid(Gstruc.vt_um(t_ind, fast), w);
    
      if strcmp(type, 'UniformField'),
          y = sum(1./(W.^2 + 2/3*RSQ).*exp(-VT.^2./(W.^2 + 2/3*RSQ))) / sum(1./w.^2);
      elseif strcmp(type, 'UniformSum'),
           y = sum(1./(1 + 2/3*RSQ./W.^2).*exp(-VT.^2./(W.^2 + 2/3*RSQ))) / length(w);
      end;
      
    y = y(:);
    
    y = (y./Gstruc.ReNormalized(t_ind, slow)).^(1./Gstruc.ReNormalized(t_ind, slow));
end;