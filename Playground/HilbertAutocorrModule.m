%%

y = autoCorr.Corr;
t = autoCorr.Bins/3;
dt = t(2)-t(1);

z1 = hilbert(y);

A = abs(z1); %envelope
Phase = angle(z1); %phase

% Calculate instantaneous frequency (dphi/dt)
dz1 = padarray((z1(3:end)-z1(1:end-2))./(2*dt),[0,1]);
Freq = imag(dz1./z1)/2/pi;

%Smoothen frequency calculation
%N = 5;
z1Smooth = Smoothing(abs(z1).^2);
z1dz1Smooth = Smoothing(conj(z1).*dz1);
FreqSmooth = imag((z1dz1Smooth)./(z1Smooth))/2/pi;

plot(t,y,t,A.*exp(1i.*Phase), t,A); shg
figure()
plot(t,Freq,t,FreqSmooth); shg
xlabel('time')
ylabel('frequency')