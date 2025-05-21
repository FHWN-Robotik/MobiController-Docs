---
layout: default
title: Xbox Gamepad
grand_parent: Tutorials
parent: Gamepad
nav_order: 1
---

# Xbox Gamepad
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{: .note}
Schritte zum testen des Gamepads sind [hier]({{site.url}}/tutorials/gamepad/gamepad-node.html#testen-des-gamepads) zu finden.

## Einleitung

Um ein XBox gamepad in Linux verwenden zu können, muss der entsprechende Treiber installiert werden.
Dies wird hier erklärt. 

## Voraussetzungen

- Ein Xbox Gamepad.
- Ein Xbox Wireless Adapter.

## Installation Kernel Module

Um das Xbox Gamepad unter Linux verwenden zu können, muss zuerst ein Kernel Modul installiert werden.
Ebenfalls muss der Benutzer der passenden Gruppe zugewiesen werden.

### Voraussetzungen installieren

{: .note}
Der Befehl `nala` kann durch `apt` ersetzt werden, falls `nala` nicht vorhanden ist.

{: .warning}
Nach einem Kernel Update müssen die entsprechenden Header manuell nachinstalliert werden.
Dies wird im Abschnitt [Linux Kernel Header updaten/neu installieren](#linux-header-updatenneu-installieren) erklärt.

1. Zuerst müssen die "Prerequisites" installiert werden:

   ```bash
   sudo nala install dkms cabextract linux-headers-$(uname -r)
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

{: .source}
<https://github.com/medusalix/xone>

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

{: .source}
<https://stackoverflow.com/a/13220622/15692454>

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

## Fehler Beheben

Falls sich der Xbox Controller nicht mehr verbinden lässt können folgende Optionen helfen.

### Linux Header updaten/neu installieren

{: .note}
Der Befehl `nala` kann durch `apt` ersetzt werden, falls `nala` nicht vorhanden ist.

Nach einem Kernel update müssen die entsprechenden Header installiert werden.
Dazu muss volgender Befehel ausgeführt werden.

```bash
sudo nala install dkms cabextract linux-headers-$(uname -r)
```

Anschließend muss noch neugestartet werden.

``` bash
sudo reboot now
```

### xone Kernel Module updaten

Falls das Gamepad nach dem installieren der passenden Linux Header immer noch nicht funktionieren sollte,
kann noch das *xone* Kernel Module aktualliesiert werden.
Dauzu müssen folgende Schritte ausgeführt werden:

1. Xbox Gamepad und/oder Wireless Adapter abstecken.

2. Aktuell installierte Version entfernen.

   ```bash
   cd ~/software/xone
   sudo ./uninstall.sh
   ```

3. System Neustarten

   ```bash
   sudo reboot now
   ```

4. Repository updaten:

   ```bash
   cd ~/software && git pull
   ```

5. `xone` installieren:

   ```bash
   cd xone
   sudo ./install.sh --release
   ```

6. Firmware für den Wireless Adapter herunterladen:

   ```bash
   sudo xone-get-firmware.sh
   ```

7. Xbox Wireless Adapter anstecken und Gamepad einschalten.
