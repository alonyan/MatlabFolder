function BTL = BarTicklengthY(h, TickLength)

flagtype = get(h(1),'type')
    BTL = TickLength./20;

if strcmpi(flagtype,'hggroup') 
    hh=get(h,'children');		
    x = get(hh(2),'ydata');	
    
    x(4:9:end) = x(1:9:end)-BTL;	
    x(7:9:end) = x(1:9:end)-BTL;
    x(5:9:end) = x(1:9:end)+BTL;
    x(8:9:end) = x(1:9:end)+BTL;

    set(hh(2),'xdata',x(:))	
 else  % ERRORBAR('V6',...)
    
    x = get(h(1),'ydata');
    
    x(4:9:end) = x(1:9:end-1)-BTL;	
    x(7:9:end) = x(1:9:end-1)-BTL;
    x(5:9:end) = x(1:9:end-1)+BTL;
    x(8:9:end) = x(1:9:end-1)+BTL;

    set(h(1),'ydata',x(:))	% Change error bars on the figure
    
end

end