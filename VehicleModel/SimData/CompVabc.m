% MATLAB Script to Compare Three Time Series

% Load Data
file1 = 'Alcala\SteeringVabc_Alcala18ms.mat'; 
file2 = 'Urbano\SteeringVabc_Urbano18ms.mat';
file3 = 'PID\SteeringVabc_PID18ms.mat';

data1 = load(file1);
data2 = load(file2);
data3 = load(file3);

% Assuming each file has two columns: time and value
time1 = data1.ans.Time;
values1 = data1.ans.Data(:,1);

time2 = data1.ans.Time;
values2 = data1.ans.Data(:,2);

time3 = data1.ans.Time;
values3 = data1.ans.Data(:,3);

% Plot the data
figure;
set(gcf, 'Color', 'w'); % Set figure background to white
subplot(3,1,1); % Creates first subplot (2 rows, 1 column, first plot)
hold on;

plot(time1, values1, 'r', 'LineWidth', 1.5); % Red line
plot(time2, values2, 'g-.', 'LineWidth', 1.5); % Green line
plot(time3, values3, 'b--', 'LineWidth', 1.5); % Blue line

% Formatting the plot
title('Alcala BLDC voltages');
xlabel('Time');
ylabel('V');
legend('V_a', 'V_b', 'V_c');
grid on;
hold off;

%**********************************************************************

time1 = data2.ans.Time;
values1 = data2.ans.Data(:,1);

time2 = data2.ans.Time;
values2 = data2.ans.Data(:,2);

time3 = data2.ans.Time;
values3 = data2.ans.Data(:,3);

subplot(3,1,2); % Creates second subplot (3 rows, 1 column, second plot)
hold on;

plot(time1, values1, 'r', 'LineWidth', 1.5); % Red line
plot(time2, values2, 'g-.', 'LineWidth', 1.5); % Green line
plot(time3, values3, 'b--', 'LineWidth', 1.5); % Blue line

% Formatting the plot
title('Urbano BLDC voltages');
xlabel('Time');
ylabel('V');
legend('V_a', 'V_b', 'V_c');
grid on;
hold off;

%******************************************************

time1 = data3.ans.Time;
values1 = data3.ans.Data(:,1);

time2 = data3.ans.Time;
values2 = data3.ans.Data(:,2);

time3 = data3.ans.Time;
values3 = data3.ans.Data(:,3);

subplot(3,1,3); % Creates third subplot (3 rows, 1 column, third plot)
hold on;

plot(time1, values1, 'r', 'LineWidth', 1.5); % Red line
plot(time2, values2, 'g-.', 'LineWidth', 1.5); % Green line
plot(time3, values3, 'b--', 'LineWidth', 1.5); % Blue line

% Formatting the plot
title('PID BLDC voltages');
xlabel('Time');
ylabel('V');
legend('V_a', 'V_b', 'V_c');
grid on;
hold off;