% Make fake data
close all
dt = 0.01;
t = 0.01:dt:10;
y = (4*cos(3*2*pi*(t+0.1))).*exp((-(t-t(round(end/2))).^2)./0.5)+0.1*randn(1,size(t,2));
% Calculate hilbert transform
z1 = hilbert(y);

A = abs(z1); %envelope
Phase = angle(z1); %phase

% Calculate instantaneous frequency (dphi/dt)
dz1 = padarray((z1(3:end)-z1(1:end-2))./(2*dt),[0,1]);
Freq = imag(dz1./z1)/2/pi;

%Smoothen frequency calculation
N = 5;
z1Smooth = filtfilt(ones(N,1),1,abs(z1).^2);
z1dz1Smooth = filtfilt(ones(N,1),1,conj(z1).*dz1);
FreqSmooth = imag((z1dz1Smooth)./(z1Smooth))/2/pi;

plot(t,y,t,A.*exp(1i.*Phase), t,A); shg
figure()
plot(t,Freq,t,FreqSmooth); shg
xlabel('time')
ylabel('frequency')