load("parameters.mat");

[ts, Ts] = ode45(@(t, y) odefun(t, y, R1, R2, C1, C2, Q_sun, Toutside, A_window, h_indoor, A_floor, h_outdoor), [0, 1e6], [T1i; T2i]);

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

function [dTdt] = odefun(t, T, R1, R2, C1, C2, Q_sun, Toutside, A_window, h_indoor, A_floor, h_outdoor);    
    T1 = T(1);
    T2 = T(2);

    q = -361 * cos(pi * t / (12 * 3600)) + 224 * cos(pi * t / (6 * 3600)) + 210; % W / m^2
    Q_sun = q * A_window;

    dT1dt = Q_sun ./ C1 + (T2 - T1) ./ (R1 .* C1) + (Toutside - T1) * (h_indoor * A_floor + h_indoor * A_window + .01 / .8 / A_window + h_outdoor * A_window);
    dT2dt = (Toutside - T2) ./ (R2 .* C2) - (T2 - T1) ./ (R1 .* C2);

    dTdt = [dT1dt; dT2dt];
end