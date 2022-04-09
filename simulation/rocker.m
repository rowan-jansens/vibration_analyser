function [general_data, animation_data] = rocker(fly_wheel_data)


m_rod = 0.1;
m_beam = 0.1;
l_rod = 0.1;



theta = 0;
omega = 0;
beam_pos = [0 ; 0];

dt = fly_wheel_data(2,1) - fly_wheel_data(1,1);
I = 1/3 * m_rod * l_rod^2;

general_data = zeros(length(fly_wheel_data(:,1)), 3);
animation_data = zeros(length(fly_wheel_data(:,1)), 3);

for i=1:length(fly_wheel_data(:,1))
    t = fly_wheel_data(i,1);
   
    linear_force = fly_wheel_data(i,3);
    tau_in = linear_force * l_rod * sin(pi/2-theta);
    tau_grav = 2* (l_rod / 2) * (m_rod + m_beam) * -9.8 * sin(theta);
    tau_net = tau_in + tau_grav;
    alpha = tau_net / I;
    omega = omega + alpha * dt;
    theta = theta + omega * dt;
    general_data(i,:) = [t theta alpha/l_rod];
    animation_data(i,:) = [theta beam_pos'];
end
    
  
end