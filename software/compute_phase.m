function [phase, amplitude] = compute_phase(data_array, debug)

    %find average dt
    dt = [];
    for i = 2:length(data_array(:,1))
        dt(end+1)= data_array(i,1) - data_array(i-1,1);
    end
    dt = mean(dt);
    rpm = [];

    %find average RPM
    for i = 2:length(data_array(:,1))
        if data_array(i,3) ~= data_array(i-1,3)
            rpm(end+1)= data_array(i,3) - data_array(i-1,3);
        end
    end

    %conver RPM
    rpm_frequ = 1 / (mean(rpm));
    sin_frequ = rpm_frequ*2*pi;
    

    %fit data
    p = fit_sin(data_array(:,1), data_array(:,2), sin_frequ, [2000 -pi/2]);

    %plot the fit
    t_vec = linspace(0, data_array(end,1), 100000);

    if(debug)
        figure()
        clf
        hold on
        plot(t_vec, p(1).*sin(sin_frequ.*t_vec - p(2)))
        plot(data_array(:,1), data_array(:,2))
        hold off
        title("Sin Wave Fit")
        xlabel("Time")
        ylabel("Amplitude")
        
        
        figure()
        clf
        hold on
    end

    
    %find phase angle of data
    phase_angle = [];
    for i=2:length(data_array(:,1))
        if(data_array(i,3) ~= data_array(i-1,3))
            %plot a line when motor crosses 0
            if(debug)
            xline(data_array(i,3))
            end
    

            t_0 = data_array(i,3);
            observation_range = 1/rpm_frequ;
            time_range = linspace(data_array(i,3), data_array(i,1) + (observation_range * 1.25), 1000);
            observation_data = p(1) .* sin(sin_frequ .* time_range - p(2));

            if(debug)
            %plot the fit for testing
            plot(time_range, observation_data)
            end

            %find max of fit and find time difference
            [~, idx] = max(observation_data);
            phase_time = time_range(idx) - t_0;
            phase_angle(end+1) = phase_time * sin_frequ;
        end
    end

    if(debug)
    hold off
    title("Phase Finder Plot")
    xlabel("Time")
    ylabel("Amplitude")
    end

    phase = mean(phase_angle);
    amplitude = rms(data_array(:,2));

    if(debug)
    phase
    standard_deviation = std(phase_angle)
    phase_range = [min(phase_angle) max(phase_angle)]
    end


end