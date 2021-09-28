classdef parameters
    properties
        A_wall {mustBeNumeric}
        A_fiberglass {mustBeNumeric}
        A_floor {mustBeNumeric}
        A_window {mustBeNumeric}

        thickness_wall {mustBeNumeric}
        thickness_fiberglass {mustBeNumeric}
        thickness_absorber {mustBeNumeric}

        vol_brick {mustBeNumeric}
        vol_fiberglass {mustBeNumeric}
        vol_stone {mustBeNumeric}

        rho_wall {mustBeNumeric}
        rho_fiberglass {mustBeNumeric}
        rho_absorber {mustBeNumeric}

        c_wall {mustBeNumeric}
        c_fiberglass {mustBeNumeric}
        c_absorber {mustBeNumeric}

        C_wall {mustBeNumeric}
        C_fiberglass {mustBeNumeric}
        C_absorber {mustBeNumeric}

        C1 {mustBeNumeric}
        C2 {mustBeNumeric}

        k_wall {mustBeNumeric}
        k_fiberglass {mustBeNumeric}
        k_absorber {mustBeNumeric}

        h_indoor {mustBeNumeric}
        h_outdoor {mustBeNumeric}

        R_1 {mustBeNumeric}
        R_2 {mustBeNumeric}
        R_3 {mustBeNumeric}
        R_4 {mustBeNumeric}

        R1 {mustBeNumeric}
        R2 {mustBeNumeric}

        Q_sun {mustBeNumeric}
        T1i {mustBeNumeric}
        T2i {mustBeNumeric}
        Toutside {mustBeNumeric}
    end

    methods
        function obj = parameters()
            obj.A_wall = 2 * (3 * 5.1) + 2 * (4 * 5.1) * 2 * (3 * 4); % surface area of all walls, m^2
            % obj.A_fiberglass = obj.A_wall; % m^2
            % obj.A_floor =  2 * (5.4 * 4); % surface area of heat absorber, top and bottom, m^2
            % obj.A_window = 4 * 3; % m^2

            % obj.thickness_wall = 0.1; % m
            % obj.thickness_fiberglass = 0.25; % m
            % obj.thickness_absorber = 0.1; % m

            % obj.vol_brick = A_wall .* thickness_wall; % m^3
            % obj.vol_fiberglass = A_fiberglass .* thickness_fiberglass; % m^3
            % obj.vol_stone = A_floor .* thickness_absorber; % m^3

            % obj.rho_wall = 2000; % kg/m^3
            % obj.rho_fiberglass = 12; % kg/m^3
            % obj.rho_absorber = 3000; % kg/m^3

            % obj.c_wall = 800; % J/kg/K
            % obj.c_fiberglass = 840; % J/kg/K
            % obj.c_absorber = 800; % J/kg/K

            % obj.C_wall = vol_brick .* rho_wall .* c_wall;
            % obj.C_fiberglass = vol_fiberglass .* rho_fiberglass .* c_fiberglass;
            % obj.C_absorber = vol_stone .* rho_absorber .* c_absorber;

            % obj.C1 = C_absorber;
            % obj.C2 = C_wall;

            % obj.k_wall = 0.6; % W/m/K
            % obj.k_fiberglass = 0.04; % W/m/K
            % obj.k_absorber = 3.0; % W/m/K

            % obj.h_indoor = 15; % W/m^2/K
            % obj.h_outdoor = 30; % W/m^2/K

            % obj.R_1 = 1 ./ (h_indoor .* A_floor); % K / W
            % obj.R_2 = 1 ./ (h_indoor .* A_fiberglass); % K / W
            % obj.R_3 = thickness_fiberglass ./ (k_fiberglass .* A_wall); % K / W
            % obj.R_4 = 1 ./ (h_outdoor .* A_wall); % K / W

            % obj.R1 = R_1 + R_2 + R_3;
            % obj.R2 = R_4;

            % obj.Q_sun = 300 * A_window * tand(25); % W
            % obj.T1i = 0;
            % obj.T2i = 0;
            % obj.Toutside = 0;
        end
        function initialize(obj)
            obj.A_fiberglass = obj.A_wall;
        end
    end
end