---
layout: default
title: Online LiDAR SLAM (MATLAB)
parent: LiDAR
---

# Online LiDAR SLAM (MATLAB)

Um mittels Matlab einen online LiDAR Slam zu implementieren werden zwei ROS Nodes benötigt. Eine veröffentlicht die LiDAR Daten, die andere führt den Slam-Algorithmus aus.

## Voraussetzungen

- `Matlab` Installation mit `ROS Toolbox` und `Navigation Toolbox`
- Ein `Mobi` mit `ROS2` Installation und `LiDAR`.

## LiDAR Node

Die LiDAR Node muss auf dem Mobi oder einem anderen Computer mit angeschlossenen LiDAR gestartet werden.

Dazu muss zuerst das folgende Repository in den `src` Ordner eines `ROS Workspaces` gecloned werden.

```bash
git clone https://github.com/allenh1/rplidar_ros.git
```

Danach muss der Workspace gebuilded werden. Dazu muss folgender Befehl ausgeführt werden.

```bash
colcon build --symlink-install
```

Anschließend kann die LiDAR Node mit folgendem Befehl gestartet werden.

```bash
ros2 launch rplidar_ros rplidar.launch.py
```

## Matlab Node

Seitens Matlab muss das [Matlab Script](https://github.com/Flo2410/MobiController-Docs/blob/main/assets/code/matlab/lidar_online.m) heruntergeladen und ausgeführt werden.
Nun erscheinen zwei Fenster. Die `Figure 1` zeigt den online Slam. Die `Waitbar` mit dem Titel `Running SLAM` erlaubt es, mit dem Drücken des `Cancel` Knopfs, das Programm zu beenden.

![Figure 1 - online SLAM]({{site.url}}/assets/imgs/lidar/matlab_slam_figure.png "Figure 1")
![Waitbar - Running SLAM]({{site.url}}/assets/imgs/lidar/matlab_cancel_running_slam.png "Waitbar")
