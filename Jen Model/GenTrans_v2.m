function dx=GenTrans_v2(t,x,tim,transcription,translation)
decay1 = 1/12;
decay2 = 1/5;
alpha = 1/20;

transcript = interp1(tim,transcription(tim),t);
translat = interp1(tim,translation(tim),t);

dx(1) = transcript-decay1.*x(1);

dx(2)= translat.*x(1)-alpha.*x(2);

dx(3) = alpha.*x(2)-decay2.*x(3);

dx = dx'




