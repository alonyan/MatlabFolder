function estCellSize = EstSize(filepath)

img = double(imread(filepath));
img = img./max(img(:));

flt = GaussianFit([1, 0, 2], -30:30);

Line1 = filtfilt(flt, 1, [img(round(end/4),:) img(round(end/2),:) img(round(3*end/4),:)]);
Line1 = Line1./max(Line1);
plot(Line1)

[pks, locs] = findpeaks(Line1);
locs = locs(pks>0.5);
locs = locs(find((locs>10).*(locs<(length(Line1)-10))));
estCellSize = []
for i=1:length(locs)
    sides = 10;
    L1 = Line1(locs(i)-sides:locs(i)+sides);
    L1 = L1-min(L1);
    L1 = L1./sum(L1);
    %
    %plot(L1)
    %shg;
    %pause
    estCellSize = [estCellSize sqrt(((-sides:sides).^2)*L1')];
end
estCellSize = round(mean(estCellSize));
end