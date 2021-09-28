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
        sun_angle {mustBeNumeric}
        T1i {mustBeNumeric}
        T2i {mustBeNumeric}
        Toutside {mustBeNumeric}
    end

    methods
        function obj = parameters()
            obj.A_wall = 2 * (3 * 5.1) + 2 * (4 * 5.1) * 2 * (3 * 4); % surface area of all walls, m^2
            obj.A_floor =  2 * (5.4 * 4); % surface area of heat absorber, top and bottom, m^2
            obj.A_window = 4 * 3; % m^2

            obj.thickness_wall = 0.1; % m
            obj.thickness_fiberglass = 0.25; % m
            obj.thickness_absorber = 0.1; % m

            obj.rho_wall = 2000; % kg/m^3
            obj.rho_fiberglass = 12; % kg/m^3
            obj.rho_absorber = 3000; % kg/m^3

            obj.c_wall = 800; % J/kg/K
            obj.c_fiberglass = 840; % J/kg/K
            obj.c_absorber = 800; % J/kg/K

            obj.k_wall = 0.6; % W/m/K
            obj.k_fiberglass = 0.04; % W/m/K
            obj.k_absorber = 3.0; % W/m/K

            obj.h_indoor = 15; % W/m^2/K
            obj.h_outdoor = 30; % W/m^2/K

            obj.sun_angle = 25; % degrees
            obj.Q_sun = 300 * obj.A_window * tand(obj.sun_angle); % W
            obj.T1i = 0;
            obj.T2i = 0;
            obj.Toutside = 0;

            obj.A_fiberglass = obj.A_wall; % m^2

            obj.vol_brick = obj.A_wall .* obj.thickness_wall; % m^3
            obj.vol_fiberglass = obj.A_fiberglass .* obj.thickness_fiberglass; % m^3
            obj.vol_stone = obj.A_floor .* obj.thickness_absorber; % m^3

            obj.C_wall = obj.vol_brick .* obj.rho_wall .* obj.c_wall;
            obj.C_fiberglass = obj.vol_fiberglass .* obj.rho_fiberglass .* obj.c_fiberglass;
            obj.C_absorber = obj.vol_stone .* obj.rho_absorber .* obj.c_absorber;

            obj.C1 = obj.C_absorber;
            obj.C2 = obj.C_wall;


            obj.R_1 = 1 ./ (obj.h_indoor .* obj.A_floor); % K / W
            obj.R_2 = 1 ./ (obj.h_indoor .* obj.A_fiberglass); % K / W
            obj.R_3 = obj.thickness_fiberglass ./ (obj.k_fiberglass .* obj.A_wall); % K / W
            obj.R_4 = 1 ./ (obj.h_outdoor .* obj.A_wall); % K / W

            obj.R1 = obj.R_1 + obj.R_2 + obj.R_3;
            obj.R2 = obj.R_4;

        end
    end
end