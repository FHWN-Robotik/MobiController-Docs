---

layout: default
title: ROS Domain - neu
grand_parent: Tutorials
parent: ROS 2
nav_order: 1
------------

# ROS 2 Netzwerk / Discovery

{: .no_toc }

## Inhalt

{: .no_toc .text-delta }

1. TOC
   {:toc}

---

## Übersicht

ROS 2 verwendet zur Kommunikation zwischen Nodes ein Discovery-Verfahren. Dadurch können sich ROS-2-Nodes im Netzwerk gegenseitig finden und anschließend Topics, Services und Actions miteinander austauschen.

Für den Betrieb des Mobi kann es sinnvoll sein, die automatische Discovery einzuschränken und bestimmte Geräte explizit als Discovery-Peers festzulegen.

In diesem Tutorial wird gezeigt, wie die ROS-2-Netzwerkkonfiguration über Umgebungsvariablen angepasst und dauerhaft gespeichert werden kann.

> **Hinweis:** Alle Rechner, die miteinander über ROS 2 kommunizieren sollen, müssen passend konfiguriert sein.

---

## 1. ROS 2 Domain ID setzen

Über `ROS_DOMAIN_ID` wird festgelegt, zu welcher ROS-2-Domain ein Node gehört.

Nodes mit derselben Domain ID können miteinander kommunizieren, sofern die Netzwerk- und Discovery-Konfiguration dies erlaubt.

```bash
export ROS_DOMAIN_ID=0
```

Für den Mobi wird beispielsweise die Domain ID `0` verwendet.

Die aktuell gesetzte Domain ID kann mit folgendem Befehl überprüft werden:

```bash
echo $ROS_DOMAIN_ID
```

---

## 2. Automatische Discovery auf den lokalen Rechner beschränken

Mit `ROS_AUTOMATIC_DISCOVERY_RANGE` kann festgelegt werden, in welchem Bereich automatisch nach anderen ROS-2-Nodes gesucht wird.

Mit:

```bash
export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
```

wird die automatische Discovery auf den lokalen Rechner beschränkt.

Dadurch werden ROS-2-Nodes auf anderen Rechnern nicht automatisch über die normale Discovery gefunden.

---

## 3. Statische ROS-2-Peers definieren

Wenn trotz eingeschränkter automatischer Discovery mit einem anderen Rechner kommuniziert werden soll, können dessen Adresse bzw. Hostname als statische Peers angegeben werden.

Beispiel:

```bash
export ROS_STATIC_PEERS=10.94.160.10
```

Mehrere Peers können mit `;` getrennt angegeben werden:

```bash
export ROS_STATIC_PEERS="10.94.160.10;10.94.160.20"
```

Damit können gezielt bestimmte Geräte für die ROS-2-Discovery angegeben werden.

> **Hinweis:** Die angegebenen IP-Adressen bzw. Hostnamen müssen von dem jeweiligen Rechner aus erreichbar sein.

---

## 4. Beispielkonfiguration für den Mobi

Eine mögliche Konfiguration für einen Rechner, der lokal arbeitet und zusätzlich einen bestimmten Rechner im Netzwerk als ROS-2-Peer verwenden soll, sieht beispielsweise so aus:

```bash
export ROS_DOMAIN_ID=0
export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
export ROS_STATIC_PEERS="10.94.160.[51-59]"
```

Die genaue IP-Adresse des Peers muss entsprechend der verwendeten Mobi-Netzwerkkonfiguration angepasst werden.

---

## 5. Einstellungen dauerhaft speichern

Die Umgebungsvariablen gelten standardmäßig nur für die aktuelle Shell.

Damit die Einstellungen bei jedem neuen Terminal automatisch geladen werden, können sie in der Datei `~/.bashrc` eingetragen werden:

```bash
echo 'export ROS_DOMAIN_ID=0' >> ~/.bashrc
echo 'export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST' >> ~/.bashrc
echo 'export ROS_STATIC_PEERS="10.94.160.[51-59]"' >> ~/.bashrc
```

Anschließend muss die `.bashrc` neu geladen werden:

```bash
source ~/.bashrc
```

Alternativ kann ein neues Terminal geöffnet werden.

---

## 6. Konfiguration überprüfen

Nach dem Setzen der Variablen kann überprüft werden, ob die Werte korrekt übernommen wurden:

```bash
echo $ROS_DOMAIN_ID
echo $ROS_AUTOMATIC_DISCOVERY_RANGE
echo $ROS_STATIC_PEERS
```

Bei der Beispielkonfiguration sollte die Ausgabe ungefähr so aussehen:

```text
0
LOCALHOST
10.94.160.[51-59]
```

---

## 7. ROS-2-Kommunikation testen

Nachdem die Netzwerkkonfiguration gesetzt wurde, kann überprüft werden, ob die ROS-2-Nodes erreichbar sind.

Zunächst sollte der ROS-2-Workspace geladen werden:

```bash
source ~/ros2_ws/install/setup.bash
```

Anschließend können die aktuell sichtbaren Topics angezeigt werden:

```bash
ros2 topic list
```

Ebenso können die aktuell sichtbaren Nodes überprüft werden:

```bash
ros2 node list
```

Wenn die erwarteten Nodes bzw. Topics angezeigt werden, funktioniert die ROS-2-Discovery entsprechend der konfigurierten Netzwerkumgebung.

---

## 8. Häufige Probleme

### Keine Nodes oder Topics sichtbar

Wenn keine erwarteten Nodes oder Topics gefunden werden, sollten zunächst die gesetzten Umgebungsvariablen überprüft werden:

```bash
echo $ROS_DOMAIN_ID
echo $ROS_AUTOMATIC_DISCOVERY_RANGE
echo $ROS_STATIC_PEERS
```
falls die Umgebungsvariablen sichtbar sind und es noch immer nicht funktioniert, dann

```bash
ros2 daemon stop
```

```bash
ros2 daemon start
```

Insbesondere muss auf den beteiligten Rechnern die gleiche `ROS_DOMAIN_ID` verwendet werden.

### Verbindung zu einem anderen Rechner funktioniert nicht

Überprüfen, ob der konfigurierte Peer erreichbar ist:

```bash
ping 192.168.0.1
```

Falls der Peer über einen Hostnamen angegeben wurde, kann zusätzlich die Namensauflösung überprüft werden.

Außerdem sollte kontrolliert werden, ob auf beiden Rechnern die gewünschte ROS-2-Netzwerkkonfiguration aktiv ist.

---

## Weiterführende Informationen

Weitere Informationen zur ROS-2-Discovery und den verfügbaren Konfigurationsmöglichkeiten:

[ROS 2 – Improved Dynamic Discovery](https://docs.ros.org/en/iron/Tutorials/Advanced/Improved-Dynamic-Discovery.html)
