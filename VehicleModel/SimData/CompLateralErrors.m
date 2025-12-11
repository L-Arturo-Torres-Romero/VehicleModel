% MATLAB Script to Compare Three Time Series

% Load Data
file1 = 'LateralErrors_BlockSTA.mat'; 
file2 = 'LateralErrors_SMC_Conventional.mat';
%file3 = 'PID\LateralErrors_PID18ms.mat';

data1 = load(file1);
data2 = load(file2);
%data3 = load(file3);

% Assuming each file has two columns: time and value
time1 = data1.ans.Time;
values1 = data1.ans.Data(:,3);

time2 = data2.ans.Time;
values2 = data2.ans.Data(:,3);

% time3 = data3.ans.Time;
% values3 = data3.ans.Data(:,1);

% Plot the data
figure;
set(gcf, 'Color', 'w'); % Set figure background to white
subplot(2,1,1); % Creates first subplot (2 rows, 1 column, first plot)
hold on;


%plot(time3, values3, 'b--', 'LineWidth', 1.5); % Blue line
plot(time2, values2, 'g-.', 'LineWidth', 1.5); % Green line
plot(time1, values1, 'r', 'LineWidth', 1.5); % Red line



% Formatting the plot
title('Lateral error respect the center of the lane');
xlabel('Time');
ylabel('m');
legend('Conventional', 'Block STA');
grid on;
hold off;

%**********************************************************************

time1 = data1.ans.Time;
values1 = data1.ans.Data(:,4);

time2 = data2.ans.Time;
values2 = data2.ans.Data(:,4);

% time3 = data3.ans.Time;
% values3 = data3.ans.Data(:,3);

subplot(2,1,2); % Creates second subplot (2 rows, 1 column, second plot)
hold on;

%plot(time3, values3, 'b--', 'LineWidth', 1.5); % Blue line
plot(time2, values2, 'g-.', 'LineWidth', 1.5); % Green line
plot(time1, values1, 'r', 'LineWidth', 1.5); % Red line


% Formatting the plot
title('Orientation error');
xlabel('Time');
ylabel('rads');
legend('Conventional', 'Block STA');
grid on;
hold off;