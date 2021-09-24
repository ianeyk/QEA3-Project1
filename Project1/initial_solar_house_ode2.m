function initial_solar_house_ode2()

A_wall = 2 * (3 * 5.1) + 2 * (4 * 5.1) * 2 * (3 * 4); % surface area of all walls, m^2
A_fiberglass = A_wall; % m^2
A_floor =  2 * (5.4 * 4); % surface area of heat absorber, top and bottom, m^2
A_window = 4 * 3; % m^2

thickness_wall = 0.1; % m
thickness_fiberglass = 0.25; % m
thickness_absorber = 0.1; % m

vol_brick = A_wall .* thickness_wall; % m^3
vol_fiberglass = A_fiberglass .* thickness_fiberglass; % m^3
vol_stone = A_floor .* thickness_absorber; % m^3

rho_wall = 2000; % kg/m^3
rho_fiberglass = 12; % kg/m^3
rho_absorber = 3000; % kg/m^3

c_wall = 800; % J/kg/K
c_fiberglass = 840; % J/kg/K
c_absorber = 800; % J/kg/K

C_wall = vol_brick .* rho_wall .* c_wall;
C_fiberglass = vol_fiberglass .* rho_fiberglass .* c_fiberglass;
C_absorber = vol_stone .* rho_absorber .* c_absorber;

C1 = C_absorber;
C2 = C_wall;

k_wall = 0.6; % W/m/K
k_fiberglass = 0.04; % W/m/K
k_absorber = 3.0; % W/m/K

h_indoor = 15; % W/m^2/K
h_outdoor = 30; % W/m^2/K

R_1 = 1 ./ (h_indoor .* A_floor); % K / W
R_2 = 1 ./ (h_indoor .* A_fiberglass); % K / W
R_3 = thickness_fiberglass ./ (k_fiberglass .* A_wall); % K / W
R_4 = 1 ./ (h_outdoor .* A_wall); % K / W

R1 = R_1 + R_2 + R_3;
R2 = R_4;

Q_sun = 300 * A_window; % W
T1i = 0;
T2i = 0;
Toutside = 0;

[ts, Ts] = ode45(@odefun, [0, 4e6], [T1i; T2i]);

Tair = (Ts(:, 1) - Ts(:, 2)) .* (R_2 + R_3) ./ (R_1 + R_2 + R_3) + Ts(:, 2);

disp(Ts(end, :));
disp(Tair(end));

figure(1);
clf;
hold on;

seconds_per_week = 60 .* 60 .* 24 .* 7;

plot(ts ./ seconds_per_week, Ts(:, 1), 'b-');
plot(ts ./ seconds_per_week, Ts(:, 2), 'r-');
plot(ts ./ seconds_per_week, Tair, 'g-');

xlabel("Time (Weeks)");
ylabel("Temperature (^oC)");
legend("Floor Temperature", "Wall Temperature", "Inside Air Temperature", "location", "East");

    function [dTdt] = odefun(t, T)
        T1 = T(1);
        T2 = T(2);
        
        dT1dt = Q_sun ./ C1 + (T2 - T1) ./ (R1 .* C1);
        dT2dt = (Toutside - T2) ./ (R2 .* C2) - (T2 - T1) ./ (R1 .* C2);
        
        dTdt = [dT1dt; dT2dt];
    end

end