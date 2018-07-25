function y=Stick_DiffusionFit(beta, x);
A = beta(1); % overall amplitude
tauD = beta(2); %diffusion time
tau_im = beta(3);% life time of immobile fraction
tau_mob = beta(4);% life time of mobile fraction
Bmob = tau_mob/(tau_mob + tau_im);
Bim = 1 - Bmob;

y=A * (Bmob./(1 + x/tauD).*exp(-x/tau_im)  + Bim*exp(-x/tau_mob));