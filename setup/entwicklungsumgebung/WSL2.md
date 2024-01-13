---
layout: default
title: WSL2
parent: Entwicklungsumgebung
grand_parent: Setup
---

# WSL2
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Das Ziel ist die Installation von ROS2 auf ein Linux Betriebssystem mittels des *Windows-Subsystem für Linux* (WSL).

## WSL2 aktivieren

 1. *Windows-Start* Taste klicken.

 2. *Windows-Features aktivieren und deaktivieren* schreiben und ausführen.

 3. Im Fenster *Windows-Subsystem für Linux* und *VM-Plattform* aktivieren.

 4. *OK* klicken und das Fenster schließen.

![alt text]({{site.url}}/assets/imgs/wsl2/img1.jpg)

## Installation von Ubuntu 22.04

 1. *Windows-Start Taste* klicken.

 2. *Eingabeaufforderung* schreiben und ausführen.

 3. ``wsl --set-default-version 2``

 4. ``wsl --install -d Ubuntu-22.04`` eintippen.

 5. *Enter-Taste* drücken.

 6. Installation abwarten.

 7. Username eingeben.

 8. Password eingeben.

 9. FERTIG!

Mit ``wsl --list --verbose`` überprüfen, ob die Linux-Distribution auf WSL2 läuft.

## Installation von Windows Terminal (empfohlen)

Ermöglicht einen besseren Workflow mit ROS2.

 1. *Windows Terminal* in *Microsoft Store* suchen und installieren.

 2. *Windows Terminal* starten.

 3. Den Pfeil in der Tab-Leiste klicken.

 4. *Ubuntu 22.04 LTS* auswählen.

![alt text]({{site.url}}/assets/imgs/wsl2/img2.jpg)

## Installation von ROS2 Humble

Die Installationsanleitung für ROS ist [hier]({{site.url}}/setup/ros.html) zu finden.
