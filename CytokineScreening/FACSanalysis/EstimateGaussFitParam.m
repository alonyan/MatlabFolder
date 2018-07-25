function beta0 = EstimateGaussFitParam(x, h),
    h = h(:)/sum(h);
    pos = x(:)'*h/sum(h);
    stdev = sqrt(x(:).^2'*h - pos^2);
    amp = max(h)*sqrt(2*pi)*stdev;
    
    beta0 = [amp pos stdev];

end

