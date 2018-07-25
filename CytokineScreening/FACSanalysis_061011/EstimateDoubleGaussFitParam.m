function beta0 = EstimateDoubleGaussFitParam(x, h),
    h = h(:)/sum(h);
    pos = x(:)'*h/sum(h);
    stdev = sqrt(x(:).^2'*h - pos^2);
    amp = max(h)*sqrt(2*pi)*stdev;
    
    beta0 = [amp/2 pos-stdev stdev/2 amp/2 pos+stdev stdev/2];

end

