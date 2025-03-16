function loadInterface()

    waypointsPath = 'ModelData/waypoints.mat';;

    load(waypointsPath);   
    % Verify that the matrix has at least 10 rows and three columns
    if size(racetrackwaypoints, 1) >= 10 && size(racetrackwaypoints, 2) >= 3
        % Get the third row of the matrix
        initialValues = racetrackwaypoints(3, 1:3);
        
        % Create the graphical interface
        fig = uifigure('Name', 'Initial conditions', 'Position', [100, 100, 300, 200]);

        % Text field 1
        uilabel(fig, 'Text', 'Initial X:', 'Position', [20, 140, 60, 22]);
        txt1 = uieditfield(fig, 'numeric', 'Position', [100, 140, 100, 22]);
        txt1.Value = initialValues(1);

        % Text field 2
        uilabel(fig, 'Text', 'Initial Y:', 'Position', [20, 100, 60, 22]);
        txt2 = uieditfield(fig, 'numeric', 'Position', [100, 100, 100, 22]);
        txt2.Value = initialValues(2);

        % Text field 3
        P = racetrackwaypoints(:,1:2);
        k = 2;
        LookAhead = 5; %how many points ahead to look for the orientation error
        F = atan2( (P(k+LookAhead,2)-P(k,2)),(P(k+LookAhead,1)-P(k,1))); % Obtaining the road orientation
        psi_des = F(1);
        psi_des = wrapTo2Pi(psi_des);

        uilabel(fig, 'Text', 'Initial Psi:', 'Position', [20, 60, 60, 22]);
        txt3 = uieditfield(fig, 'numeric', 'Position', [100, 60, 100, 22]);
        txt3.Value = psi_des;

        % Accept button
        acceptButton = uibutton(fig, 'Text', 'Accept', ...
            'Position', [100, 20, 100, 30], ...
            'ButtonPushedFcn', @(btn, event) acceptCallback(fig, txt1, txt2, txt3));
    else
        error('The matrix "racetrackwaypoints" must have at least one row and three columns.');
    end
end



function acceptCallback(fig, txt1, txt2, txt3)
    waypointsPath = 'ModelData/waypoints.mat';
    VehicleDataPath = 'MoldelData/VehicleData.sldd';


   load(waypointsPath);
   % assignin('base', 'InitialX', txt1.Value);
   VehicleObj = Simulink.data.dictionary.open(VehicleDataPath);
   dataSection = getSection(VehicleObj, 'Design Data');

   entryObj = getEntry(dataSection, 'InitialX');
   setValue(entryObj, txt1.Value);

   entryObj = getEntry(dataSection, 'InitialY');
   setValue(entryObj, txt2.Value);

   entryObj = getEntry(dataSection, 'InitialPsi');
   setValue(entryObj, txt3.Value);

   saveChanges(VehicleObj);
   close(VehicleObj);
    % This function will handle the "Accept" button functionality
    disp(['Value 1: ', num2str(txt1.Value)]);
    disp(['Value 2: ', num2str(txt2.Value)]);
    disp(['Value 3: ', num2str(txt3.Value)]);
    
    % Close the graphical interface
    delete(fig);
end
