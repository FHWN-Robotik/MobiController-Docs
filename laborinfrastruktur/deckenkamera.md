---
title: Deckenkamera
layout: home
nav_order: 1
parent: Labor-Infrastruktur
---

# Deckenkamera

Es gibt zwei Möglichkeiten, auf die Deckenkamera zuzugreifen:

## Web-Interface

![Deckenkamera]({{site.url}}/assets/imgs/robotiklabor/deckenkamera_webinterface.png "Webinterface der Deckenkamera")

URL: <https://10.94.160.3> (Zugangsdaten werden in der jeweiligen Lehrveranstaltung bekanntgegeben).

{: .note}
**Zertifikatswarnung:** Die Deckenkamera benutzt ein self-signed TLS-Zertifikat. Beim Zugriff über den Browser kann daher eine Warnung wegen eines ungültigen bzw. unbekannten Zertifikats erscheinen. Diese Warnung kann ignoriert bzw. eine entsprechende Ausnahme für diese URL hinzugefügt werden.


## RTSP-Stream

Der RTSP-Stream beinhaltet nur die Bilddaten und kann in Applikationen wie Matlab (z.B. mit dem [ipcam-Package](https://de.mathworks.com/help/matlab/supportpkg/ipcamera.ipcam.html)) oder eigenen Programmen (in Python z.B. mit den Packages [opencv-python](https://pypi.org/project/opencv-python/) oder [rtsp](https://pypi.org/project/rtsp/)) verwendet werden.

URL: `rtsp://10.94.160.3:554/h264Preview_01_main` (Benutzername und Passwort werden in der jeweiligen Lehrveranstaltung bekanntgegeben)

Manche Clients benötigen Username und Passwort direkt in der URL, in diesem Fall hat die URL folgende Struktur: `rtsp://benutzername:passwort@10.94.160.3:554/h264Preview_01_main`
