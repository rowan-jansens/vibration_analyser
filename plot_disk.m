function res = plot_disk(r, com)
    t = linspace(0,2*pi,1000);
    x = r*cos(t);
    y = r*sin(t);
    
    figure()
    clf
    hold on
    plot(x, y)
    plot(com(1), com(2), ".", "Markersize", 10)
    plot(0, 0, "o", "Markersize", 10)
    hold off
    axis equal
end
