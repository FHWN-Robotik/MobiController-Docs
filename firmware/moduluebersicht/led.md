---
layout: default
title: LED-Streifen
grand_parent: Mobi Firmware
parent: Modulübersicht
---

# LED-Streifen
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Der LED-Streifen besteht aus 38 RGBW LEDs des Typs *SK6812*.
Der Treiber des LED-Streifens in `led_strip.{c,h}` verwendet die [STM32-ARGB-DMA](https://github.com/Crazy-Geeks/STM32-ARGB-DMA) library in `ARGB.{c,h}`.
Die Ansteuerung des LED-Streifens erfolgt mittels vordefinierter **Animationen**, welche vom Benutzer angepasst werden können.

## Funktionsweise

Die Animation wird alle $$10~ms$$ aktualisiert.
Das aktualisierren erfollgt mittels des *Timer 3* welcher ein `HAL_TIM_PeriodElapsedCallback` Interrupt auslöst.
Dieses ruft die Funktion `void led_strip_handle_timer_interrupt(led_strip_t *led_strip);` auf, in welcher die Animation aktualisiert wird.
Die Animationskonfiguration ist als ROS Service [mobi_interfaces/srv/SetLedStrip]({{site.url}}/ros2/mobi_interfaces.html#mobi_interfacessrvsetledstrip) definiert.

Die `uint8_t update_rate` ist ein Vielfaches von $$10~ms$$.
