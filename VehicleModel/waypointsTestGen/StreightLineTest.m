function [new_X, new_Y, new_Vx, new_Psi,newStep] = StreightLineTest(prev_state, space,params,prevStep)

    stepsRun = prevStep;
    % Extract previous state
    prev_X = prev_state(1);
    prev_Y = prev_state(2);
    prev_Vx = prev_state(3); 
    prev_Psi = prev_state(4);

    initVx = params(2);
    
    % Calculate the new orientation
    new_Psi = prev_Psi;

    % Calculate the new coordinates
    new_X = prev_X + space * cos(new_Psi);
    new_Y = prev_Y + space * sin(new_Psi);
    
    % Speed remains constant
    new_Vx = initVx;

    newStep = stepsRun + 1;
end