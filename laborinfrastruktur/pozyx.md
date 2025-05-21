---
title: Pozyx
layout: home
nav_order: 2
parent: Labor-Infrastruktur
---

# Pozyx
{: .no_toc }

 [Pozyx](www.pozyx.io) ist ein System für Realtime Location Tracking. Das Robotik-Labor benutzt die „Creator“-Produktlinie: <https://docs.pozyx.io/creator/getting-started>

## Inhalt
{: .no_toc }

1. TOC
{:toc}

---

## Anchors

Im Labor sind fünf Pozyx-Anchors fix an den Wänden montiert. Die Positionen dieser Anchors wurden vermessen und im Pozyx-Setup für das Labor eingetragen.

{: .note}
Die Anchors sind normalerweise abgesteckt und müssen vor Verwendung des Pozyx-Systems erst mit dem Stromnetz verbunden werden.

## Tags

Pozyx-Tags sind mobile Komponenten, deren Position innerhalb des Robotik-Labors getrackt werden kann:

![Pozyx-Tag]({{site.url}}/assets/imgs/robotiklabor/pozyx_tag.jpg)

Tags benötigen ein USB-Kabel, das jedoch nur zur Stromversorgung dient – grundsätzlich funktionieren die Tags autonom.

{: .note}
Ausnahme: Ein Tag muss via USB mit jenem Computer verbunden sein, auf dem die Pozyx-Controller-Applikation läuft.

In jedem Mobi ist ein Pozyx-Tag eingebaut.


## Controller-Applikation

Die Applikation **„Pozyx Creator Controller“** ist auf dem Referenten-PC installiert. Um das Pozyx-System verwenden zu können, muss diese Applikation gestartet werden, und ein (beliebiges) Pozyx-Tag muss via USB mit diesem PC verbunden sein.


## Visualisierung

Unter <https://app.pozyx.io> ist ein Webinterface verfügbar, in dem Positionen der Anchors und Tags live visualisiert werden (Zugangsdaten werden in der jeweiligen Lehrveranstaltung bekanntgegeben):

![Pozyx-Visualisierung]({{site.url}}/assets/imgs/robotiklabor/pozyx_visualisierung.png)

Falls nicht alle Anchors / Tags angezeigt werden, kann „Discover devices“ verwendet werden, um die fehlenden Devices zu finden.


## Positionsdaten via MQTT

Die Pozyx-Applikation versendet die Positionsdaten aller aktiven Pozyx-Tags automatisch via MQTT. Diese Daten können zB mit der Applikation [MQTT-Explorer](https://mqtt-explorer.com/) visualisert werden. Connection-Info:

    Protocol: mqtt://
    Host: 10.94.160.107 (= Referenten-PC)
    Port: 1883
    Username / Passwort bleiben leer

Mit diesen Connection-Infos können die Positionsdaten z.B. auch in Matlab (Package [mqttclient](https://de.mathworks.com/help/icomm/ug/icomm.mqtt.client.html)) oder mit dem ROS2-Package [mqtt_client](https://github.com/ika-rwth-aachen/mqtt_client) verwendet werden.
