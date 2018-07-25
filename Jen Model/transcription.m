function transcription = transcription(tim , tstop, tau0,tau1, k0,k1)

transcription = k0*(1-exp(-tim./tau0)).*(logical((tim>=0).*(tim<=tstop)))+((k0)*(1-exp(-tstop./tau0)).*exp(-(tim-tstop)./tau1)+k1.*(1-exp(-(tim-tstop)./tau1))).*logical(tim>tstop);
