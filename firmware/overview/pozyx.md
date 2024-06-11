---
layout: default
title: Pozyx
grand_parent: Firmware
parent: Overview
---

# Pozyx
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Die Kommunikation mit dem Pozyx-Tag erfolgt über *I²C* mit der Adresse `0x4B (POZYX_I2C_ADDRESS)`.
Der Treiber basiert auf der [offiziellen Arduino Libraray](https://github.com/pozyxLabs/Pozyx-Arduino-library), implementiert jedoch lediglich die benötigten funktionen.

{: .note}
Um den Pozyx-Tag verwenden zu können, muss dieser mittels des [Power-Managers]({{site.url}}/firmware/overview/power_manager.html) eingeschaltet werden.

## Funktionsweise

Beim Initialisieren des Treibers werden die Register `POZYX_INT_MASK` und `POZYX_INT_CONFIG` gesetzt.
Dabei wird das Interrupt so configuriert, dass der Pin des Pozyx-Tags auf **HIGH** gestzt wird, sobald eine neue Positionsmessung vorhanden ist.
Dies löst ein externes Interrupt auf dem Pin `POZYX_INT1` des STM32 aus, wodurch der Treier erkennt, dass neue Daten verfügbar sind.

Sind neue Daten verfügbar werden diese über *I²C* und DMA abgerufen.

Weiter Informationen zum Pozx-Tag könne in der Pozyx-Dokumentation gefunden werden.
Besonders Hilfreich ist die [Register Übersicht](https://docs.pozyx.io/creator/datasheet-register-overview#Datasheet&Registeroverview-POZYX_INT_MASK) des Pozyx-Tags.

## Defines

Für den Pozyx-Tag sind alle Register-Adressen in der Datei `pozyx_definitions.h` definiert.
