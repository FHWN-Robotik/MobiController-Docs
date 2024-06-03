---
layout: default
title: Power Manager
grand_parent: Firmware
parent: Overview
---

# Power Manager
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der *Power Manager* ist für das Messen der Batteriespannung mittels ADC zuständig.
Ebenfalls ermöglicht er es die Stromversorgung des LED-Streifens sowie des Pozyx Tags zu schalten.
Des Weiteren, ist es der *Power Manager* der die Batteriespannung überprüft und die Niederspannungswarnung auslöst.

Der *Power Manager* ist in den Dateien `power_manager.{c,h}` definiert.

## Defines

Der *Power Manager* definiert die minimale und maximale Batteriespannung wie folgt.

```
#define BAT_MIN_VOLTAGE 11.1
#define BAT_MAX_VOLTAGE 13.0
```
