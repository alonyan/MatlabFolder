function h = DrawCircle(x,y,r, Np)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
    
    ang=(0:(Np-1))*2*pi/(Np-1); 
    xp=r*cos(ang);
    yp=r*sin(ang);
    h = plot(x+xp,y+yp);
end