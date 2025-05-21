---
layout: default
title: Mobi Interfaces
parent: ROS2
has_children: false
---

# Mobi Interfaces
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

{: .source}
<https://github.com/FHWN-Robotik/mobi_interfaces>

Für den Mobi werden Custom Messages und Services benötigt.

## Installation

1. In einen ROS Workspace wechseln

   ```bash
   cd ~/ros2_ws
   ```

2. Interfaces herunterladen

   ```bash
   git clone https://github.com/FHWN-Robotik/mobi_interfaces.git src/mobi_interfaces
   ```

3. Workspace builden

   ```bash
   colcon build
   ```

## Messages

### mobi_interfaces/msg/ColorRGBW

```text
uint8 r
uint8 g
uint8 b
uint8 w
```

### mobi_interfaces/msg/Encoders

```text
int32 front_left
int32 front_right
int32 rear_left
int32 rear_right
```

### mobi_interfaces/msg/EncodersStamped

```text
std_msgs/Header header
mobi_interfaces/Encoders encoders
```

### mobi_interfaces/msg/UltraRanges

```text
sensor_msgs/Range front_left
sensor_msgs/Range front_right
sensor_msgs/Range center_left
sensor_msgs/Range center_right
sensor_msgs/Range rear_left
sensor_msgs/Range rear_right
```

## Services

### mobi_interfaces/srv/GetCalibStatus

```text
---
uint8 system
int8 gyro
uint8 mag
uint8 accel
```

### mobi_interfaces/srv/GetImuCalibData

```text
---
int16 offset_gyroscope_x
int16 offset_gyroscope_y
int16 offset_gyroscope_z
int16 offset_magnetometer_x
int16 offset_magnetometer_y
int16 offset_magnetometer_z
int16 offset_accelerometer_x
int16 offset_accelerometer_y
int16 offset_accelerometer_z
uint16 radius_magnetometer
uint16 radius_accelerometer
```

### mobi_interfaces/srv/GetPozyxInfo

```text
---
uint8 who_am_i # This should allways be 0x43, if it's not, there is a problem.
uint16 network_id
uint8 firmware_version
uint8 harware_version
```

### mobi_interfaces/srv/SetImuCalibData

```text
int16 offset_gyroscope_x
int16 offset_gyroscope_y
int16 offset_gyroscope_z
int16 offset_magnetometer_x
int16 offset_magnetometer_y
int16 offset_magnetometer_z
int16 offset_accelerometer_x
int16 offset_accelerometer_y
int16 offset_accelerometer_z
uint16 radius_magnetometer
uint16 radius_accelerometer
---
bool success
string message
```

### mobi_interfaces/srv/SetLedStrip

```text
# LED Strip animation type constants
uint8 LED_ANIMATION_OFF = 0
uint8 LED_ANIMATION_ON = 1
uint8 LED_ANIMATION_DRIVING_LIGHTS = 2
uint8 LED_ANIMATION_BEACON = 3
uint8 LED_ANIMATION_BLINK = 4
uint8 LED_ANIMATION_FILL = 5

uint8 type
mobi_interfaces/ColorRGBW color

uint8 update_rate
uint8 frame_count

uint8 line_length
uint8 line_count
bool rotate_left
---
bool success
string message
```

### mobi_interfaces/srv/SetPower

```text
bool state
---
bool old_state
```
