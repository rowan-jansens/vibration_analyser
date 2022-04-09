function [general_data, animation_data] = fly_wheel(off_set_masses, omega, t_end, dt)

t_range = 0:dt:t_end;

mass = 0.1; %kg
radius = 0.03; %m

num_of_masses = length(off_set_masses(:,1));

off_set_mass_positions = [cos(off_set_masses(:,2))*radius sin(off_set_masses(:,2))*radius];

center_of_mass = sum(off_set_mass_positions .* off_set_masses(:,1), 1);

com_offset = norm(center_of_mass);
com_angle = acos(center_of_mass(1) / com_offset);
%take care of angle ambiguity
if center_of_mass(2) < 0
    com_angle = 2*pi - com_angle;
end


mass_tot = sum(off_set_masses(:,1)) + mass;

I = (0.5 * mass * radius^2) + sum(off_set_masses(:,1) * radius^2);

angular_velocity = omega;

beam_mass =0.5; %kg
beam_pos = 0;
beam_vel = 0;

theta = 0;

 
general_data = zeros(length(t_range), 4);
animation_data = zeros(length(t_range), 3 + (num_of_masses * 2));

for i = 1:length(t_range)
      t = t_range(i);
 
     %tau = f * r * sin(theta)
     torque = (-9.8 * mass_tot) * com_offset *  sin(theta + com_angle);

     angular_acceleration = torque / I;
     angular_velocity = angular_velocity + dt * angular_acceleration;
     theta = theta + (dt * angular_velocity);
     linear_force = (angular_velocity^2 * com_offset) / mass_tot * cos(theta + com_angle);
     
     beam_acc = linear_force / beam_mass;
     beam_vel = beam_vel + beam_acc * dt;
     beam_pos = beam_pos + beam_vel * dt;  
     
     center_of_mass = [com_offset * cos(theta+ com_angle) ; com_offset * sin(theta+ com_angle)];
     
     off_set_mass_positions = [radius*cos(theta + off_set_masses(:,2)) radius*sin(theta + off_set_masses(:,2))];
     
     

     general_data(i,:) = [t theta linear_force beam_pos];
     animation_data(i,:) = [beam_pos center_of_mass' off_set_mass_positions(:)'];
     
 end


end