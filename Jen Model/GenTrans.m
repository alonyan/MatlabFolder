function dx=GenTrans(t,x,tim,transcription,translation)
decay1 = 1/12;
decay2 = 1/3;

transcript = interp1(tim,transcription(tim),t);
translat = interp1(tim,translation(tim),t);

dx(1) = transcript-decay1.*x(1);

dx(2)= translat.*x(1)-decay2.*x(2);


dx = dx'




