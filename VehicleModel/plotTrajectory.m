P = racetrackwaypoints(:,1:2);
plot(P(:,1),P(:,2),'r');
hold on;
J = out.VehicleXY;
plot(J(:,1),J(:,2),'b');
hold off;