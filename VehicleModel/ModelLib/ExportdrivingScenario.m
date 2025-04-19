load('waypoints.mat'); % It must contain a variable with the way-point list.
waypoints = racetrackwaypoints(:, 1:2); % Only X, Y
velocities = racetrackwaypoints(:, 3); % Velocity on each point.

realVehiclePose = VehiclePose;

% Create the scenario.
scenario = drivingScenario('SampleTime',0.1','StopTime',60);

roadCenters = [waypoints, zeros(size(waypoints(:,1)))]; % Use the loaded way-points
% Add the read center to the scenario. 
cr = road(scenario, roadCenters, 'Lanes', lanespec(3)); % Define lanes explicitly

% Add a vehicle.
veh = vehicle(scenario, ClassID=1,PlotColor='red',Name='EgoVehicle');
%roadActor = actor(scenario, 'ClassID', 3, 'Position', [0,0,0]); % Static road object

% Define the vehicle trajectory with the way-points and speeds.
smoothTrajectory(veh, realVehiclePose);

drivingScenarioDesigner(scenario); %this is to open the drivingScenarioDesigner
