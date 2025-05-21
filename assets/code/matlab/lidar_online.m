clear all; close all; clc;

% Create ROS Node
node = ros2node("matlab");

% Subscribe to topic
sub = ros2subscriber(node, "/scan", "sensor_msgs/LaserScan");


% Set Slam Params
maxRange = 8; % meters
resolution = 10; % cells per meter

% Init Slam object
slam = lidarSLAM(resolution, maxRange);
slam.LoopClosureThreshold = 200;
slam.LoopClosureSearchRadius = 8;


wbar = waitbar(0, 'To stop press cancel', 'Name', 'Running SLAM','CreateCancelBtn','delete(gcbf)');

% Main Loop
while true
    [scanData, status, statustext] = receive(sub, 1); % Get the current lidar scan from the robot

    if status % If the scan is good, do SLAM
        scan = rosReadLidarScan(scanData); % Convert sensor_msgs/LaserScan to Matlab lidarScan object
        addScan(slam, scan);  % Add the scan
        
        % Plot current slam
        figure(1);
        show(slam);
    else
        % If error -> print it
        disp(statustext)
    end

    if ~ishandle(wbar)
        % Stop the if cancel button was pressed
        disp('Stopped by user');
        break;
    else
        % Update the wait bar
        waitbar(0,wbar);
    end
end

% Create Occupancy Map
[scansSLAM, poses] = scansAndPoses(slam);
occMap = buildMap(scansSLAM, poses, resolution, maxRange);

% Plot Occupancy Map 
figure(2);
show(occMap);
hold on;
plot(poses(1:end, 1), poses(1:end, 2));
title("Occupancy Map");
