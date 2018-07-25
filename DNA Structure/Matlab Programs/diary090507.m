help fft
 FFT Discrete Fourier transform.
    FFT(X) is the discrete Fourier transform (DFT) of vector X.  For
    matrices, the FFT operation is applied to each column. For N-D
    arrays, the FFT operation operates on the first non-singleton
    dimension.
 
    FFT(X,N) is the N-point FFT, padded with zeros if X has less
    than N points and truncated if it has more.
 
    FFT(X,[],DIM) or FFT(X,N,DIM) applies the FFT operation across the
    dimension DIM.
    
    For length N input vector x, the DFT is a length N vector X,
    with elements
                     N
       X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
                    n=1
    The inverse DFT (computed by IFFT) is given by
                     N
       x(n) = (1/N) sum  X(k)*exp( j*2*pi*(k-1)*(n-1)/N), 1 <= n <= N.
                    k=1
 
    See also <a href="matlab:help fft2">fft2</a>, <a href="matlab:help fftn">fftn</a>, <a href="matlab:help fftshift">fftshift</a>, <a href="matlab:help fftw">fftw</a>, <a href="matlab:help ifft">ifft</a>, <a href="matlab:help ifft2">ifft2</a>, <a href="matlab:help ifftn">ifftn</a>.

    Overloaded functions or methods (ones with the same name in other directories)
       <a href="matlab:help uint8/fft.m">help uint8/fft.m</a>
       <a href="matlab:help uint16/fft.m">help uint16/fft.m</a>
       <a href="matlab:help gf/fft.m">help gf/fft.m</a>
       <a href="matlab:help qfft/fft.m">help qfft/fft.m</a>
       <a href="matlab:help iddata/fft.m">help iddata/fft.m</a>

    Reference page in Help browser
       <a href="matlab:doc fft">doc fft</a>



a=1:5

a =

     1     2     3     4     5

diary off
