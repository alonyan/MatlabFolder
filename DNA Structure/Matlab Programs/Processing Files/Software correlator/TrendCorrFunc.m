function corrTr = TrendCorrFunc(trace, smoothingLevel, trace_timebase, fraction_timebase)

traceSmooth = interp1(smooth(trace, smoothingLevel), 1:fraction_timebase:length(trace));
corrTr = SoftCorrelator_v2(traceSmooth, 'PhCountCorr', trace_timebase * fraction_timebase);