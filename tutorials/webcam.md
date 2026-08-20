---
layout: default
title: USB Webcam
parent: Tutorials
nav_order: 5
has_children: false
---

# USB Webcam
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---
# USB Webcam

## V4L2 Camera installieren

Paketlisten aktualisieren:

```bash
sudo apt update
```

ROS-2-Paket installieren:

```bash
sudo apt install ros-jazzy-v4l2-camera
```

## Kamera starten

```bash
ros2 run v4l2_camera v4l2_camera_node
```


