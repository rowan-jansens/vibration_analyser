function res = animate_rocker(data, speed)

beam_width = 0.1; %m
beam_thick = 0.002; %m

l_rod = 0.1;

        for i = 1:speed:length(data(:,1))
        theta = data(i,1);
        beam_pos = data(i,2:3);
        
            
            
            
        figure(1)
        clf
        
        axis equal
        
        axis([-0.1 0.1 -0.1 0.1])
        
        hold on
        
        
        mount =  rectangle("Position", [beam_pos(1) - (beam_width), 0.05, beam_width* 2, beam_thick], "FaceColor", 'b');
        rod1x = [-0.05 -0.05 + l_rod * sin(theta)];
        rod1y = [0.05 0.05 - l_rod * cos(theta)];
        rod2x = [0.05 0.05 + l_rod*sin(theta)];
        rod2y = [0.05 0.05 - l_rod*cos(theta)];

        
        
        
        plot(rod1x, rod1y, 'Color', 'k')
        plot(rod2x, rod2y, 'Color', 'k')
        
        
        beam = rectangle("Position", [rod1x(2), rod1y(2), beam_width, beam_thick], "FaceColor", 'r');

        hold off
        drawnow
        end
end