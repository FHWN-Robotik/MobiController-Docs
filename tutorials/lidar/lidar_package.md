---
layout: default
title: lamtec LiDAR A2M8
grand_parent: Tutorials
parent: LiDAR
---

# lamtec LiDAR A2M8
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

# Slamtec LiDAR A2M8

{: .note }
**Hinweis:** Wird nur auf dem Mobi benötigt.

## Repository herunterladen

In den `src`-Ordner des ROS-2-Workspaces wechseln:

```bash
cd ~/ros2_ws/src
```

Repository klonen:

```bash
git clone https://github.com/Slamtec/sllidar_ros2.git
```

---

## Package bauen

Zurück in den Workspace:

```bash
cd ~/ros2_ws
```

Package bauen:

```bash
colcon build --packages-select sllidar_ros2
```

Anschließend den Workspace sourcen:

```bash
source ~/ros2_ws/install/setup.bash
```

> **Hinweis:** Nach jedem neuen Terminal muss der Workspace erneut mit `source ~/ros2_ws/install/setup.bash` geladen werden, sofern dies nicht automatisch über die `.bashrc` erfolgt.

Optional dauerhaft eintragen:

```bash
echo 'source ~/ros2_ws/install/setup.bash' >> ~/.bashrc
```

---

## Installation überprüfen

Überprüfen, ob die ausführbaren Nodes des Packages gefunden werden:

```bash
ros2 pkg executables sllidar_ros2
```

---

## LiDAR starten

Für einen LiDAR auf `/dev/ttyUSB0` mit einer Baudrate von `115200`:

```bash
ros2 run sllidar_ros2 sllidar_node --ros-args \
  -p serial_port:=/dev/ttyUSB0 \
  -p serial_baudrate:=115200
```
