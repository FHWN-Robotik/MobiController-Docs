---
layout: default
title: Motor Controller
grand_parent: Mobi Firmware
parent: Modulübersicht
---

# Motor Controller
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der Motorcontroller ist im Chassis des Roboters verbaut und wird mittels CAN-Bus angesteuert.
Um die Ansteuerung in der Firmware zu erleichtern, stellt die `canlib.{c,h}` Helferfunktionen zur verfügung.

## Funktionsweise

Die Funktion `HAL_StatusTypeDef canlib_drive(canlib_t *can, int16_t vx, int16_t vy, int16_t vphi);` wird verwendet um dem Motorcontroller anzusteuern.
Diese wandlet die übergebenen Werte, welche in $$mm/s$$ sind, in die vom Motorcontroller erwarteten Werte um.
Die Formel lautet hierfür, wie im Datenblatt beschrieben, wie folgt.

$$ v = 0.0001 * value $$

Dabei ist $$v$$ die Geschwindigkeit in $$m/s$$ und $$value$$ der Wert der an den Motorcontroller gesendet wird.
Die Formel is wir folgt in der Firmware implementirt.

$$ value = v * 10$$

Dabei ist $$v$$ in $$mm/s$$.

Ebenfalls speicert die Funktion den Zeitpunkt des Sendens ab, dies ermöglicht, dass der Roboter nach einer Sekunde ohne Fahrbefehl stehen bleibt.

## Defines

Die *canlib* definiert lediglich die ID des CAN-Frames `move laterally` wie diese im Datenblatt angegeben ist.

```
#define CANLIB_MOVE_LATERALLY 0x00002A01
```
