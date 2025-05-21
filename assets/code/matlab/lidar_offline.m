clear all; close all; clc;

%% Config

% Loading
gap = 2; % Only read every second scan
trim_start = 40; % Trim the first 40 scans
trim_end = 40; % Trim the last 40 scans

% SLAM
maxRange = 8; % meters
resolution = 10; % cells per meter
loopClosureThreshold = 200;
loopClosureSearchRadius = 8;

%% Load ROS-Bag
% If you cloned the whole repository, you can use "../../src/ros/rosbag2/"
% as the path bellow
bag = ros2bagreader("rosbag2/"); % Open ROS-Bag
bag.AvailableTopics % Print topics available within the ROS-Bag

scan_bag = select(bag, "Topic","/scan"); % Load the /scan topic from the bag
scan_msgs = readMessages(scan_bag); % Read the messages from the /scan topic

scan_count = 1; % Number of scans loaded
for i = trim_start:gap:length(scan_msgs) - trim_end % Go through the lidar scans to load/convert them
    scans(scan_count) = rosReadLidarScan(scan_msgs{i}); % Convert the current "sensor_msgs/LaserScan" to a "lidarScan" object
    scan_count = scan_count + 1;
end


%% SLAM
% Init lidarSLAM object
slam = lidarSLAM(resolution, maxRange);
slam.LoopClosureThreshold = loopClosureThreshold;
slam.LoopClosureSearchRadius = loopClosureSearchRadius;

wbar = waitbar(0,sprintf("Adding scans"), "Name", "Running SLAM"); % Open the waitbar

for i = 1:numel(scans) % Go through the loaded scans and add them to the SLAM object
    wbar = waitbar(i/scan_count, wbar, sprintf("Adding scan %d/%d", i, scan_count)); % Adjust the waitbar
    addScan(slam, scans(i)); % Add the scan to the SLAM object
end

wbar = waitbar(1, wbar, sprintf("Building map..."));

[scansSLAM, poses] = scansAndPoses(slam); % Get the scans and poses from the SLAM object
occMap = buildMap(scansSLAM, poses, resolution, maxRange); % Build the occupancy map

%% Plot
figure(1);
show(slam); % Show SLAM object
title("Overlayed Pointclouds");

figure(2);
show(occMap); % Show occupancy map
hold on;
plot(poses(1:end, 1), poses(1:end, 2)); % Plot the path
title('Occupancy Map');

close(wbar);