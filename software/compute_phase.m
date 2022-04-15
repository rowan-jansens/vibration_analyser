function [phase, amplitude] = compute_phase(data_array)

    dt = [];
    for i = 2:length(data_array(:,1))
    
        dt(end+1)= data_array(i,1) - data_array(i-1,1);
    end
    dt = mean(dt);
    rpm = [];
    for i = 2:length(data_array(:,1))
        if data_array(i,3) ~= data_array(i-1,3)
            rpm(end+1)= data_array(i,3) - data_array(i-1,3);
        end
    end
    rpm_frequ = 1 / (mean(rpm));

    disp("Fitting Data...")
    p =fit_sin(data_array(:,1), data_array(:,2), [2000 rpm_frequ*2*pi -pi/2]);
   % t_vec = linspace(0, data_array(end,1), 100000);
%     clf
%     hold on
%     plot(t_vec, p(1).*sin(p(2).*t_vec - p(3)))
%     plot(data_array(:,1), data_array(:,2))


    phase_angle = [];


    for i=2:length(data_array(:,1))
        if(data_array(i,3) ~= data_array(i-1,3))
            %xline(data_array(i,3))
    
            t_0 = data_array(i,3);
            observation_range = 1/rpm_frequ;
            time_range = linspace(data_array(i,3), data_array(i,1) + (observation_range * 1.25), 1000);
            observation_data = p(1) .* sin(p(2) .* time_range - p(3));
            [~, idx] = max(observation_data);
            phase_time = time_range(idx) - t_0;
            phase_angle(end+1) = phase_time * (rpm_frequ * 360);
        end
    end

    phase = deg2rad(mean(phase_angle));
    amplitude = rms(data_array(:,2));
    %standard_deviation = std(phase_angle);


end