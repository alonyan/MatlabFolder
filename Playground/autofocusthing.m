figure
range = 400:1000;
Nbef = 1;
tic
maxCor = [];
maxFit = [];
opts = optimset('Display','off');
for Naft = 1:101;
before.fr = 1000*scans(Nbef,range)./sum(scans(Nbef,range));
after.fr = 1000*scans(Naft,range)./sum(scans(Naft,range));


flt = GaussianFit([1, 0, 4], -30:30);%sum(fspecial('gauss', 150, 50));

before.fr = sqrt((before.fr - filtfilt(flt, 1, before.fr)).^2);
after.fr = sqrt((after.fr - filtfilt(flt, 1, after.fr)).^2);

before.fr = filtfilt(flt, 1, before.fr);
after.fr = filtfilt(flt, 1, after.fr);

before.r = 1:length(before.fr);
after.r = 1:length(after.fr);

aftq = FourierTransform(after);
befq = FourierTransform(before);



crs.r = aftq.q;
crs.fr = aftq.fq.*conj(befq.fq);
crsFT = FourierTransform(crs);
subplot(2,1,1)
semilogy(aftq.q, abs(aftq.fq))
set(gca,'xlim',[0,1]);
subplot(2,1,2)
maxCor(Naft) = crsFT.q((abs(crsFT.fq) == max(abs(crsFT.fq))));
%beta = lsqcurvefit(@GaussianWithBackgroundFit,[3000 maxCor(Naft), 50, 100], crsFT.q, abs(crsFT.fq),[],[],opts);
%maxFit(Naft) = beta(2);
%x = -300:0.1:300;
%p = GaussianWithBackgroundFit(beta, x);
plot(crsFT.q,abs(crsFT.fq))
shg
end;
toc

plot(1:101, maxCor)%, 1:101, maxFit
shg