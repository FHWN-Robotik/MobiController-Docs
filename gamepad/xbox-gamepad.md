---
layout: default
title: Xbox Gamepad
parent: Gamepad
---

# Xbox Gamepad
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

In diesem Dokument wird erklärt wie ein Xbox Gamepad in ROS2 verwendet werden kann. Dieser published den Topic `/joy` mit dem Type `sensor_msgs/Joy`.

Um einen Xbox Gamepad mit Linux verwenden zu können müssen zwei Schritte durchgeführt werden:

1. Ein [Kernel Module installieren](#linux-kernel-module-installieren)
2. Eine [Node starten](#joy-node-starten)

## Voraussetzungen

- Ein `Mobi` mit `ROS2` Installation.
- Ein Xbox Gamepad.
- Ein Xbox Wireless Adapter.

## Installation Kernel Module

Um das Xbox Gamepad unter Linux verwenden zu können, muss zuerst ein Kernel Modul installiert werden.
Ebenfalls muss der Benutzer der passenden Gruppe zugewiesen werden.

### Voraussetzungen installieren

1. Zuerst müssen die "Prerequisites" installiert werden:

    ```bash
    sudo apt install dkms cabextract linux-headers-$(uname -r)
    ```

2. Anschließend muss der Raspberry einmal neu gestartet werden.

    ```bash
    sudo reboot
    ```

3. Einen Ordner für das Repository erstellen

    ```bash
    mkdir ~/software
    ```

### Linux Kernel Module installieren

> Quelle: [github.com/medusalix/xone](https://github.com/medusalix/xone)

1. Xbox Gamepad und/oder Wireless Adapter abstecken.

2. Repository herunterladen:

    ```bash
    cd ~/software && git clone https://github.com/medusalix/xone
    ```

3. `xone` installieren:

    ```bash
    cd xone
    sudo ./install.sh --release
    ```

4. Firmware für den Wireless Adapter herunterladen:

    ```bash
    sudo xone-get-firmware.sh
    ```

5. Xbox Wireless Adapter anstecken und Gamepad einschalten.

### Gruppe für Benutzer konfigurieren

> Quelle: [stackoverflow.com/a/13220622/15692454](https://stackoverflow.com/a/13220622/15692454)

1. Die Gruppe herausfinden:

    ```bash
    ls -l /dev/input/
    ```

    Die Ausgabe sollte wie folgt oder ähnlich aussehen:

    ```bash
    ...
    crw-rw---- 1 root input 13, 64 Aug 21 23:14 event0
    crw-rw---- 1 root input 13, 65 Aug 21 23:14 event1
    crw-rw---- 1 root input 13, 66 Aug 21 23:14 event2
    ...
    ```

    Jetzt die Gruppe notieren, welche für die `event*` angezeigt werden. In diesem Fall ist sie `input`.

2. Nun kann der Benutzer der Gruppe hinzugefügt werden. Dafür muss die Gruppe aus Schritt 1 in folgendem Befehl eingefügt werden:

    ```bash
    sudo usermod -aG GRUPPE $USER
    ```

## Joy Node starten

{: .note }
Vor dem Verwenden des Gamepads in ROS2 ist es empfehlenswert zu überprüfen ob dieses von Linux erkannt wird. Siehe Abschnitt "[Testen des Gamepads](#jstest-gtk)".

Um die Eingaben auf dem Gamepad in einem ROS Topic zu publishen kann das [joy](https://index.ros.org/p/joy/#humble) Package verwendet werden.

1. Verfügbare Gamepads auflisten:

    ```bash
    ros2 run joy joy_enumerate_devices
    ```

    Die Ausgabe sollte etwa wie folgt aussehen:

    ```bash
    Joystick Device ID : Joystick Device Name
    -----------------------------------------
                     0 : Xbox Series X Controller
    ```

2. Starten der Joy Node:

    Da der Standardwert der ID 0 ist, kann im obigen Fall die Node mit folgendem Befehl gestartet werden:

    ```bash
    ros2 run joy joy_node
    ```

    Ist die ID nicht 0, so kann mit folgendem Befehlt die ID angegeben werden:

    ```bash
    ros2 run joy joy_node --ros-args -p device_id:=DEVICE_ID
    ```

3. Nun kann der Topic ausgegeben werden:

    ```bash
    ros2 topic echo /joy
    ```

## Testen des Gamepads

Hier sind verschiedene Möglichkeiten das Gamepad zu testen.

### Jstest-gtk

Mit jstest-gtk kann die Funktion des Gamepads in Linux getestet werden.

1. jstest-gtk installieren:

    ```bash
    sudo apt install jstest-gtk
    ```

2. Gamepad anschließen.

3. Jstest-gtk öffnen:

    ```bash
    jstest-gtk
    ```

4. Das Gamepad mit doppelklick auswählen.

5. Tasten drücken und Sticks bewegen.

### ROS2 Joy Tester

> Quelle: [github.com/joshnewans/joy_tester](https://github.com/joshnewans/joy_tester)

Joy Tester ermöglicht es den `/joy` Topic grafisch anzuzeigen. So lässt sich die Funktion des Gamepads überprüfen.

1. In den `src` Ordner eines ROS2 Workspaces wechseln. z.B. mit:

    ```bash
    cd ~/ros2_ws/src
    ```

2. Joy Tester Node herunterladen:

    ```bash
    git clone https://github.com/joshnewans/joy_tester.git
    ```

3. Joy Tester starten:

    ```bash
    ros2 run joy_tester test_joy
    ```
