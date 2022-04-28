function [correction_mass, correction_mass_angle] = compute_correction(A, AB, test_mass, test_mass_angle, subtract_mode)

    %convert from polar to cartesian
    A_cart = A(2) .* [cos(A(1)) sin(A(1))];
    AB_cart = AB(2) .* [cos(AB(1)) sin(AB(1))];

    B_cart = [AB_cart(1) - A_cart(1) ; AB_cart(2) - A_cart(2)];
    B_theta = atan2(B_cart(2), B_cart(1));
    B_mag = norm(B_cart);

    B = [B_theta ; B_mag];
    

    relative_angle = (A(1) + pi) - B(1);

    if (subtract_mode)
        correction_mass = -test_mass *  (A(2) / B(2));
        correction_mass_angle = mod(rad2deg(relative_angle + pi) + test_mass_angle, 360);
    else
        correction_mass = test_mass *  (A(2) / B(2));
        correction_mass_angle = mod(rad2deg(relative_angle) + test_mass_angle, 360);
    end




     blue = [57 106 177]./255;
red = [204 37 41]./255;
black = [83 81 84]./255;
green = [62 150 81]./255;

    figure()
    clf
    
    polarplot([0 A(1)], [0, A(2)], "Linewidth", 2, "Color", "blue")
    hold on
    polarplot([0 AB(1)], [0, AB(2)], "Linewidth", 2, "Color", "red")

    polarplot([A(1) AB(1)], [A(2) AB(2)], ":", "Linewidth", 1, 'Color', 'yellow')

    polarplot([0 B(1)], [0, B(2)], "Linewidth", 2, 'Color', 'yellow')

    

    polarplot([0 B(1) + relative_angle], [0, B(2) * A(2) / B(2)], "Linewidth", 2, "Color", 'c')


    lgd = legend("A", "A+B", "", "B", "\alphaB+\phi", "Location", "bestoutside");
    lgd.Color = [0 0 0];
    lgd.TextColor = [1 1 1];
    lgd.EdgeColor = [0.4 0.4 0.4];
set(gca,'Color',[0.1 0.1 0.1])
set(gca,'GridColor',[1 1 1])
set(gca,'ThetaColor',[ 1 1 1])
set(gca,'RColor',[1 1 1])
set(gcf, 'InvertHardCopy', 'off'); 
set(gcf, 'Color', [0 0 0]); 


%     polarplot([0 A(1)], [0, A(2)], "Linewidth", 2, "Color", blue)
%     hold on
%     polarplot([0 AB(1)], [0, AB(2)], "Linewidth", 2, "Color", red)
% 
%     polarplot([A(1) AB(1)], [A(2) AB(2)], ":", "Linewidth", 1, 'Color', green)
% 
%     polarplot([0 B(1)], [0, B(2)], "Linewidth", 2, 'Color', green)
% 
%     
% 
%     polarplot([0 B(1) + relative_angle], [0, B(2) * A(2) / B(2)], "--", "Linewidth", 2, 'Color', green)
% 
% 
% 
%     title("Vibrations State Polar Plot")
% 
% 
%     text(A(1)+pi/50, 3000, "A","Color", blue)
%     text(AB(1)+pi/12, 1500, "AB", "Color", red)
%     text(B(1)-pi/50, 3000, "B", "Color", green)
%     text(B(1) + relative_angle - pi/50, 3000, "B+phi", "Color", green)


    %lgd = legend("A", "A+B", "", "B", "\alphaB+\phi", "Location", "bestoutside");
