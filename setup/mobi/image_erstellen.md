---
layout: default
title: Image Erstellen
parent: Mobi
grand_parent: Setup
---

# Erstellen des Raspberry Prebuilt Images
{: .no_toc }

{: .warning }
Dieser Abschnitt wird von Studenten in der Regel **nicht** benötigt!

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Installation Ubuntu Server 22.04 LTS

1. [Raspberry Pi Imager](https://www.raspberrypi.com/software/) herunterladen.

2. Gerät, Betriebssystem und Speichermedium auswählen.

    - Gerät: Raspberry Pi 4
    - Betriebssystem: Ubuntu Server 22.04 64-Bit (Other general-purpose OS > Ubuntu > Ubuntu Server 22.04.4 LTS (64-Bit))
    - Speichermedium: die SD-Karte auf die das Betriebssystem geflasht werden soll.

3. Auf *Next* drücken. Im folgenden Pop-up auf *Edit Settings* drücken.

   ![OS Customisation]({{site.url}}/assets/imgs/setup/mobi/os_customisation.png)

4. Folgende Einstellungen vornehmen:

    {: .note}
    Das Standard-Benutzer-Passwort ist: **1234567890**

    ![General Settings]({{site.url}}/assets/imgs/setup/mobi/os_general_settings.png)
    ![Services Settings]({{site.url}}/assets/imgs/setup/mobi/os_services_settings.png)
    ![Options Settings]({{site.url}}/assets/imgs/setup/mobi/os_options_settings.png)

5. Die Einstellungen speichern und im Pop-up aus Schritt 3 auf *yes* klicken.  
  Die Frage: *All existing data on 'Mass Storage Device' will be erased.
  Are you sure you want to continue?* mit *yes* bestätigen.

6. SD-Karte in Raspberry stecken und Raspberry einschalten.

7. Entweder Bildschirm und Tastatur anstecken oder über SSH verbinden.

8. Updates installieren:

   ```bash  
   sudo apt update && sudo apt upgrade -y
   ```

9. Reboot

10. Alle nicht benötigten Pakete entfernen

   ```bash
   sudo apt autoremove
   ```

## Software Installieren

### Nala Package Manager

{: .source}
<https://github.com/volitank/nala>

*Nala* ist ein Package Manager welcher *apt* ersetzt.
*Nala* bietet unter anderem eine übersichtlichere Ausgabe,
lädt Packages parallel herunter und ermöglicht es Schritte rückgängig zu machen.

1. Nala installieren

   ```bash
   sudo apt install nala
   ```

2. Nala Auto-Vervollständigung installieren

   ```bash
   nala --install-completion bash
   ```

3. Bashrc neu laden

   ```bash
   source ~/.bashrc
   ```

### Python

*Pyhton3* ist standardmäßig installiert, allerdings fehlt unter anderem *pip*.

1. *pip* installieren

   ```bash
   sudo nala install python3-pip
   ```

2. *python-is-python3* installieren

   ```bash
   sudo nala install python-is-python3
   ```

### Firmware Updater

Der Firmware Updater ermöglicht ein einfaches Aktualisieren der Firmware des Hardware-Controllers.

1. *dfu-util* installieren

   ```bash
   wget --directory-prefix ~/Downloads http://ports.ubuntu.com/ubuntu-ports/pool/universe/d/dfu-util/dfu-util_0.11-1_arm64.deb
   sudo nala install ~/Downloads/dfu-util_0.11-1_arm64.deb
   ```

2. Den `~/software` Ordner erstellen

   ```bash
   mkdir ~/software 
   cd ~/software
   ```

3. Download Firmware Updater

   ```bash
   git clone https://github.com/FHWN-Robotik/MobiController-Firmware-Updater.git
   ```

4. Python Abhängigkeiten installieren

   ```bash
   pip install -r requirements.txt
   ```

### ROS 2 Installieren

Die Installationsanleitung für ROS ist [hier]({{site.url}}/setup/ros.html) zu finden.

## Konfiguration

### SSH

1. Public Key Authentication aktivieren
   Die Datei `/etc/ssh/sshd_cofig` als `root` öffnen und die Zeile

   ```bash
   #PubkeyAuthentication yes
   ```

   zu

   ```bash
   PubkeyAuthentication yes
   ```

   ändern.

### Benutzer Berechtigungen

1. Den Benutzer `mobi` den Gruppen `dialout`, `video`, `input`, `plugdev` hinzufügen

   ```bash
   sudo usermod -aG dialout,video,input,plugdev mobi
   ```

### Udev Rules

#### STM32
Mittels der `udev` Regel wird der STM32 immer als `/dev/stm32usb` und das ST-Link als `/dev/stm32stlink` bereitgestellt.
Ebenfalls ermöglicht sie das Updaten der Firmware ohne *root* Berechtigungen.
Dies ist für den Firmware Updater notwendig.

1. Die Datei anlegen und öffnen

   ```bash
   sudo nano /etc/udev/rules.d/10-stm32-named-tty.rules
   ```

2. Folgenden Inhalt in die Datei `/etc/udev/rules.d/10-stm32-named-tty.rules` schreiben:

   ```text
   # STM32 Virtual Com Port
   ACTION=="add", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", SUBSYSTEM=="tty", SYMLINK+="stm32usb"
   
   # STM32 ST-Link
   ACTION=="add", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", SUBSYSTEM=="tty", SYMLINK+="stm32stlink"

   # DFU Access Rights
   ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666", TAG+="uaccess"
   ```

#### RP-LiDAR

Mit dieser `udev` Regel wird das RP-LiDAR immer als `/dev/rplidar` eingebunden.

1. Die Datei anlegen und öffnen

   ```bash
   sudo nano /etc/udev/rules.d/10-rplidar.rules
   ```

2. Folgenden Inhalt in die Datei `/etc/udev/rules.d/10-rplidar.rules` schreiben:

   ```text
   # RP-LiDAR
   KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666", SYMLINK+="rplidar"
   ```

### Automatische Updates deaktivieren

Um automatische Updates zu deaktivieren, folgenden Befehl ausführen:

```bash
sudo nala remove unattended-upgrades
```

### Custom SSH Banner

Dies ist nicht benötigt, macht es jedoch einfacher zu erkennen auf welchen *Mobi* man sich verbunden hat.

1. Standard Banner löschen

   ```bash
   sudo rm /etc/update-motd.d/*
   ```

2. Abhängigkeiten installieren

   ```bash
   sudo nala install figlet
   ```

3. Die Datei `/etc/update-motd.d/colors` erstellen und befüllen

   ```bash
   sudo nano /etc/update-motd.d/colors
   ```

   ```bash
   #!/bin/sh
   
   # Reset Colors
   NONE="\033[m"

   # Colors
   WHITE="\033[1;37m"
   GREEN="\033[1;32m"
   RED="\033[0;32;31m"
   YELLOW="\033[1;33m"
   BLUE="\033[34m"
   CYAN="\033[36m"
   LIGHT_GREEN="\033[1;32m"
   LIGHT_RED="\033[1;31m"

   # Bold
   BOLD="\033[1m"

   # Underline
   UNDERLINE="\033[4m"
   ```

4. Die Datei `/etc/update-motd.d/00-header` erstellen und befüllen

   ```bash
   sudo nano /etc/update-motd.d/00-header
   ```

   ```bash
   #!/bin/sh

   # Call the color file
   . /etc/update-motd.d/colors

   # Print the hostname with figlet
   printf "\n"$GREEN
   figlet $(hostname -s)
   printf $NONE
   ```

5. Die Datei `/etc/update-motd.d/01-banner` erstellen und befüllen

   ```bash
   sudo nano /etc/update-motd.d/01-banner
   ```

   ```bash
   #!/bin/sh

   # Call the color file
   . /etc/update-motd.d/colors

   # Print system info
   echo "$(lsb_release -is) $(lsb_release -rs)" $YELLOW "($(lsb_release -cs))" $NONE "($(uname -o)" "$(uname -r)" "$(uname -m))"
   printf "\n"
   ```

6. Die Datei `/etc/update-motd.d/02-sysinfo` erstellen und befüllen

   ```bash
   sudo nano /etc/update-motd.d/02-sysinfo
   ```

   ```bash
   #!/bin/bash

   # Call the color file
   . /etc/update-motd.d/colors

   # Process info
   proc=`cat /proc/cpuinfo | grep model | cut -c14- | sed -n "2 p"`
   # Remove spaces Before/After
   proc=$(echo "${proc}" | sed 's/^ *//g')
   # Get the number of cores
   cores=`cat /proc/cpuinfo | grep -i "^processor" | wc -l`
   # RAM/SWAP Free and Total
   memfree=`cat /proc/meminfo | grep MemFree | awk {'print $2'}`
   memtotal=`cat /proc/meminfo | grep MemTotal | awk {'print $2'}`
   swaptotal=`cat /proc/meminfo | grep SwapTotal | awk {'print $2 " " $3'}`
   percentfree=$((($memfree * 100)/$memtotal))
   # Uptime
   uptime=`uptime -p`
   # IP
   #ipaddr=`hostname -I | cut -d " " -f1`
   ipaddr=`hostname -I | sed -e "s/ /, /g"`
   # Get the number of running processes
   process=`ps ax | wc -l | tr -d " "`
   # Diskusage
   diskused=`df -h | grep "/dev/mmcblk0p2" | awk {'print $5 "% of " $2'}`

   # Get the loadavg
   read one five fifteen rest < /proc/loadavg

   # Displaying variables
   printf ""$LIGHT_GREEN
   printf "Processor   :"
   printf ""$NONE
   printf " $proc ($cores cores)"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "CPU         :"
   printf ""$NONE
   printf " $one (1min) / $five (5min) / $fifteen (15min)"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "RAM         :"
   printf ""$NONE
   printf " $(($memfree/1024)) MB or $percentfree%% Free / $(($memtotal/1024)) MB Total"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "Swap        :"
   printf ""$NONE
   printf " $swaptotal"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "Processes   :"
   printf ""$NONE
   printf " $process"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "Disk Usage  :"
   printf ""$NONE
   printf " $diskused"
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "IP Adresses :"
   printf ""$LIGHT_RED
   printf " $ipaddr"
   printf ""$NONE
   printf "\n"
   printf ""$LIGHT_GREEN
   printf "Uptime      :"
   printf ""$NONE
   printf " $uptime"
   printf "\n"
   printf "\n"
   ```

7. Die Datei `/etc/update-motd.d/03-upgrade` erstellen und befüllen

   ```bash
   sudo nano /etc/update-motd.d/03-upgrade
   ```

   ```bash
   #!/bin/bash

   # Call the color file
   . /etc/update-motd.d/colors

   # Check updates
   n=$(apt-get -qq --just-print dist-upgrade | cut -f 2 -d " " | sort -u | wc -l)
   if [[ $n -gt 0 ]]; then
       printf $LIGHT_RED
       printf "  You have %s packages waiting for upgrades." "$n"
       printf $NONE"\n\n"
   fi

   # Number of unnecessary packages to uninstall
   n=$(apt-get -qq --just-print autoremove | cut -f 2 -d " " | sort -u | wc -l)
   if [[ $n -gt 0 ]]; then
       printf $YELLOW
       printf "  You have %s packages that were automatically installed and are not needed anymore." "$n"
       printf $NONE"\n\n"
   fi
   ```

8. Die Datein ausführbar machen

   ```bash
   sudo chmod +x /etc/update-motd.d/*
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
