%Method 3 - Constant Speed, Variable Radius Test
function [new_X, new_Y, new_Vx, new_Psi, newStep] = ConstantSpeedVariableRadiusTest(prev_state, space,params,prevStep)

    stepsRun = prevStep;
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3); 
    prev_Psi = prev_state(4);

    initVx = params(2);
    radIncrement = params(3);
    % if params(4) > 0
    %     isPositiveOriented = 1;
    % else
    %     isPositiveOriented = -1;
    % end
    
    % Define the constant speed and variable radius parameters
    constant_speed = initVx; % Use the initial or desired speed
    radius_increment = radIncrement; % Example: 0.05 g lateral acceleration increments
    
    % Calculate the new radius based on the previous state
    radius = constant_speed^2 / (9.81 * radius_increment);
    
    % Calculate the new orientation
    new_Psi = prev_Psi + (constant_speed / radius) * space; %*isPositiveOriented;
    new_Psi = wrapTo2Pi(new_Psi);

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = constant_speed;

    newStep = stepsRun + 1;
end