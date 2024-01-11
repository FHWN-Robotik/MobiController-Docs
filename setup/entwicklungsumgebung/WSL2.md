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

{: .note}
Die Installation wurde anhand [ROS2 Humble](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html) durchgeführt.

### Setup Sources

```bash
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

{: .note}
Falls hier ein Problem mit dem Key aufgetreten ist, die nächsten zwei Zeilen ausführen und dann nochmals mit den oberen zwei beginnen und weiter machen.
  
### ROS2 packages installieren

```bash
sudo apt update
sudo apt upgrade
```

Je nachdem welche Installation gewünscht ist, eines davon ausführen:

+ ``sudo apt install ros-humble-desktop``

+ ``sudo apt install ros-humble-ros-base``

+ ``sudo apt install ros-dev-tools``

### Testen mit dem *talker-listener*

```bash
source /opt/ros/humble/setup.bash
```

Diese Zeile muss bei jedem neuen Terminal-Fenster ausgeführt werden, damit das nicht immer ausgeführt werden muss, diesen Befehl ausführen.

```bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
```

Danach einmalig ein neues Terminal öffnen, damit die Änderung übernommen wird.

Anschließend den *talker* starten.

```bash
ros2 run demo_nodes_cpp talker
```

Um das Programm zu stoppen, *SRTG+C* drücken.

Ergebnis:

![alt text]({{site.url}}/assets/imgs/wsl2/img3.jpg)

Danach ein neues Fenster öffnen und den listener ausführen.

```bash
ros2 run demo_nodes_cpp listener
```

Ergebnis:

![alt text]({{site.url}}/assets/imgs/wsl2/img4.jpg)

Damit der Listener von Anfang an zuhören kann, muss sie als erstes gestartet werden.

---
**Gratulation  ROS2 wurde erfolgreich installiert!**
