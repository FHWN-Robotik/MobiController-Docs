---
layout: default
title: IMU
grand_parent: Firmware
parent: Overview
---

# IMU
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der Hardware-Controller verwendet eine IMU des Typs *BNO055* ([Datenblatt](https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bno055-ds000.pdf)).
Die Kommunikation mit der IMU erfolgt über *I²C*, wobei die IMU die Adresse `0x28 (BNO055_I2C_ADDR_LO)` besitzt.
Der Treiber basiert auf dem [bno055_stm32](https://github.com/ivyknob/bno055_stm32) Treiber, verwendet jedoch DMA für die *I²C* kommunikation.
Zu finden ist der Treiber in den Datein `bno055_dma.{c,h}`.

## Funktionsweise

Die Daten der IMU werden mittels DMA über *I²C* abgefragt.
Wenn die Übertragung abgeschlossen ist, wird das Interrupt `HAL_I2C_MasterRxCpltCallback` in `interrupts.c` aufgerufen.
Dieses ruft wiederrum die Funktion `bno055_read_DMA_complete` auf, welche den gelesenen Wert aktuallisier.

Zum Auslesen der verschiedenen Werte, stellt der Treiber Funktionen zur verfügung.

{: .warning}
Wenn die Variable `uint64_t test;` aus dem Struct `BNO055_s` entfernt wird,
verhindert der IMU Treiber das Booten des STM32.

## Defines

Der Treiber definiert alle Register-Adressen der BNO055 IMU.
Diese sind in der Datei `bno055_dma.h` zu finden.
