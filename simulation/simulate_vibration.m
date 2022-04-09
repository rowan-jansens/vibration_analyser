function [amp, phase] = simulate_vibration(offset_masses, rot, t_len , dt)
    global rpm2rad
    
    fw_data = fly_wheel(offset_masses, rot, t_len , dt);
    r_data = rocker(fw_data);
    amp = max(fw_data(:,3));
    phase = compare_phase(fw_data, r_data, rot / rpm2rad, dt) + 179.4;
    

end