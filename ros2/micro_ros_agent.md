---
layout: default
title: MicroROS Agent
parent: ROS2
has_children: false
---

# MicroROS Agent
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung
Hier wird erklärt wie der MicroROS Agent installiert und gestartet wird.

## Installation

{: .source}
<https://github.com/micro-ROS/micro_ros_setup/tree/humble?tab=readme-ov-file#building-micro-ros-agent>

{: .note}
Der MicroROS Agent ist auf dem Mobi bereits vorinstalliert.

1. Falls noch nicht vorhanden, einen ROS Workspace erstellen

   ```bash
   mkdir -p ~/ros2_ws/src
   ```

2. In einen/den ROS Workspace wechseln

   ```bash
   cd ~/ros2_ws
   ```

3. Den MicoROS agent herunterladen

   {: .note}
   `$ROS_DISRO` ist eine Environment variable welche die ROS Version beinhaltet.
   Im Fall des Mobis ist diese `humble`

   ```bash
   git clone -b $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git src/micro_ros_setup 
   ```

4. Den Workspace builden und sourcen

   ```bash
   colcon build
   source install/setup.bash
   ```

5. rosdep initialisieren

   ```bash
   sudo rosdep init
   rosdep update
   ```

6. Den MicroROS Agent erstellen und builden

   ```bash
   ros2 run micro_ros_setup create_agent_ws.sh
   ros2 run micro_ros_setup build_agent.sh
   ```

## MicroROS Agent starten

1. Den Workspace sourcen

   ```bash
   source install/setup.bash
   cd ~/ros2_ws
   ```

2. Falls der Agent noch nicht gebuildet ist, diesen builden.

   ```bash
   colcon build
   ```

3. Den Agent starten

   ```bash
   ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/stm32usb
   ```

4. Nachdem der Agent gestartet ist, muss der `RESET` Button des Mobis gedrückt werden.
