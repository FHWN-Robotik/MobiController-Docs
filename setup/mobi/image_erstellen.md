---
layout: default
title: Image Erstellen
parent: Mobi
grand_parent: Setup
---

# Erstellen des Raspberry Prebuilt Images
{: .no_toc }

{: .warning }
Dieser Abschnitt ist **nicht** für Studenten gedacht!

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Installation Ubuntu Mate

1. Download von Ubuntu Mate 22.04 [hier](https://ubuntu-mate.org/download/)

2. Flashen des Images auf eine SD-Karte, z. B. mit [balenaEtcher](https://www.balena.io/etcher)

3. SD-Karte in Raspberry stecken und Raspberry einschalten.

4. Dem Setupwizard folgen.

    - Username: mobi
    - Passwort: 1234567890
    - Hostname: mobi-setup

5. Installieren von Updates:

   ```bash  
   sudo apt update && sudo apt upgrade -y
   ```

6. Reboot

7. Alle nicht benötigten Pakete entfernen

   ```bash
   sudo apt autoremove
   ```

## SSH Setup

1. SSH aktivieren:

   ```bash
    sudo apt install openssh-server
   ```

   ```bash
   sudo systemctl enable ssh
   ```

2. Public Key Auth aktivieren
   Die Datei `/etc/ssh/sshd_cofig` als `root` öffnen und die Zeile

   ```bash
   #PubkeyAuthentication yes
   ```

   zu

   ```bash
   PubkeyAuthentication yes
   ```

   ändern.

## VNC Setup

1. VNC installieren:

   ```bash
   sudo apt install tigervnc-standalone-server
   ```

2. VNC Server einrichten:

   Die Datei `~/.vnc/xstartup` mit folgendem Inhalt erstellen

   ```bash
   #!/bin/sh

   # Start up the standard system desktop

   unset SESSION_MANAGER
   unset DBUS_SESSION_BUS_ADDRESS

   /usr/bin/mate-session

   [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
   [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
   x-window-manager &
   ```

   Und ausführbar machen

   ```bash
   chmod +x ~/.vnc/xstartup
   ```

3. VNC Service erstellen (für den Autostart)

   Die Datei `/etc/systemd/system/vncserver@.service` als `root` User anlegen und mit folgendem Inhalt befüllen:

   ```bash
   [Unit]
   Description=Start TigerVNC server at startup
   After=syslog.target network.target

   [Service]
   Type=forking
   User=mobi
   Group=mobi
   WorkingDirectory=/home/mobi

   PIDFile=/home/mobi/.vnc/%H:590%i.pid
   ExecStartPre=-/bin/sh -c "/usr/bin/vncserver -kill :%i > /dev/null 2>&1"
   ExecStart=/usr/bin/vncserver -depth 24 -geometry 1920x1080 -localhost no :%i
   ExecStop=/usr/bin/vncserver -kill :%i

   [Install]
   WantedBy=multi-user.target
   ```

   Anschließend den Service aktivieren und starten

   ```bash
   sudo systemctl daemon-reload
   ```

   ```bash
   sudo systemctl enable vncserver@1.service
   ```

   ```bash
   sudo systemctl start vncserver@1
   ```

   Um zu sehen, ob alles funktioniert hat

   ```bash
   sudo systemctl status vncserver@1
   ```

## Deaktivieren des Gastzugangs

1. Die Datei `/etc/lightdm/lightdm.conf.d/91-arctica-greeter-guest-session.conf` als `root` öffnen.
2. Die Option `allow-guest` auf `false` setzten.
3. Reboot

## User Berechtigungen einstellen

1. den User `mobi` der Gruppe `dialout` hinzufügen

   ```bash
   sudo usermod -aG dialout mobi
   ```

## Netzwerk fix

https://askubuntu.com/a/1010638

1. Datei `/etc/NetworkManager/dispatcher.d/90-fhwn-ping-router` erstellen
2. Folgendes in die Datei eintragen:

   ```bash
   #!/bin/bash

   IF=$1
   STATUS=$2

   if [ "$IF" == "wlan0" ]
   then
       case "$2" in
           up)
           # interface is up
           ping 10.94.160.1 -c 2
           ;;
           down)
           # interface will be down
           ;;
           pre-up)
           # interface will be up
           ;;
           post-down)
           # interface is down
           ;;
           *)
           ;;
       esac
   fi
   ```

3. Die Datei ausführbar machen

   ```bash
   chmod +x 90-fhwn-ping-router
   ```

## ROS 2 Installieren

Die offizielle Anleitung ist [hier](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html) zu finden.

1. Repository hinzufügen

   ```bash
   sudo apt update && sudo apt install curl -y
   ```

   ```bash
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key 
   -o /usr/share/keyrings/ros-archive-keyring.gpg
   ```

   ```bash
   echo "deb [arch=$(dpkg --print-architecture) 
   signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu 
   $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | 
   sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
   ```

   ```bash
   sudo apt update
   ```

2. ROS Installieren

   ```bash
   sudo apt install ros-humble-desktop -y
   ```

3. Installieren von ROS Devtools

   ```bash
   sudo apt install ros-dev-tools -y
   ```

4. Suppress python setuptool deprecation warning. Mehr [hier](https://github.com/ament/ament_cmake/issues/382#issuecomment-1528083515) und [hier](https://robotics.stackexchange.com/questions/24230/setuptoolsdeprecationwarning-in-ros2-humble/24349#24349)

   ```bash
   echo "PYTHONWARNINGS=\"ignore:setup.py install is deprecated::setuptools.command.install\";
   export PYTHONWARNINGS" >> ~/.bashrc
   ```

5. Sourcen des ROS Setup Files

   ```bash
   echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
   ```

   ```bash
   source ~/.bashrc
   ```

6. ENV überprüfen

   ```bash
   printenv | grep -i ROS
   ```

   Die ENV Variablen sollten folgende Werte haben:

   ```bash
   ROS_VERSION=2
   ROS_PYTHON_VERSION=3
   ROS_DISTRO=humble
   ```

## Erstellen des Images der SD-Karte

1. Pi herunterfahren und die SD-Karte herausnehmen
2. SD-Karte in Computer stecken
3. Laufwerk identifizieren

   ```bash
   sudo fdisk -l
   ```

4. SD-Karte kopieren

   ```bash
   sudo dd bs=4M if=/dev/sda of=PiImage.img status=progress
   ```

5. Image verkleinern

   Software [PiShrink](https://github.com/Drewsif/PiShrink) herunterladen.

   ```bash
   wget https://raw.githubusercontent.com/Drewsif/PiShrink/master/pishrink.sh && 
   chmod +x pishrink.sh
   ```

   PiShrink ausführen

   ```bash
   sudo ./pishrink.sh PiImage.img mobi-image.img
   ```
