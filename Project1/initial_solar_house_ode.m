load("parameters.mat");

[ts, Ts] = ode45(@(t, y) odefun(t, y, R1, R2, C1, C2, Q_sun, Toutside), [0, 4e6], [T1i; T2i]);

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

function [dTdt] = odefun(t, T, R1, R2, C1, C2, Q_sun, Toutside);
    T1 = T(1);
    T2 = T(2);

    dT1dt = Q_sun ./ C1 + (T2 - T1) ./ (R1 .* C1);
    dT2dt = (Toutside - T2) ./ (R2 .* C2) - (T2 - T1) ./ (R1 .* C2);

    dTdt = [dT1dt; dT2dt];
end