function res = animate_wheel(data, speed, off_set_masses)
        beam_width = 0.1; %m
        radius = 0.03; %m
        
        num_of_masses = length(off_set_masses(:,1));
        
        max_mass = max(off_set_masses(:,1));
        mass_scale = 20 / max_mass;
        
        tc = linspace(0,2*pi,1000);
            x = radius*cos(tc);
            y = radius*sin(tc);

        for i = 1:speed:length(data(:,1))
            beam_pos = data(i, 1);
            
            com = data(i,2:3);
            
            off_set_mass_positions = data(i,4:end);
            
            figure(1)
            clf

            axis equal

            axis([-0.1 0.1 -0.1 0.1])

            hold on

            
                
            beam = rectangle("Position", [beam_pos - (beam_width / 2), -0.001, beam_width, 0.002], "FaceColor", 'r');

            
            

            plot(beam_pos + 0, 0, ".", "Markersize", 60, "Color", 'w')
            plot(beam_pos + x, y, "LineWidth", 10, "Color", 'b')
            plot(beam_pos +  com(1), com(2), ".", "Markersize", 20, "Color", "g")
            plot(beam_pos + 0, 0, "+", "Markersize", 20, "Color", 'k')
            
            if num_of_masses > 1
                for j=1:num_of_masses
                    dot_size = off_set_masses(j,1) * mass_scale;
                    plot(beam_pos +  off_set_mass_positions(j), off_set_mass_positions(j+2), ".", "Markersize", dot_size, "Color", 'y')
                end
                
            else 
                plot(beam_pos +  off_set_mass_positions(1), off_set_mass_positions(2), ".", "Markersize", 25, "Color", 'y')
            end
                
            
            
            
            hold off
            drawnow
        end
        res = 1;
end