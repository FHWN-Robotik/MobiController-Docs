---
layout: default
title: Ultraschall Sensoren
grand_parent: Firmware
parent: Overview
---

# Ultraschall Sensoren
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der Mobi verwendet Ultraschallsensoren des Typs `HCSR04`.
Um eine Messung zu starten, müssen diese mit einem kurzen Puls ($$\geq10~\mu S$$) angesteuertert werden.
Die Enfernung zu  einem Hinderniss geben diese in Form eines Pulses zurück.
Dabei entspricht die Länge des Pulses der Zeit welche der Schall zum Hindernis und zurück benötigt hat.
Um die Pulslänge zu messen, wird in der Firmware die *Input Capture* Funktion des STM32 verwendet.
Der Treiber ist in den Datein `hcsr04.{c,h}` zu finden.

Im folgenden Bild ist in Gelb der *Trigger* Puls mit einer dauer von $$1~ms$$ und in Lila der *Echo* Puls zu sehen.

![Ultraschall Messung]({{site.url}}/assets/imgs/firmware/ultraschallmessung_crop.png)

## Funktionsweise

Zum Starten der Messung wird die Funktion `void hcsr04_measure(hcsr04_t *hcsr04);` aufgerufen.
Dise senden den *Trigger* Puls und aktiviert das *Input Capture* Interrupt des dem Ultraschallsensors zugewisenen Timers.
Für die Ultraschallsensoren werden *Timer 1* und *Timer 2* verwendet.

Sobald die steigende Flanke des *Echo* Pulses erkannt wird, wird das `HAL_TIM_IC_CaptureCallback` Interrupt in `interrupts.c` ausgeführt.
Dieses ruft dann wiederum den Interrupthandler mit dem entsprechenden Ultraschallsensor auf.
Dort wird der aktuelle Timer-Wert abgespeichert und die Polarität des *Input Captures* geändert.
Bei der fallenden Flanke wird die Pulslänge und daraus die Distanz berechnet.

Das `HAL_TIM_PeriodElapsedCallback` Interrupt in `main.c` wird bei jedem Timer-Overflow aufgerufen.
Im Fall der Ultraschallsensoren ermöglicht dies das Handhaben eines potienziellen Tiemer-Overflows beim Messen.
