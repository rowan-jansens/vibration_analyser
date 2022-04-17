function compute_correction(m1, m2, test_mass, test_mass_angle, mode)

    %convert from polar to cartesian
    p1 = m1(2) .* [cos(m1(1)) sin(m1(1))];
    p2 = m2(2) .* [cos(m2(1)) sin(m2(1))];

    iso_vec = [p2(1) - p1(1) ; p2(2) - p1(2)];
    iso_vec_angle = atan2(iso_vec(2), iso_vec(1));
    iso_vec_mag = norm(iso_vec)



    if (m1(1) > m2(1))
        realative_angle = abs(asin(((m2(2)) * sin(abs(m2(1) - m1(1)))) / iso_vec_mag));
        rad2deg(realative_angle)

    else
        realative_angle = abs(asin(((m2(2)) * sin(abs(m2(1) - m1(1)))) / iso_vec_mag));
        rad2deg(realative_angle)

    end
figure()
clf
    
    polarplot([0 m1(1)], [0, m1(2)], "Linewidth", 2)
    hold on
    polarplot([0 m2(1)], [0, m2(2)], "Linewidth", 2)

    polarplot([m1(1) m2(1)], [m1(2) m2(2)], "Linewidth", 2)

    polarplot([0 iso_vec_angle], [0, iso_vec_mag], "Linewidth", 2)

    

    polarplot([0 iso_vec_angle + realative_angle], [0, iso_vec_mag], "Linewidth", 2)


    legend("A", "A+B", "B", "B", "B+phi")

