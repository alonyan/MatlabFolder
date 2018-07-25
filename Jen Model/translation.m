function translation = translation(tim , tstop, tau0, k0)

translation = repmat(0.1021,length(tim),1);


%translation = 0.4*(1-exp(-tim./50))+0.1 %translational dynamics