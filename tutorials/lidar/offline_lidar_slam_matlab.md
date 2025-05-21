---
layout: default
title: Offline LiDAR SLAM (MATLAB)
grand_parent: Tutorials
parent: LiDAR
---

# Offline LiDAR SLAM (MATLAB)
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Voraussetzungen

- `Matlab` Installation mit `ROS Toolbox` und `Navigation Toolbox`

## Umsetzung

Um mittels Matlab einen offline LiDAR Slam zu implementieren, wird ein ROS-Bag eines LiDAR Scans benötigt.
Ein Beispiel ROS-Bag kann [hier](https://github.com/FHWN-Robotik/MobiController-Docs/blob/main/assets/ros/rosbag2) heruntergeladen werden.

Anschließend kann das [Matlab Script](https://github.com/FHWN-Robotik/MobiController-Docs/blob/main/assets/code/matlab/lidar_offline.m) heruntergeladen werden.
Dieses sollte im gleichen Ordner liegen, wie das ROS-Bag. Alternativ kann auch der Dateipfad im Script angepasst werden.
Ohne Anpassung des Dateipfades sollte die Ordnerstruktur wie folgt aussehen:

```
.
├── lidar_offline.m
└── rosbag2
    ├── metadata.yaml
    └── rosbag2_2023_10_17-11_01_52_0.db3
```

Bevor das Script ausgeführt wird, kann dieses noch Konfiguriert werden.
Es ist empfehlenswert die Werte `gap`, `trim_start` und `trim_end` an das eigene ROS-Bag anzupassen.

Nachdem alle Anpassungen wie gewünscht erfolgt sind, kann das Script ausgeführt werden. Nun erscheint zuerst ein Ladebalken, anschließend öffnen sich zwei Plots.
`Figure 1` zeigt die überlagerten LiDAR Scans und den daraus berechneten Pfad.
`Figure 2` stellt die erstellte Occupancy Map und den zurückgelegten Pfad dar.

![Figure 1 - Pointcloud]({{site.url}}/assets/imgs/lidar/matlab_slam_offline_pointcloud.png "Figure 1")
![Figure 2 - Occupancy Map]({{site.url}}/assets/imgs/lidar/matlab_slam_offline_occ_map.png "Figure 2")
