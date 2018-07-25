function [fy, q] = ffteven(y, varargin)

% does fft under assumption that function y is an even function of x
% and that it is defined as a vector on [0, Xmax] equally spaced interval.
% FFTEVEN further normalizes the function as a regular symmetric 
% Fourier transform.
% first three parameters like in fft
% next parameter:
% dX

if isvector(y),    
    if length(varargin) == 0,
         N = length(y);
    else
        N = varargin{1};
    end;
    
    fy = 2*real( fft(y, 2*N-1) ) - y(1);
    fy = fy(1 : N);
    
    if length(varargin) == 3,
        dx = varargin{3};
    else
        dx = 1;
    end;
    
    q = 2*pi*(0:(N-1))/(2*N-1)/dx;
    fy = fy*dx/sqrt(2*pi);
    
elseif length(size(y)) ==2, % matrix
    if length(varargin) == 0,
        DIM = 1;
         N = size(y, DIM);
         dx = 1;
    elseif length(varargin) ==1,
        DIM = 1;
        N = varargin{1};
        if isempty(N),
            N = size(y, DIM);
        end;
        dx = 1;
    elseif length(varargin) ==2,
        DIM = varargin{2};
        if isempty(DIM),
            DIM =1;
        end;
         
        N = varargin{1};
        if isempty(N),
            N = size(y, DIM);
        end;
        dx = 1;
    else
         DIM = varargin{2};
        if isempty(DIM),
            DIM =1;
        end;
         
        N = varargin{1};
        if isempty(N),
            N = size(y, DIM);
        end;
        dx = varargin{3};
    end;
        
    fy = 2*real( fft(y, 2*N-1, DIM) );
    if DIM ==1;
       fy = fy - repmat(y(1, :), size(fy, 1), 1);
       fy = fy(1:N, :);
    else
        fy = fy - repmat(y(:, 1), 1, size(fy, 2));
        fy = fy(:, 1:N);
    end;
    q = 2*pi*(0:(N-1))/(2*N-1)/dx;
    fy = fy*dx/sqrt(2*pi);
else
    error('Larger than 2 dimensions are not applicable yet!')
end;

    