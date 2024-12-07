function waypointGUI
    addpath('waypointsTestGen');
    % Create the main figure
    fig = uifigure('Position', [100, 100, 500, 300], 'Name', 'Waypoint Generator');

    % Create dropdown for selecting strategies
    lbl = uilabel(fig, 'Position', [20, 250, 200, 22], 'Text', 'Select Strategy:');
    dd = uidropdown(fig, 'Position', [130, 250, 150, 22], 'Items', {'StreightLineTest','ConstantSpeedVariableRadiusTest', 'ConstantSteeringWheelAngleTest','VariableSteeringWheelAngleTest'});

    % Create button to add strategy
    btnAdd = uibutton(fig, 'Position', [300, 250, 70, 22], 'Text', 'Add', 'ButtonPushedFcn', @(btn, event) addStrategy(dd.Value));

     % Create button to remove selected strategy
    btnRemove = uibutton(fig, 'Position', [300, 220, 70, 22], 'Text', 'Remove', 'ButtonPushedFcn', @(btn, event) removeStrategy());

    % Create listbox to display selected strategies
    lblList = uilabel(fig, 'Position', [20, 200, 100, 22], 'Text', 'Selected Strategies:');
    lb = uilistbox(fig, 'Position', [130, 100, 150, 100],'Items', {});
    %lb = uilistbox(fig, 'Position', [130, 100, 150, 100]);

    % Create button to generate waypoints
    btnGenerate = uibutton(fig, 'Position', [150, 50, 100, 22], 'Text', 'Generate', 'ButtonPushedFcn', @(btn, event) generateAllStrategies(lb.Items));

    % Create button to view waypoints
    btnView = uibutton(fig, 'Position', [270, 50, 100, 22], 'Text', 'View', 'ButtonPushedFcn', @(btn, event) viewWaypoints(lb.Items));

    % function to execute when the tool closes
    function onClose(~, ~)
        % Perform any cleanup or save operations here
        disp('Closing the GUI and performing cleanup...');
        rmpath('waypointsTestGen');
        delete(fig);
    end

    % Initialize selected strategies
    selectedStrategies = {};

    function addStrategy(strategy)
       if contains(strategy, 'ConstantSpeedVariableRadiusTest')
            % Create a dialog to input variable values
            d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Parameters for strategy');
            uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'Distance (m):');
            varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
            uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'Desired speed (m/s):');
            varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
            uilabel(d, 'Position', [20, 90, 100, 22], 'Text', 'Radius increment (rads):');
            varA3B3  = uieditfield(d, 'numeric', 'Position', [130, 90, 100, 22]);
            % uilabel(d, 'Position', [20, 60, 100, 22], 'Text', 'Orientation(1=positive, 0= negative):');
            % varA4B4  = uieditfield(d, 'numeric', 'Position', [130, 60, 100, 22]);
            uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA3B3.Value,varA3B3.Value));
       end

       if contains(strategy, 'ConstantSteeringWheelAngleTest')
            % Create a dialog to input variable values
            d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Parameters for strategy');
            uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'Distance (m):');
            varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
            uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'Desired speed (m/s):');
            varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
            uilabel(d, 'Position', [20, 90, 100, 22], 'Text', 'Desired Angle (deg):');
            varA3B3  = uieditfield(d, 'numeric', 'Position', [130, 90, 100, 22]);
            uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA3B3.Value,varA3B3.Value));
       end

       if contains(strategy, 'VariableSteeringWheelAngleTest')
            % Create a dialog to input variable values
            d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Parameters for strategy');
            uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'Distance (m):');
            varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
            uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'Desired speed (m/s):');
            varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
            uilabel(d, 'Position', [20, 90, 100, 22], 'Text', 'Steer Factor:');
            varA3B3  = uieditfield(d, 'numeric', 'Position', [130, 90, 100, 22]);
            uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA3B3.Value,1));
       end

        if contains(strategy, 'StreightLineTest')
            % Create a dialog to input variable values
            d = uifigure('Position', [500, 500, 300, 200], 'Name', 'Parameters for strategy');
            uilabel(d, 'Position', [20, 150, 100, 22], 'Text', 'Distance (m):');
            varA1B1 = uieditfield(d, 'numeric', 'Position', [130, 150, 100, 22]);
            uilabel(d, 'Position', [20, 120, 100, 22], 'Text', 'Desired speed (m/s):');
            varA2B2 = uieditfield(d, 'numeric', 'Position', [130, 120, 100, 22]);
            uibutton(d, 'Position', [100, 20, 100, 22], 'Text', 'OK', 'ButtonPushedFcn', @(btn, event) confirmStrategy(d, strategy, varA1B1.Value, varA2B2.Value, varA1B1.Value,varA1B1.Value));
        end
    end

    function confirmStrategy(d, strategy, param1,param2,param3,param4)
        params = [0, 0, 0, 0];
        params(1) = param1;
        params(2) = param2;
        params(3) = param3;
        params(4) = param4;

        % Add the strategy and its variables to the listbox
        % lb.Items{end+1} = sprintf('%s#%s', strategy, mat2str(params));
        % close(d);

        selectedStrategies{end+1} = sprintf('%s#%s', strategy, mat2str(params));
        lb.Items = selectedStrategies;
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
        init_Psi = pi/4;
        init_Vx = 10;
        space = 0.3;


        waypoints = [];
        [row, strategiesQty ]= size(strategies);

        for i = 1:strategiesQty
            if isempty(waypoints)
                waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, strategies{i});
            else
                last_point = waypoints(end, :);
                new_waypoints = GenerateWaypoints(last_point(1), last_point(2), last_point(3), last_point(4), space, strategies{i});
                waypoints = [waypoints; new_waypoints(2:end, :)];
            end
        end

        racetrackwaypoints = waypoints;
        save('waypoints.mat', 'racetrackwaypoints');
        uialert(fig, 'Waypoints generated and saved to waypoints.mat', 'Success');
    end
end




function viewWaypoints(strategies)
    init_X = -1.813353216786993e+02;
    init_Y = 80.539862868856910;
    init_Psi = -pi/2;
    init_Vx = 10;
    space = 0.3;

    waypoints = [];
    [row, strategiesQty ]= size(strategies);

    for i = 1:strategiesQty
        if isempty(waypoints)
            waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, strategies{i});
        else
            last_point = waypoints(end, :);
            new_waypoints = GenerateWaypoints(last_point(1), last_point(2), last_point(3), last_point(4), space, strategies{i});
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



function waypoints = GenerateWaypoints(init_X, init_Y, init_Vx, init_Psi, space, StrategyString)
    % Initialize the number of waypoints
    StringSplitted = split(string(StrategyString), '#');
    testStrategy = str2func(StringSplitted{1});
    params = eval(StringSplitted{2});
    distance = params(1);
    step = 1; % init step counter internal

    num_points = floor(distance / space) + 1;
    
    % Preallocate the waypoints matrix
    waypoints = zeros(num_points, 4); % Include speed in the waypoints matrix
    
    % Set the initial values
    waypoints(1, :) = [init_X, init_Y, init_Vx, init_Psi];
    % Generate the waypoints using the provided test strategy
    for i = 2:num_points
        % Get the new state from the test strategy
        [new_X, new_Y, new_Vx, new_Psi,stepOut] = testStrategy(waypoints(i-1, :), space, params,step);
        step = stepOut; %update the internal counter
        % Update the waypoints matrix
        waypoints(i, :) = [new_X, new_Y, new_Vx, new_Psi];
    end
end


