---
layout: default
title: Overview
nav_order: 3
parent: Firmware
has_children: true
---

# Overview

Die Firmware auf dem STM32 des Mobis verwendet MicroROS mittels FreeRTOS und des STM32 Hardware abstraction layer (HAL).

In diesem Abschnitt wird der Aufbau der Firmware und der darin implementierten Treibern erläutert.

## MicroROS für den STM32

Das Setup eines MicroROS Projektes für den STM32 erfolgt mit der Hilfe des [micro-ROS/micro_ros_stm32cubemx_utils](https://github.com/micro-ROS/micro_ros_stm32cubemx_utils/tree/humble) Repositorys.
Ebenfalls Hilfreich ist das Repository [lFatality/stm32_micro_ros_setup](https://github.com/lFatality/stm32_micro_ros_setup).

## Bootprozess vor FreeRTOS/MicroROS

Wir die meisten `C` Programme, ist auch in der Firmware der Entrypoint die `int main(void)` Funktion.
Diese befindet sich in der `main.c` Datei.
Hier werden die Peripheriegeräte und deren Treiber initialisiert und anschließend der FreeRTOS Kernel gestartet.
Die einzelnen Treiber werden in den Unterkapiteln dieses Abschnittes erläutert.
