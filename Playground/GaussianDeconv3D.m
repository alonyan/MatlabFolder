Data = stkread(MD,'Channel','DeepBlue', 'flatfieldcorrection', false, 'Position', '1-Pos_000_000');
%%

Gx = GaussianFit( [1, 2049/2, 1],1:2048);
Gz = GaussianFit( [1, 86/2, 1],1:85);

Gxy = (Gx'*Gx);
Gxz = (Gx'*Gz);
Gxyz = repmat(Gxy,1,1,size(Gz,2)).*permute(repmat(Gxz',1,1,size(Gxy,1)),[2,3,1]);
Gfft = fftn(Gxyz);
Gfft = fftshift(Gfft);
%%
 
datafft = fftn(Data);
datafft = fftshift(datafft);
AA = ifftshift(ifftn(datafft.*Gfft));

stkshow(abs(AA)./max(abs(AA(:))))


