---
layout: default
title: Firmware Update
parent: Firmware
---

# Firmware Update
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Um die Firmware des SMT32 des Hardware Controllers zu aktualliesiern kann der *Updater* des [MobiController-Python](https://github.com/Flo2410/MobiController-Python) Repositories verwendet werden.
Auf dieser Seite wird die Installation und die Verwendung des *Updaters* erklärt.

## Installation

Zuerst muss das Repository heruntergeladen werden. Dazu muss folgender Befehl ausgeführt werden.

```bash
mkdir ~/software && cd ~/software
git pull https://github.com/Flo2410/MobiController-Python.git
cd MobiController-Python
```

Anschließend müssen die Requirements installiert werden.
Dazu müssen folgende Befehle ausgeführt werden:

```bash
pip install -r requirements.txt
sudo apt install dfu-util
```

## Automatisches Update

Um ein automatisches Update der Firmware durchzuführen, muss lediglich folgender Befehl ausgeführt werden.

```bash
python3 ~/software/MobiController-Python/updater.py
```

Ist ein Update verfügbar wird, dieses nach dem Bestätigen der Meldung `Do you want to update? [y/N]` mittels `y` und `[Enter]` automatisch installiert.

## Manuelles Update

Der Updater ermöglicht es auch mittels einer lokalen `.bin` Datei zu updaten. Hierzu kann folgender Befehl verwendet werden.

```bash
python3 ~/software/MobiController-Python/updater.py -b <Firmware Pfad>
```

## Alle Funktionen des Updaters

Alle Funktionen und die Verwendung des Updaters kann mittels folgendem Befehl angezeigt werden.

```bash
python3 ~/software/MobiController-Python/updater.py --help
```

```bash
usage: updater.py [-h] [-c] [-f] [-p PORT] [-b BINARY]

Update the firmware of the MobiController STM32.

options:
  -h, --help            show this help message and exit
  -c, --check           Only check the firmware version.
  -f, --force           Forcefully update the version.
  -p PORT, --port PORT  Select the port the controller ist connected to. Default: /dev/ttyACM0
  -b BINARY, --binary BINARY
                        Flash a custom .bin file, instead of downloading it from GitHub.
```
