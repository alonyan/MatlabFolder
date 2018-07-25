function Im = GradMag(A) 
    f = fspecial('sobel');
    Im = sqrt(imfilter(A, f, 'replicate').^2+ imfilter(A, f', 'replicate').^2);
end