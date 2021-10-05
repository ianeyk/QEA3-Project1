p = parameters();

insulation_thickness_range = linspace(0, 1, 10); % meters
wall_thickness_range = linspace(0, 0.5, 10); % meters
absorber_thickness_range = linspace(0, 1, 10); % meters
T_outside_initial_range = linspace(0, 50, 50); % C
A_window_range = linspace(0, 12, 20); % m^2

insulation_thickness_sweep = zeros(length(insulation_thickness_range), 1);
wall_thickness_sweep = zeros(length(wall_thickness_range), 1);
absorber_thickness_sweep = zeros(length(absorber_thickness_range), 1);
T_outside_initial_sweep = zeros(length(T_outside_initial_range), 1);
A_window_sweep = zeros(length(A_window_range), 1);

for it = 1:length(insulation_thickness_range)
    p.thickness_fiberglass = insulation_thickness_range(it);
    insulation_thickness_sweep(it) = p.T_inside_final;
end

for it = 1:length(wall_thickness_range)
    p.thickness_wall = wall_thickness_range(it);
    wall_thickness_sweep(it) = p.T_inside_final;
end

for it = 1:length(absorber_thickness_sweep)
    p.thickness_absorber = absorber_thickness_range(it);
    absorber_thickness_sweep(it) = p.T_inside_final;
end

for it = 1:length(T_outside_initial_sweep)
    p.T_outside_initial = T_outside_initial_range(it);
    T_outside_initial_sweep(it) = p.T_inside_final;
end

for it = 1:length(A_window_sweep)
    p.A_window = A_window_range(it);
    A_window_sweep(it) = p.T_inside_final;
end

figure(1);
clf;
hold on;
plot(insulation_thickness_range, insulation_thickness_sweep, 'bx');
title("insulation thickness vs final inside temperature")
xlabel("insulation thickness, m")
ylabel("temperature, C")
 
figure(2);
clf;
hold on;
plot(wall_thickness_range, wall_thickness_sweep, 'bx')
title("wall thickness vs final inside temperature")
xlabel("wall thickness, m")
ylabel("temperature, C")

figure(3);
clf;
hold on;
plot(absorber_thickness_range, absorber_thickness_sweep, 'bx')
title("absorber thickness vs final inside temperature")
xlabel("absorber thickness, m")
ylabel("temperature, C")

figure(4);
clf;
hold on;
plot(T_outside_initial_range, T_outside_initial_sweep, 'bx')
title("initial outside temperature vs final inside temperature")
xlabel("initial outside temperature, C")
ylabel("final inside temperature, C")

figure(5);
clf;
hold on;
plot(A_window_range, A_window_sweep, 'bx')
title("area of window vs final inside temperature")
xlabel("area of window, m^2")
ylabel("final inside temperature, C")
