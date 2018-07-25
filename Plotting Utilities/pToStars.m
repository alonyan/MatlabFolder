function SigStr = pToStars(pval)

        if pval>0.05
                SigStr = 'n.s.';
        elseif pval>0.01
                SigStr = '*';
        elseif pval>0.001
                SigStr = '**';
        elseif pval>0
                SigStr = '***';
        end;
end