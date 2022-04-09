function res = animate_sys(fw_a_data, r_a_data, off_set_masses, speed)

%constant vals
beam_width = 0.1; %m
beam_thick = 0.002; %m
l_rod = 0.1;
radius = 0.03; %m

%scaled mass plotting
num_of_masses = length(off_set_masses(:,1));     
max_mass = max(off_set_masses(:,1));
mass_scale = 20 / max_mass;
  
%scale angle to make visable
angle_scale = 100;%(pi/96 / max(r_a_data(:,1)))



%parametric circle
tc = linspace(0,2*pi,1000);
x = radius*cos(tc);
y = radius*sin(tc);

for i = 1:speed:length(r_a_data(:,1))
    figure(1)
    clf
    axis equal
    axis([-0.1 0.1 -0.1 0.1])
    hold on


    
    theta = r_a_data(i,1);
    theta = theta * angle_scale;
    
    beam_pos = r_a_data(i,2:3);

    %beam_pos = data(i, 1);

    com = fw_a_data(i,2:3);
    off_set_mass_positions = fw_a_data(i,4:end);

    %rocker
    mount =  rectangle("Position", [beam_pos(1) - (beam_width), 0.05, beam_width* 2, beam_thick], "FaceColor", 'b');
    rod1x = [-0.05 -0.05 + l_rod * sin(theta)];
    rod1y = [0.05 0.05 - l_rod * cos(theta)];
    rod2x = [0.05 0.05 + l_rod*sin(theta)];
    rod2y = [0.05 0.05 - l_rod*cos(theta)];
    %center of beam
    beam_center = [rod1x(2) + beam_width / 2 ; rod1y(2) + beam_thick / 2];

    plot(rod1x, rod1y, 'Color', 'k')
    plot(rod2x, rod2y, 'Color', 'k')
    beam = rectangle("Position", [rod1x(2), rod1y(2), beam_width, beam_thick], "FaceColor", 'r');

          
    %wheel
    plot(beam_center(1) + 0, beam_center(2) + 0, ".", "Markersize", 60, "Color", 'w')
    plot(beam_center(1) + x, beam_center(2) + y, "LineWidth", 10, "Color", 'b')
    plot(beam_center(1) +  com(1), beam_center(2) + com(2), ".", "Markersize", 20, "Color", "g")
    plot(beam_center(1) + 0, beam_center(2) + 0, "+", "Markersize", 20, "Color", 'k')

    if num_of_masses > 1
      for j=1:num_of_masses
          dot_size = off_set_masses(j,1) * mass_scale;
          plot(beam_center(1) +  off_set_mass_positions(j), beam_center(2) + off_set_mass_positions(j+2), ".", "Markersize", dot_size, "Color", 'y')
      end

    else 
     plot(beam_center(1) +  off_set_mass_positions(1), beam_center(2) + off_set_mass_positions(2), ".", "Markersize", 25, "Color", 'y')
    end
               
  
    hold off
    drawnow
end



res = 1;


end