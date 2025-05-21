---
layout: default
title: Twist aus Joy Topic
grand_parent: Tutorials
parent: Gamepad
nav_order: 3
---

# Twist aus Joy Topic
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{: .source}
<https://github.com/ros2/teleop_twist_joy>

## Einleitung

Um einen Roboter mit einem Gamepad steuern zu können, ist es nötig den `/joy` *Topic* mit dem Typ `sensor_msgs/Joy` des Gamepads in einen `geometry_msgs/Twist` *Topic* umzuwandeln, dieser heißt im Normalfall `/cmd_vel`.
Folgend wird erklärt wie dies erreicht werden kann.

## Installation Teleop Twist Joy

Um das [ROS Package](https://github.com/ros2/teleop_twist_joy) zu installieren, muss folgender Befehl ausgeführt werden.

```bash
sudo apt install ros-$ROS_DISTRO-teleop-twist-joy
```

## Starten der Node

Die *Node* kann mit folgendem Befehl gestartet werden.

```bash
ros2 launch teleop_twist_joy teleop-launch.py joy_config:='xbox'
```

## Konfigurieren

Die *Node* ermöglicht es diese mittels Parametern zu konfigurieren. Dies lässt sich am einfachsten mittels einer Konfigurationsdatei machen.
Folgend wird eine Beispielkonfiguration gezeigt, alle verfügbaren Parameter sind auf [GitHub](https://github.com/ros2/teleop_twist_joy?tab=readme-ov-file#parameters) zu finden.

Die Konfigurationsdatei muss sich im `config` Ordner einer *Node* befinden. Daher ist der Dateipfad in etwa `~/<ros_ws_name>/src/<node_name>/config/joystick.yaml`.

```yaml
teleop_node:
  ros__parameters:
    axis_linear:  # Left thumb stick vertical
      x: 1
    scale_linear:
      x: 0.2
    scale_linear_turbo:
      x: 2.0

    axis_angular:  # Left thumb stick horizontal
      yaw: 0
    scale_angular:
      yaw: 0.2
    scale_angular_turbo:
      yaw: 2.0

    enable_button: 4  # Left trigger button
    enable_turbo_button: 5  # Right trigger button

    require_enable_button: true

    inverted_reverse: true
```

Nun kann die *Node* mit folgendem Befehl mit der obigen Config gestartet werden.

```bash
ros2 launch teleop_twist_joy teleop-launch.py config_filepath:='~/<ros_ws_name>/src/<node_name>/config/joystick.yaml'
```

Es empfiehlt sich die `teleop_twist_joy` gemeinsam mit der `joy_node` mit einem *Launchfile* zu starten.
