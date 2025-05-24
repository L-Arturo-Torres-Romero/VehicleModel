figure;
set(gcf, 'Color', 'w'); % Set the figure background color to white
P = racetrackwaypoints(:,1:2);
plot(P(:,1),P(:,2),'r', 'LineStyle', '-');
hold on;
J = out.VehiclePose(:,1:2);
plot(J(:,1),J(:,2),'b', 'LineStyle', '--');
hold off;

% Add labels to the axes
xlabel('X axis (m)', 'FontSize', 12);
ylabel('Y axis (m)', 'FontSize', 12);