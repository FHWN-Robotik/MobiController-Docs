---
layout: default
title: Gamepad Node
grand_parent: Tutorials
parent: Gamepad
---

# Gamepad Node
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

In diesem Dokument wird erklärt wie ein Gamepad in ROS2 verwendet werden kann. Damit der Topic `/joy` mit dem Type `sensor_msgs/Joy`  gepublished werden kann.

{: .note}
Um einen Xbox Gamepad mit Linux verwenden zu können muss der [Treiber installiert]({{site.url}}/setup/xbox-gamepad.html) sein.
Auf dem Mobi ist dies berreits erledigt.

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

{: .note}
Der Befehl `nala` kann durch `apt` ersetzt werden, falls `nala` nicht vorhanden ist.

Mit jstest-gtk kann die Funktion des Gamepads in Linux getestet werden.

1. jstest-gtk installieren:

   ```bash
   sudo nala install jstest-gtk
   ```

2. Gamepad anschließen.

3. Jstest-gtk öffnen:

   ```bash
   jstest-gtk
   ```

4. Das Gamepad mit doppelklick auswählen.

5. Tasten drücken und Sticks bewegen.

### ROS2 Joy Tester

{: .source}
<https://github.com/joshnewans/joy_tester>>

Joy Tester ermöglicht es den `/joy` Topic grafisch anzuzeigen. Damit lässt sich die Funktion des Gamepads in ROS überprüfen.

1. In den `src` Ordner eines ROS2 Workspaces wechseln. z.B. mit:

   ```bash
   cd ~/ros2_ws/src
   ```

2. Joy Tester Node herunterladen:

   ```bash
   git clone https://github.com/joshnewans/joy_tester.git
   ```

3. Workspace builden

   ```bash
   cd ~/ros_ws
   colcon build
   ```

4. Joy Tester starten:

   ```bash
   ros2 run joy_tester test_joy
   ```
