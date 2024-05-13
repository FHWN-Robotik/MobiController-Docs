---
layout: default
title: Teleop Keyboard
parent: Tutorials
has_children: false
---

# ROS Domain
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Hier wird erklärt wie der Mobi mit der Tastatur gesteuert werden kann.

## Anleitung

1. Mit dem Mobi über SSH verbinden

   {: .note}
   Mehr dazu in der Anleitung [Verwenden des Prebuild Images]({{site.url}}/setup/mobi/image_verwenden.html)

   ```bash
   ssh mobi-xx
   ```

2. MicroROS Agent starten

   {: .note}
   Mehr dazu in der Anleitung [MicroROS Agent]({{site.url}}/ros2/micro_ros_agent.html#microros-agent-starten)

   ```bash
   cd ~/ros2_ws
   source install/setup.bash
   ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/stm32usb
   ```

3. Den `RESET` Button (roter Knopf) des Mobis drücken

   Dies ist leider nötig, da der MicroROS Agent erwartet, dass der STM32 angeschlossen wird, nachdem der Agent gestartet ist.

4. Ein zweites Terminal Tab oder Fenster öffnen und in diesem über SSH auf den Mobi verbinden

5. Die `teleop_keyboard` Node starten

   ```bash
   ros2 run teleop_twist_keyboard teleop_twist_keyboard
   ```
