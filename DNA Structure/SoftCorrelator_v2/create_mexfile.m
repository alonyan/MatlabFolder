cd '/Users/Alonyan/Downloads/SoftCorrelator_v2';
mex -v -compatibleArrayDims SoftCorrelator.cpp Correlator.cpp CountCorrelator.cpp

%% test

t = 0:1e5;
photonArray  =  sin(2*pi*t/100);

corr = SoftCorrelator_v2(photonArray, 'PhCountCorr', 1)