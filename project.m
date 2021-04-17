%%Intro
clear all; close all;
format long; format compact;
name = 'Jian Qin';
id = 'A15806136';
hw_num = 'project';

global R M G m;
R = 3.3895e6;%(m)
M = 6.39e23;%(kg)
G = 6.67408e-11;%(m^3*kg^-1*s^-2)
m = 800;%(kg)

%% Part 1
for i = 1:6
    [a1, a2, a3, a4, a5, a6] = read_input('simulation_data.txt',i);
    [b1, b2, b3, b4, b5, b6, b7] =  trajectory(a1, a2, a3, a4, a5, a6);
    T{i} = b1;
    X{i} = b2;
    Y{i} = b3;
    Z{i} = b4;
    U{i} = b5;
    V{i} = b6;
    W{i} = b7;
end

%% Part 2

cmap = [1 1 0;1 0 1;0 1 1;1 0 0;0 1 0;0 0 1];
figure(1);hold on;
for i = 1:6
    subplot(2,3,i)
    plot_Mars;hold on;
    plot3(X{i}/1e6,Y{i}/1e6,Z{i}/1e6,'-','linewidth',3,'color',cmap(i,:)); hold on;
    plot3(X{i}(end)/1e6,Y{i}(end)/1e6,Z{i}(end)/1e6,'o','color',cmap(i,:),'markersize',10,'markerfacecolor',cmap(i,:)); hold on;
    title(sprintf('Trajectory #%d',i));
end
view(3);
figure(2); hold on;
subplot(3,1,1);
for i = 1:6
    PO{i} = sqrt(X{i}.^2 + Y{i}.^2 + Z{i}.^2)-R;
end
for i = 1:6
    plot(T{i},PO{i},'-','color',cmap(i,:)); hold on;
end
title('Altitude versus Time');
xlabel('Time(sec)');
ylabel('Altitude(m)');

subplot(3,1,2)
for i = 1:6
    SP{i} = sqrt(U{i}.^2+V{i}.^2+W{i}.^2);
end

for i = 1:6
    plot(T{i},SP{i},'-','color',cmap(i,:));hold on;
end
title('Speed versus Time');
xlabel('Time(sec)');
ylabel('Speed(m/s)');

subplot(3,1,3)
for i = 1:6
    ACC{i} = diff(SP{i}/0.2);
end
for i = 1:6
    plot(T{i}(2:end),ACC{i},'-','color',cmap(i,:));hold on;
end
title('Acceleration versus Time');
xlabel('Time(sec)');
ylabel('Acc(m/s^2)');
legend('Traj.1','Traj.2','Traj.3','Traj.4','Traj.5','Traj.6','location','southwest');


figure(3);
for i = 1:6
    plot(ACC{i},PO{i}(2:end),'-','color',cmap(i,:));hold on;
end
set(gca,'Yscale','log');
xlabel('Acceleration(m/s^2)');
ylabel('Altitude(m)');
title('Acceleration during descent');
legend('Traj.1','Traj.2','Traj.3','Traj.4','Traj.5','Traj.6','location','best');


%% Part 3

trajectory_id = 1:6;
for i = 1:6
    final_time(i) = T{i}(end);
end

for i = 1:6
    final_position{i}(1,1) = X{i}(end);
    final_position{i}(1,2) = Y{i}(end);
    final_position{i}(1,3) = Z{i}(end);
end

for i = 1:6
    final_velocity{i}(1,1) = U{i}(end);
    final_velocity{i}(1,2) = V{i}(end);
    final_velocity{i}(1,3) = W{i}(end);
end

for i = 1:6
    final_speed(i) = sqrt((final_velocity{i}(1,1))^2+(final_velocity{i}(1,2))^2+(final_velocity{i}(1,3))^2);
end

for i = 1:6
    counter = 1;
    for j = 2:length(PO{i})-1
        if (PO{i}(j)>PO{i}(j-1)) && (PO{i}(j)>PO{i}(j+1))
            time_hmax_altitude{i}(counter) = T{i}(find(PO{i} == PO{i}(j)));
            counter = counter + 1;
        end
    end
end

for i = 1:6
    orbital_period(i) = time_hmax_altitude{i}(2)-time_hmax_altitude{i}(1);
end


for i = 1:6
    stat(i).trajectory_id = trajectory_id(i);
    stat(i).final_time = final_time(i);
    stat(i).final_position = final_position{i};
    stat(i).final_velocity = final_velocity{i};
    stat(i).final_speed = final_speed(i);
    stat(i).time_hmax_altitude = time_hmax_altitude{i};
    stat(i).orbital_period = orbital_period(i);
end

%% Part 4

fid = fopen('report.txt','w');
fprintf(fid,'Jian Qin\n');
fprintf(fid,'A15806136\n');
fprintf(fid,'traj_id, landing_time (s), landing_speed (m/s), orbital_period (s)\n');
for i = 1:6
    fprintf(fid,'%d %15.9e %15.9e %15.9e\n',trajectory_id(i),final_time(i),final_speed(i),orbital_period(i));
end
fclose = fclose(fid);


p1a = evalc('help read_input');
p1b = evalc('help trajectory');
p1c = 'See figure 1';
p1d = 'See figure 2';
p1e = 'See figure 3';
p2a = stat(1);
p2b = stat(2);
p2c = stat(3);
p2d = stat(4);
p2e = stat(5);
p2f = stat(6);
p3 = evalc('type report.txt');
p4a = 'The capsule feel the effect of air drag at altitude 112500 meters';
p4b = 'The parachute is deployed at altitude 1246 meters';









