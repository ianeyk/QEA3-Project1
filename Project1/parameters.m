classdef parameters
    properties
        A_wall {mustBeNumeric}
        A_floor {mustBeNumeric}
        A_window {mustBeNumeric}

        thickness_wall {mustBeNumeric}
        thickness_fiberglass {mustBeNumeric}
        thickness_absorber {mustBeNumeric}

        rho_wall {mustBeNumeric}
        rho_fiberglass {mustBeNumeric}
        rho_absorber {mustBeNumeric}

        c_wall {mustBeNumeric}
        c_fiberglass {mustBeNumeric}
        c_absorber {mustBeNumeric}

        k_wall {mustBeNumeric}
        k_fiberglass {mustBeNumeric}
        k_absorber {mustBeNumeric}

        h_indoor {mustBeNumeric}
        h_outdoor {mustBeNumeric}

        sun_angle {mustBeNumeric}
        T_floor_initial {mustBeNumeric}
        T_walls_initial {mustBeNumeric}
        T_outside_initial {mustBeNumeric}

        timespan
    end

    properties (Dependent)
        A_fiberglass {mustBeNumeric}

        Q_sun {mustBeNumeric}

        vol_brick {mustBeNumeric}
        vol_fiberglass {mustBeNumeric}
        vol_stone {mustBeNumeric}

        C_wall {mustBeNumeric}
        C_fiberglass {mustBeNumeric}
        C_absorber {mustBeNumeric}

        C1 {mustBeNumeric}
        C2 {mustBeNumeric}

        R_1 {mustBeNumeric}
        R_2 {mustBeNumeric}
        R_3 {mustBeNumeric}
        R_4 {mustBeNumeric}
        R_window {mustBeNumeric}

        R_absorber_to_wall {mustBeNumeric}
        R_wall_to_outside {mustBeNumeric}
        R_absorber_through_window {mustBeNumeric}

        T_floor_final {mustBeNumeric}
        T_walls_final {mustBeNumeric}
        T_inside_final {mustBeNumeric}

        T_vars_final
    end

    methods
        function obj = parameters()
            obj.A_wall = 2 * (3 * 5.1) + 2 * (4 * 5.1) + 2 * (3 * 4); % surface area of all walls, m^2
            obj.A_floor =  2 * (5.4 * 4); % surface area of heat absorber, top and bottom, m^2
            obj.A_window = 4 * 5; % m^2

            obj.thickness_wall = 0.1; % m
            obj.thickness_fiberglass = 0.2; % m
            obj.thickness_absorber = 0.15; % m

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
            obj.T_floor_initial = 0; % initial temperature of the floor, degress C
            obj.T_walls_initial = 0; % initial temperature of the walls, degress C
            obj.T_outside_initial = -3.0; % degrees C

            obj.timespan = [0, 1e6];
        end

        function value = get.A_fiberglass(obj)
            value = obj.A_wall; % m^2
        end

        function value = get.Q_sun(obj)
            value = 210 * obj.A_window % * tand(obj.sun_angle); % W
        end

        function value = get.vol_brick(obj)
            value = obj.A_wall .* obj.thickness_wall; % m^3
        end
        function value = get.vol_fiberglass(obj)
            value = obj.A_fiberglass .* obj.thickness_fiberglass; % m^3
        end
        function value = get.vol_stone(obj)
            value = obj.A_floor .* obj.thickness_absorber; % m^3
        end


        function value = get.C_wall(obj)
            value = obj.vol_brick .* obj.rho_wall .* obj.c_wall;
        end
        function value = get.C_fiberglass(obj)
            value = obj.vol_fiberglass .* obj.rho_fiberglass .* obj.c_fiberglass;
        end
        function value = get.C_absorber(obj)
            value = obj.vol_stone .* obj.rho_absorber .* obj.c_absorber;
        end


        function value = get.C1(obj)
            value = obj.C_absorber;
        end
        function value = get.C2(obj)
            value = obj.C_wall;
        end


        function value = get.R_1(obj)
            value = 1 ./ (obj.h_indoor .* obj.A_floor); % K / W
        end
        function value = get.R_2(obj)
            value = 1 ./ (obj.h_indoor .* obj.A_fiberglass); % K / W
        end
        function value = get.R_3(obj)
            value = obj.thickness_fiberglass ./ (obj.k_fiberglass .* obj.A_wall); % K / W
        end
        function value = get.R_4(obj)
            value = 1 ./ (obj.h_outdoor .* obj.A_wall); % K / W
        end
        function value = get.R_window(obj)
            U_factor = 1.01; % https://engineer-educators.com/topic/8-heat-transfer-through-windows/, Table 19
            value = 1 ./ (U_factor .* obj.A_window); % K / W
            % value = Inf;
        end


        function value = get.R_absorber_to_wall(obj)
            value = obj.R_1 + obj.R_2 + obj.R_3;
        end
        function value = get.R_wall_to_outside(obj)
            value = obj.R_4;
        end


        function value = get.R_absorber_through_window(obj)
            value = obj.R_1 + obj.R_window + obj.R_4;
        end


        function value = T_inside(obj, T_absorber, T_wall)
            value = T_wall + (T_absorber - T_wall) .* (obj.R_2 + obj.R_3) ./ obj.R_absorber_to_wall;
        end


        function value = get.T_vars_final(obj)
            [ts, Ts] = obj.run_ode();

            last_day = Ts(ts > ts(end) - 24 .* 3600, :);
            value = mean(last_day);
        end

        function value = get.T_floor_final(obj)
            value = obj.T_vars_final(1);
        end
        function value = get.T_walls_final(obj)
            value = obj.T_vars_final(2);
        end
        function value = get.T_inside_final(obj)
            value = obj.T_vars_final(3);
            % value = obj.T_walls_final + (obj.T_floor_final - obj.T_walls_final) * (obj.R_2 + obj.R_3) / obj.R_absorber_to_wall;
        end

        function Q_sun = Q_sun_of_t(obj, t)
            Q_sun_per_m2 = -361 .* cos(pi .* t / (12 .* 3600)) + 224 .* cos(pi .* t / (6 .* 3600)) + 210;
            Q_sun = Q_sun_per_m2 .* obj.A_window;
        end

        function dTdt = odefun(obj, t, T)
            T_absorber = T(1);
            T_wall = T(2);

            dT_absorber_dt = obj.Q_sun_of_t(t) ./ obj.C_absorber + ...
            (T_wall - T_absorber) ./ (obj.R_absorber_to_wall .* obj.C_absorber) + ...
            (obj.T_outside_initial - T_absorber) ./ (obj.R_absorber_through_window .* obj.C_absorber);

            dT_wall_dt = - (T_wall - T_absorber) ./ (obj.R_absorber_to_wall .* obj.C_wall) + ...
            (obj.T_outside_initial - T_wall) ./ (obj.R_wall_to_outside .* obj.C_wall);

            dTdt = [dT_absorber_dt; dT_wall_dt];
        end

        function [ts, Ts] = run_ode(obj)
            [ts, Ts] = ode45(@(t, T) odefun(obj, t, T), obj.timespan, repmat([obj.T_outside_initial], 2, 1));
            Ts(:, end + 1) = obj.T_inside(Ts(:, 1), Ts(:, 2));
        end

        function plot_ode(obj, varargin)
            nargin
            if nargin == 2
                fig_cell = varargin(1);
                fig_num = fig_cell{1};
            else
                fig_num = 1;
            end

            [ts, Ts] = obj.run_ode();

            T_absorber = Ts(:, 1);
            T_wall = Ts(:, 2);
            T_inside = Ts(:, 3);

            figure(fig_num);
            clf;
            hold on;

            plot(ts, T_absorber, 'y-');
            plot(ts, T_wall, 'b-');
            plot(ts, T_inside, 'r-');

            xlabel("time (s)");
            ylabel("Temperature (^oC)");
            legend("Absorber", "Wall", "Inside");
        end
    end
end