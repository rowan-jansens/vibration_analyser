function phase = compare_phase(fw_data, r_data, rpm, dt)
    global rpm2rad
    
    
    
    d = r_data(:,2);
    fd = highpass(d, 100, 1/dt);

    rot = cos(fw_data(:,2));
    
    
     phase = phdiffmeasure(rot, fd) * 180 / pi;
     
%      [c, lag] = xcorr(rot, fd);
%     figure()
%     clf
%     hold on
%     plot(abs(c))
%     plot(lag / 4000)
%     hold off
    
    
    
%     [val, id] = max(abs(c));
%     lag = lag(id);
%     phase = (lag) * dt * rpm * rpm2rad * 180/pi;
    
    
   

%     figure()
%     clf
%     hold on
%     plot(fw_data(:,1), fd * 1000)
%     plot(fw_data(:,1), rot)
%     hold off

end