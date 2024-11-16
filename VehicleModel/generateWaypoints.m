% Example usage
init_X = -1.813353216786993e+02;
init_Y = 80.539862868856910;
init_Psi = 0;
init_Vx = 10; % Initial or desired speed
space = 0.3;
length = 1000;

% Generate waypoints using the Constant Speed, Variable Radius Test strategy
waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, length, @ConstantSpeedVariableRadiusTest);
racetrackwaypoints = waypoints;
%saveArrayToMat(racetrackwaypoints,waypoints.mat);
save('waypoints.mat', 'racetrackwaypoints');

function waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, length, testStrategy)
    % Initialize the number of waypoints
    num_points = floor(length / space) + 1;
    
    % Preallocate the waypoints matrix
    waypoints = zeros(num_points, 4); % Include speed in the waypoints matrix
    
    % Set the initial values
    waypoints(1, :) = [init_X, init_Y, init_Vx, init_Psi];
    
    % Generate the waypoints using the provided test strategy
    for i = 2:num_points
        % Get the new state from the test strategy
        [new_X, new_Y, new_Vx, new_Psi] = testStrategy(waypoints(i-1, :), space);
        
        % Update the waypoints matrix
        waypoints(i, :) = [new_X, new_Y, new_Vx, new_Psi];
    end
end

% Example test strategy for Constant Steering-Wheel Angle Test
function [new_X, new_Y, new_Vx, new_Psi] = ConstantSteeringWheelAngleTest(prev_state, space)
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3);
    prev_Psi = prev_state(4);
    
    % Define the constant steering-wheel angle (in radians)
    steering_angle = deg2rad(10); % Example: 10 degrees
    
    % Calculate the new orientation
    new_Psi = prev_Psi + steering_angle;
    new_Psi = wrapTo2Pi(new_Psi);

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = prev_Vx;
end

% Test strategy for Constant Speed, Variable Radius Test
function [new_X, new_Y, new_Vx, new_Psi] = ConstantSpeedVariableRadiusTest(prev_state, space)
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3); 
    prev_Psi = prev_state(4);
    
    % Define the constant speed and variable radius parameters
    constant_speed = prev_Vx; % Use the initial or desired speed
    radius_increment = 0.005; % Example: 0.05 g lateral acceleration increments
    
    % Calculate the new radius based on the previous state
    radius = constant_speed^2 / (9.81 * radius_increment);
    
    % Calculate the new orientation
    new_Psi = prev_Psi + (constant_speed / radius) * space;
    new_Psi = wrapTo2Pi(new_Psi);

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = constant_speed;
end
