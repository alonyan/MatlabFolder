function [XTicks, XTickLabel] = LinRangeToTicks(LRx)


        a1 = sort(- (1:9)'*10.^(1:2)); 
        a2 =(1:9)'*10.^(1:5);
        a = [sort(a1(:)); 0; a2(:)];

        emptyStr = {''; ''; '';''; ''; '';''; ''};
        XTickLabel = [emptyStr; ''; emptyStr; {''}; ''; {''}; emptyStr; ' '; emptyStr; ' 1'; emptyStr; ' 10'; emptyStr; '  100'; emptyStr];
        XTicks = asinh(a/LRx);
end