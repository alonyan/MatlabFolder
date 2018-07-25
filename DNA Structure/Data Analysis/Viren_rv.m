[coefs,scores,variances,t2] = princomp(Rv);
percent_explained = 100*variances/sum(variances)