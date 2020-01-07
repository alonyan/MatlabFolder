function [p,s]=perdecomp(u)
% %   u : "input graylevel image",
% %   p : "periodic component",
% %   s : "smooth component"

  [ny,nx] = size(u);
  s = zeros(ny,nx);

% %    fill "boundary image" 
  b = double(u(1,:) - u(ny,:));
  s(1,:) = b;
  s(ny,:)= - b; 

  b = double(u(:,1) - u(:,nx));
  s(:,1) =s(:,1) + b;
  s(:,nx) = s(:,nx) - b;

% %   Fourier transform 
  fft2_s=fft2(s);
 
  cx = 2.0*pi/double(nx);
  cy = 2.0*pi/double(ny);

% %  frequencies computation
  mat_x=double(repmat([0:(round(nx/2)-1) (floor(nx/2)):-1:1],[ny,1]));
  mat_y=double(repmat([0:(round(ny/2)-1) (floor(ny/2)):-1:1]',[1,nx]));
  b=0.5./double(2.0-cos(cx*mat_x)-cos(cy*mat_y));
  fft2_s = fft2_s .* b;
  
% %  (0,0) frequency
  fft2_s(1,1) = 0.0;
  
% %  inverse Fourier transform 
  s=real(ifft2(fft2_s));
  
% %   get p=u-s 
  p = double(u)-s;

