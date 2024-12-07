%Method 2 - Constant Steering-Wheel Angle Test
function [new_X, new_Y, new_Vx, new_Psi,newStep] = ConstantSteeringWheelAngleTest(prev_state, space, params,prevStep)

    stepsRun = prevStep;
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3);
    prev_Psi = prev_state(4);

    InitVx = params(2);
    DesiredAngle = params(3); %in degrees
    
    % Define the constant steering-wheel angle (in radians)
    steering_angle = deg2rad(DesiredAngle); % Example: 10 degrees
    
    % Calculate the new orientation
    new_Psi = prev_Psi + steering_angle;
    new_Psi = wrapTo2Pi(new_Psi);

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = prev_Vx;

    newStep = stepsRun + 1;
end