---
layout: default
title: IMU Calibration
parent: Tutorials
has_children: false
---

# IMU Calibration
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Die IMU muss kalibriert werden, um voll funktionsfähig zu sein.

## Kalibrierung

Eine Kalibrierungs-Anleitung kann auf [YouTube](https://www.youtube.com/watch?v=Bw0WuAyGsnY) gefunden werden.

Der Kalibrierungsstatus kann mit [/imu_get_calib_status]({{site.url}}/firmware/interfaces.html#imu_get_calib_status) abgefragt werden.

## Speichern der Kalibrationsdaten

Die Kalibrationsdaten können mit den Services [/imu_get_calib_data]({{site.url}}/firmware/interfaces.html#imu_get_calib_data) und [/imu_set_calib_data]({{site.url}}/firmware/interfaces.html#imu_set_calib_data) abgerufen und wieder gesetzt werden.
Dies ermöglicht es, die Daten lokal zu abzuspeichern, damit die IMU nicht nach jedem neustart erneut kalibriert werden muss.
