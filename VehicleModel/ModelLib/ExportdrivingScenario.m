
load('waypoints.mat'); % Debe contener una variable con la lista de waypoints
waypoints = racetrackwaypoints(:, 1:2); % Solo X, Y
velocities = racetrackwaypoints(:, 3); % Velocidad en cada punto

realVehiclePose = VehiclePose;


% Crear el escenario
scenario = drivingScenario('SampleTime',0.1','StopTime',60);

roadCenters = [waypoints, zeros(size(waypoints(:,1)))]; % Usa los waypoints cargados
% Agregar road center al escenario
cr = road(scenario, roadCenters, 'Lanes', lanespec(2)); % Define lanes explicitly
%cr = road(scenario,roadCenters,6);


% Agregar un vehículo
veh = vehicle(scenario, ClassID=1,PlotColor='red',Name='EgoMamalon');
%roadActor = actor(scenario, 'ClassID', 3, 'Position', [0,0,0]); % Static road object


%Definir la trayectoria del vehículo con los waypoints y velocidades
smoothTrajectory(veh, realVehiclePose);


drivingScenarioDesigner(scenario); %this is to open the drivingScenarioDesigner





