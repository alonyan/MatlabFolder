function corr = SoftCorrelator_v2(photonArray, CorrelatorType, timebase_ms)

% PhotonArray is a vector of delay times between the photon counts or
% a vector of counts per sampling interval

% Valid values for CorrelatorType are
% 'PhHistoryCorr' and 'PhCountCorr'

% timebase_ms defines the clock period of the hardware counters in ms

if strcmp(CorrelatorType, 'PhHistoryCorr'),
    y = SoftCorrelator(photonArray);
    corr.countrate = length(photonArray)/sum(photonArray)/timebase_ms;
elseif strcmp(CorrelatorType, 'PhCountCorr'),
    y = CountCorrelator(photonArray);
    corr.countrate = sum(photonArray)/length(photonArray)/timebase_ms;
else
    error('Invalid correlator type !');
end;


corr.lag = y(:, 2)*timebase_ms;
corr.corrfunc = y(:, 1);
corr.weights = y(:, 3);
J = find(corr.weights > 0);
corr.lag = corr.lag(J);
corr.corrfunc = corr.corrfunc(J);
corr.weights = corr.weights(J);

