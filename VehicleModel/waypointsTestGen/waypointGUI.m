function waypointGUI
    % Create the main figure
    fig = uifigure('Position', [100, 100, 400, 300], 'Name', 'Waypoint Generator');

    % Create dropdown for selecting strategies
    lbl = uilabel(fig, 'Position', [20, 250, 100, 22], 'Text', 'Select Strategy:');
    dd = uidropdown(fig, 'Position', [130, 250, 150, 22], 'Items', {'ConstantSpeedVariableRadiusTest', 'ConstantSteeringWheelAngleTest'});

    % Create button to add strategy
    btnAdd = uibutton(fig, 'Position', [300, 250, 70, 22], 'Text', 'Add', 'ButtonPushedFcn', @(btn, event) addStrategy(dd.Value));

     % Create button to remove selected strategy
    btnRemove = uibutton(fig, 'Position', [300, 220, 70, 22], 'Text', 'Remove', 'ButtonPushedFcn', @(btn, event) removeStrategy());

    % Create listbox to display selected strategies
    lblList = uilabel(fig, 'Position', [20, 200, 100, 22], 'Text', 'Selected Strategies:');
    lb = uilistbox(fig, 'Position', [130, 100, 150, 100]);

    % Create button to generate waypoints
    btnGenerate = uibutton(fig, 'Position', [150, 50, 100, 22], 'Text', 'Generate', 'ButtonPushedFcn', @(btn, event) generateAllStrategies(lb.Items));

    % Create button to view waypoints
    btnView = uibutton(fig, 'Position', [270, 50, 100, 22], 'Text', 'View', 'ButtonPushedFcn', @(btn, event) viewWaypoints(lb.Items));

    % Initialize selected strategies
    selectedStrategies = {};

   function addStrategy(strategy)
       selectedStrategies{end+1} = strategy;
       lb.Items = selectedStrategies;
   end


    % function addStrategy(strategy)
    %    if strategy == 'ConstantSpeedVariableRadiusTest'
    %         % Create a dialog to input variable values
    %         d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Input Variables');
    %         uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'varA1/varB1:');
    %         varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
    %         uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'varA2/varB2:');
    %         varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
    %         uilabel(d, 'Position', [20, 90, 100, 22], 'Text', 'varA3/varB3:');
    %         varA3B3 = uieditfield(d, 'numeric', 'Position', [130, 90, 100, 22]);
    %         uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA3B3.Value));
    %     end
    % 
    %     if strategy == 'ConstantSteeringWheelAngleTest'
    %         % Create a dialog to input variable values
    %         d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Input Variables');
    %         uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'varA1/varB1:');
    %         varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
    %         uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'varA2/varB2:');
    %         varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
    %         uilabel(d, 'Position', [20, 90, 100, 22], 'Text', 'varA3/varB3:');
    %         varA3B3 = uieditfield(d, 'numeric', 'Position', [130, 90, 100, 22]);
    %         uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA3B3.Value));
    %     end
    % end

    function confirmStrategy(d, strategy, var1, var2, var3)
        % Add the strategy and its variables to the listbox
        lb.Items{end+1} = sprintf('%s (var1: %.2f, var2: %.2f, var3: %.2f)', strategy, var1, var2, var3);
        close(d);
    end


    function removeStrategy()
        if ~isempty(lb.Value)
            selectedStrategies(strcmp(selectedStrategies, lb.Value)) = [];
            lb.Items = selectedStrategies;
        end
    end



    function generateAllStrategies(strategies)
        init_X = -1.813353216786993e+02;
        init_Y = 80.539862868856910;
        init_Psi = 0;
        init_Vx = 10;
        space = 0.3;
        length = 20;

        waypoints = [];
        [row, strategiesQty ]= size(strategies);

        for i = 1:strategiesQty
            if isempty(waypoints)
                waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, length, str2func(strategies{i}));
            else
                last_point = waypoints(end, :);
                new_waypoints = GenerateWaypoints(last_point(1), last_point(2), last_point(3), last_point(4), space, length, str2func(strategies{i}));
                waypoints = [waypoints; new_waypoints(2:end, :)];
            end
        end

        racetrackwaypoints = waypoints;
        save('waypoints.mat', 'racetrackwaypoints');
        uialert(fig, 'Waypoints generated and saved to waypoints.mat', 'Success');
    end
end




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

function viewWaypoints(strategies)
    init_X = -1.813353216786993e+02;
    init_Y = 80.539862868856910;
    init_Psi = 0;
    init_Vx = 10;
    space = 0.3;
    length = 500;

    waypoints = [];
    [row, strategiesQty ]= size(strategies);

    for i = 1:strategiesQty
        if isempty(waypoints)
            waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, length, str2func(strategies{i}));
        else
            last_point = waypoints(end, :);
            new_waypoints = GenerateWaypoints(last_point(1), last_point(2), last_point(3), last_point(4), space, length, str2func(strategies{i}));
            waypoints = [waypoints; new_waypoints(2:end, :)];
        end
    end

    % Plot the waypoints
    figure;
    plot(waypoints(:, 1), waypoints(:, 2), 'b');
    xlabel('X');
    ylabel('Y');
    title('Generated Waypoints');
    grid on;
end

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

function [new_X, new_Y, new_Vx, new_Psi] = ConstantSteeringWheelAngleTest(prev_state, space)
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3);
    prev_Psi = prev_state(4);
    
    % Define the constant steering-wheel angle (in radians)
    steering_angle = deg2rad(0.2); % Example: 10 degrees
    
    % Calculate the new orientation
    new_Psi = prev_Psi + steering_angle;
    new_Psi = wrapTo2Pi(new_Psi);

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = prev_Vx;
end