% MATLAB Script to Compare Three Time Series

% Load Data
file1 = 'Alcala\VehiclePose_Alcala18ms.mat'; % Replace with your actual filenames
file2 = 'Urbano\VehiclePose_Urbano18ms.mat';
file3 = 'PID\VehiclePose_PID18ms.mat';

data1 = load(file1);
data2 = load(file2);
data3 = load(file3);
load('waypoints.mat'); %load the reference
P = racetrackwaypoints(:,1:2);

% Assuming each file has two columns: time and value
%time = (data1.ans.Time >= 50) & (data1.ans.Time <= 100);
values1X = data1.ans.Data(:,1);
values1Y = data1.ans.Data(:,2);


idx = find(data1.ans.Time == 0);
timePoints = data1.ans.Data(idx,:);
for i = 1:8
    idx = find(data1.ans.Time == ((i)*10));
    timePoints = [timePoints;data1.ans.Data(idx,:)];
end



values2X = data2.ans.Data(:,1);
values2Y = data2.ans.Data(:,2);

values3X = data3.ans.Data(:,1);
values3Y = data3.ans.Data(:,2);

% Plot the data
figure;
set(gcf, 'Color', 'w'); % Set figure background to white
hold on;
plot(values1X, values1Y, 'r', 'LineWidth', 0.8); % Red line
plot(values2X, values2Y, 'g-.', 'LineWidth', 0.8); % Green line
plot(values3X, values3Y, 'b--', 'LineWidth', 0.8); % Blue line
%plot(P(:,1),P(:,2),'k','LineWidth', 1); % plot the reference


for i = 1:8
    plot(timePoints(i,1), timePoints(i,2), 'rd');
end



% Formatting the plot
title('Comparison trajectories');
xlabel('X axis(m)');
ylabel('Y axis(m)');
%legend('Alcala', 'Urbano', 'PID');
grid on;
hold off;