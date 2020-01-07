function E = simpEntropy(J1)
h = histcounts(J1,'Normalization','probability');

E = -nansum(h.*log(h));