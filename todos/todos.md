---
layout: default
title: TODOs
nav_order: 7
has_children: false
---

# TODOs

Hier eine Liste mit allen TODOs für den Hardwarecontroller des Mobis.

- Hinzufügen eines `Boot` buttons am `BOOT0` für den reboot in den Bootloader.
- Hinzufügen eines Jumpers um die Stromversorgung über den USB-C Port zu ermöglichen.
  Dies ist vorallem beim Arbeiten am Conroller außerhalb des Mobis sehr praktisch.
- Interrupt Pin der IMU mit dem STM32 verbinden um deie Daten interrupt basiert auslesen zu können.
  Aktuell wird die IMU über I2C gepollt.
