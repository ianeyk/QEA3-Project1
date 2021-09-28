load("parameters.mat");

insulation_thickness_range = linspace(0, 1, 10); % meters
wall_thinckess_range = linspace(0, 1, 10); % meters

for it = 1:length(insulation_thickness_range)
    insulation_thickness = insulation_thickness_range(it);
    

    function Tinside = steady_state(t, T, R_1, R_2, R_3, Q_sun, Toutside)
        R1 = R_1 + R_2 + R_3;
        R2 = R_4;
        T1 = -Q_sun * (-R2 - R1) + Toutside;
        T2 = (R1 * Toutside - T1final * R2) / (-R1 + R2)
        
        Tinside = T2 + (T1 - T2) * R_1 / (R_2 + R_3);
    end
end