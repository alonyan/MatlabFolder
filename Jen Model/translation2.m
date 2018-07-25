function translation2 = translation2(tim , tstop, tau0, k0)

%translation = repmat(0.1021,length(tim),1);

translation2 = 0.4*(1-exp(-tim./5))+0.1 %translational dynamics