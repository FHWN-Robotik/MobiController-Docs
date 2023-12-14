---
layout: default
title: Das Kommunikations-Protokoll
parent: MIN Protokoll
---

# Das Kommunikations-Protokoll
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

<style>
table td:first-of-type {
    width: 25%;
}
</style>

## Einleitung

Das Kommunikations-Protokoll definiert die Kommunikation zwischen dem Raspberry und dem Hardware-Controller (folgend auch STM) des Mobis. Dabei ist dieses in zwei Gruppen geteilt. Die [Befehle (Commands)](#befehle-commands) stellen die Befehle dar welche vom Raspberry an den STM gesendet werden. Die [Antworten/Daten (Data)](#antwortendaten-data) hingegen, stellen die Antworten des STMs dar. Diese können entweder Daten (z.B. Sensordaten) oder Statuscodes sein.
Auf jeden, an den STM gesendeten, `Command` wird mit einer `Data` Nachricht geantwortet.
Das Kommunikations-Protokoll ist in Form einer `json` Datei definiert. Diese kann [hier](https://github.com/Flo2410/MobiController-Python/blob/main/protocol.json) abgerufen werden.

## Begriffserklärung

Hier ein paar Begriffe die im Folgenden die Erläuterung vereinfachen:

| Begriff | Erklärung |
| ------- | --------- |
| STM | Der Mikrocontroller welcher im Hardware-Controller verwendet wird. Wird folgend als Abkürzung für _Hardware-Controller_ verwendet. |
| Command | Ein Befehl welcher an den STM gesendet wird. |
| Data | Die Daten oder ein Statuscode mit welchem der STM antwortet. |
| MIN ID | Die eindeutige ID einer Nachricht, welche mittels dem MIN Protokoll übermittelt wird. Jede Command und Data Nachricht besitzt eine eindeutige MIN ID. |
| Payload | Die Payload bezeichnet die Daten welche mit einer Command oder Data Nachricht übertragen werden. |
| c_type | Der c_type ist der Datentyp in der Notation wie sie in der Programmiersprache `C` verwendet wird. Zum Beispiel `uint16_t` für einen 16-Bit unsigned Integer. |
| Bits | Bits bezeichnet die einzelnen Bits eines Wertes der Payload. Diese werden verwendet, um mittels eines Commands/Data Daten für mehrere Sensoren zu übertragen. Zum Beispiel bei den Ultraschallsensoren. |
| Codes | Codes sind ein Mapping der Bits eines `uint8_t` auf einen `string`. Dies wird in der Payload der Data Nachricht _command status_ verwendet. |

## Aufbau einer Command/Data Nachricht

### Aufbau einer Nachricht

| Attribut | Optional | Beschreibung |
| ------- | ------------ |
| min_id | Nein | Die eindeutige ID der Nachricht. |
| name | Nein | Der Name der Nachricht. |
| payload | Ja | Die Daten, die mittels der Nachricht übertragen werden. |

### Aufbau der Payload

Die Payload ist ein Array an Werten. Jeder Eintrag in diesem Array beschreibt einen Wert mittels folgender Attribute.

| Attribut | Optional | Beschreibung |
| ------- | ------------ |
| name | Nein | Der Name des Wertes. |
| c_type | Nein | Der Datentyp des Wertes in C/C++ Notation. |
| unit | Ja | Die SI-Einheit des Wertes. |
| bits | Ja | Ein Array welches die Kontrollbits bezeichnet. |
| codes | Ja | Ein Array aus Bezeichnungen möglicher Antwortcodes. |

## Beispiele

Hier ein paar Beispiele zur Verwendung des Protokolls.

### Abfrage der IMU mittels der cli.py

![Figure 1 - IMU Proto]({{site.url}}/assets/imgs/protocol/proto_cli.png "IMU Proto")

### Abfragen der IMU mittels minmon in Python

```python
from min.min import  MINFrame
from min.minmon import MINMonitor
from min.PayloadBuilder import PayloadBuilder

min_mon = MINMonitor(port="/dev/ttyACM0", loglevel=INFO)

builder = PayloadBuilder()
builder.append_uint8(0b00000011) # (select sensor): accelerometer und magnetometer
builder.append_uint16(1000) # (interval): alle 1000 ms

# imu 
min_mon.send_frame(0x20, builder.get_payload()) # senden der Payload an min_id 0x20 (32)
```

{% include_relative proto_docs_generated.md %}
