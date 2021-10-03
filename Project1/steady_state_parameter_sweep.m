p = parameters();

insulation_thickness_range = linspace(0, 1, 10); % meters
wall_thickness_range = linspace(0, 3, 15); % meters
absorber_thickness_range = linspace(0, 1, 10); % meters

insulation_thickness_sweep = zeros(length(insulation_thickness_range), 1);
wall_thickness_sweep = zeros(length(wall_thickness_range), 1);
absorber_thickness_sweep = zeros(length(absorber_thickness_range), 1);

for it = 1:length(insulation_thickness_range)
    p.thickness_fiberglass = insulation_thickness_range(it);
    insulation_thickness_sweep(it) = p.T_inside_final;
end

for it = 1:length(wall_thickness_range)
    p.thickness_wall = wall_thickness_range(it);
    wall_thickness_sweep(it) = p.T_inside_final;
    disp(p.)
end

for it = 1:length(absorber_thickness_sweep)
    p.thickness_absorber = absorber_thickness_range(it);
    absorber_thickness_sweep(it) = p.T_inside_final;
end

figure(1);
clf;
hold on;
plot(insulation_thickness_range, insulation_thickness_sweep, 'bx');
 
figure(2);
clf;
hold on;
plot(wall_thickness_range, wall_thickness_sweep, 'bx')

figure(3);
clf;
hold on;
plot(absorber_thickness_range, absorber_thickness_sweep, 'bx')
