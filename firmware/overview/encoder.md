---
layout: default
title: Encoder
grand_parent: Firmware
parent: Overview
---

# Encoder
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der Mobi hat je nach Antrieb zwei oder vier Motoren/Encoder.
Diese liefern zwei Signale wie auf dem Bild zu sehen.

![Encoder Signal]({{site.url}}/assets/imgs/firmware/encoder.png)

## Funktionsweise

Das *A* Signal der Encoder löst ein externes Interrupt (`HAL_GPIO_EXTI_Callback` in `interrupts.c`) mit aus.
Entsprechend des Pins, wird der Interrupt handler in `encoders.{c,h}` aufgerufen.
Dieser liest das *B* Signal aus und ändert den Zähler entsprechend der Drehrichtung.
