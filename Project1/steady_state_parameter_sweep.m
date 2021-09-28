load("parameters.mat");

p = parameters();

insulation_thickness_range = linspace(0, 1, 10); % meters

insulation_thickness_sweep = zeros(length(insulation_thickness_range), 1);

for it = 1:length(insulation_thickness_range)
    p.thickness_fiberglass = insulation_thickness_range(it);
    insulation_thickness_sweep(it) = p.R_4;
end

figure(1);
clf;
hold on;
plot(insulation_thickness_range, insulation_thickness_sweep);