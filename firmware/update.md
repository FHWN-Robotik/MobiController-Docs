---
layout: default
title: Firmware Update
parent: Mobi Firmware
---

# Firmware Update
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Um die Firmware des SMT32 des Hardware Controllers zu aktualliesiern kann der [MobiController-Firmware-Updater](https://github.com/FHWN-Robotik/MobiController-Firmware-Updater) verwendet werden.
Auf dieser Seite wird die Verwendung des *Updaters* erklärt.
Die Installation ist [hier]({{site.url}}/setup/mobi/image_erstellen.html#firmware-updater) zu finden.

## Automatisches Update

Um ein automatisches Update der Firmware durchzuführen, muss lediglich folgender Befehl ausgeführt werden.

```bash
python3 ~/software/MobiController-Firmware-Updater/src/updater.py
```

Die Firmware wird nach dem Bestätigen der Meldung `Do you want to update? [y/N]` mittels `y` und `[Enter]` automatisch installiert.

## Manuelles Update

Der Updater ermöglicht es auch mittels einer lokalen `.bin` Datei zu updaten. Hierzu kann folgender Befehl verwendet werden.

```bash
python3 ~/software/MobiController-Firmware-Updater/src/updater.py -b <Firmware Pfad>
```

## Alle Funktionen des Updaters

Alle Funktionen und die Verwendung des Updaters kann mittels folgendem Befehl angezeigt werden.

```bash
python3 ~/software/MobiController-Firmware-Updater/src/updater.py --help
```

```bash
usage: updater.py [-h] [-b BINARY]

Update the firmware of the MobiController STM32.

options:
  -h, --help            show this help message and exit
  -b BINARY, --binary BINARY
                        Flash a custom .bin file, instead of downloading it from GitHub.
```
