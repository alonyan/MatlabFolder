function dz=DiffCons3d(r,z)


%transcript = interp1(tim,transcription(tim),t);
%translat = interp1(tim,translation(tim),t);

dz(1) = z(2);

dz(2)= z(1)./(z(1)+r);

dz = dz';



