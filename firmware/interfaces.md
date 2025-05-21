---
layout: default
title: Interfaces
parent: Mobi Firmware
---

# Interfaces
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{: .warning}
Für MicroROS muss *Fast DDS* verwendet werden. Mehr dazu [hier](https://github.com/micro-ROS/micro_ros_arduino/issues/956) und [hier](https://fast-dds.docs.eprosima.com/en/latest/fastdds/ros2/ros2.html). Dies ist auf dem Mobi Image bereits eingerichtet.

## Einleitung

Der Mobi stellt verschiedene *Services* zu Verfügung.
Außerdem published und subscribed er auf mehrere *Topics*.

Einige Services und Topics verwenden Custom Types aus den [Mobi Interface]({{site.utl}}/ros2/mobi_interfaces.html).

## Publishers

### /battery_state

[sensor_msgs/msg/BatteryState](https://docs.ros2.org/latest/api/sensor_msgs/msg/BatteryState.html)

### /button
[std_msgs/msg/Bool](https://docs.ros2.org/latest/api/std_msgs/msg/Bool.html)

### /encoders
[mobi_interfaces/msg/EncodersStamped]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacesmsgencodersstamped)

Merh infos zu den Encodern sind in der [Mobi Hardware]({{site.url}}/mobi_hardware/Motor_Encoder.html) zu finden.

### /imu
[sensor_msgs/msg/Imu](https://docs.ros2.org/latest/api/sensor_msgs/msg/Imu.html)

### /pozyx
[geometry_msgs/msg/PoseStamped](https://docs.ros2.org/latest/api/geometry_msgs/msg/PoseStamped.html)

### /temperature
[sensor_msgs/msg/Temperature](https://docs.ros2.org/latest/api/sensor_msgs/msg/Temperature.html)

Die Temeratur ist in `°C`.

### /ultra_ranges
[mobi_interfaces/msg/UltraRanges]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacesmsgultraranges)

Die Entfernung ist in `m`.

## Subscribers

### /cmd_vel
[geometry_msgs/msg/Twist](https://docs.ros2.org/latest/api/geometry_msgs/msg/Twist.html)

Die Einheiten sind `mm/s` und `mrad/s`.

## Services

### /boot_bootloader
[std_srvs/srv/Trigger](https://docs.ros2.org/latest/api/std_srvs/srv/Trigger.html)

### /imu_get_calib_data
[mobi_interfaces/srv/GetImuCalibData]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvgetimucalibdata)

### /imu_get_calib_status
[mobi_interfaces/srv/GetCalibStatus]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvgetcalibstatus)

### /imu_set_calib_data
[mobi_interfaces/srv/SetImuCalibData]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvsetimucalibdata)

### /led_strip_set
[mobi_interfaces/srv/SetLedStrip]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvsetledstrip)

### /pozyx_get_calib_status
[mobi_interfaces/srv/GetCalibStatus]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvgetcalibstatus)

### /pozyx_get_info
[mobi_interfaces/srv/GetPozyxInfo]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvgetpozyxinfo)

### /pozyx_set_power
[mobi_interfaces/srv/SetPower]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvsetpower)
