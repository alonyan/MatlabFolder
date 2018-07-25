figure
range = 401:1200;
Nbef = 50;
%tic
maxCor = [];
maxFit = [];
opts = optimset('Display','off');

flt = GaussianFit([1, 0, 4], -30:30);%sum(fspecial('gauss', 150, 50));
tic
before.fr = 1000*scans(Nbef,range)./sum(scans(Nbef,range));
before.fr = sqrt((before.fr - filtfilt(flt, 1, before.fr)).^2);%get fluctuations
before.fr = filtfilt(flt, 1, before.fr);%remove ~10 component
before.r = 1:length(before.fr);
befq = FourierTransform(before);%calculate FTs

for Naft = 1:101;
after.fr = 1000*scans(Naft,range)./sum(scans(Naft,range));
after.fr = sqrt((after.fr - filtfilt(flt, 1, after.fr)).^2);
after.fr = filtfilt(flt, 1, after.fr);
after.r = 1:length(after.fr);
aftq = FourierTransform(after);%calculate FTs



SF.r = aftq.q;
SF.fr = aftq.fq.*conj(befq.fq);%Calculate structure factor
CorrFun = FourierTransform(SF);%Calculate correlation function
 subplot(3,1,1)
 semilogy(aftq.q, abs(aftq.fq))
 ylabel('FT(after)')
 set(gca,'xlim',[0,2]);
 subplot(3,1,2)
maxCor(Naft) = CorrFun.q((abs(CorrFun.fq) == max(abs(CorrFun.fq))));
%beta = lsqcurvefit(@GaussianWithBackgroundFit,[3000 maxCor(Naft), 50, 100], crsFT.q, abs(crsFT.fq),[],[],opts);
%maxFit(Naft) = beta(2);
%x = -300:0.1:300;
%p = GaussianWithBackgroundFit(beta, x);
plot(CorrFun.q,abs(CorrFun.fq))
ylabel('Corr. Fun.')

shg
end;
toc
subplot(3,1,3)

plot(1:101, maxCor)%, 1:101, maxFit
shg