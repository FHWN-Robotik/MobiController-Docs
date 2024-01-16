---
layout: default
title: ROS Domain
parent: ROS2
has_children: false
---

# ROS Domain
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Es kann praktisch sein ROS *Nodes* auf mehreren Systemen auszuführen, zum Beispiel um die Bildverarbeitungsalgorythmen nicht auf dem Raspberry auszuführen. Damit die *Nodes* untereinander kommunizieren können, müssen sich alle Systeme in der gleichen ROS *Domain* befinden. Ebenfalls muss der *localhost only* Modus deaktiviert sein, siehe hierfür [ROS Localhost Only]({{site.url}}/ros2/localhost_only.html)

## ROS Domain ID

{: .source}
<https://docs.ros.org/en/humble/Concepts/Intermediate/About-Domain-ID.html>
<https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html#the-ros-domain-id-variable>

Die *Domain ID* kann einmalig oder dauerhaft gesetzt werden.

### Domain ID einmalig setzten

Die ROS Domain kann für die aktuelle Terminal-Session mit folgendem Befehl gesetzt werden.

```bash
export ROS_DOMAIN_ID=<ID>
```

Die *Domain ID* kann dabei zwischen `0` und `101` liegen. Der Standardwert ist `0`.
Im Falle der Mobis empfiehlt es sich die letzte Zahl der IP-Adresse als *Domain ID* zu verwenden. Zum Beispiel hat *Delta* die IP-Adresse `xxx.xxx.xxx.59`, daher wäre `ROS_DOMAIN_ID=59` empfohlen.

### Domain ID dauerhaft setzten

Um die *Domain ID* dauerhaft zu setzt, kann der obige Befehl der `.bashrc` hinzugefügt werden.
Dazu die Datei `~/.bashrc` in einem beliebigen Texteditor öffnen und folgende Zeile am Ende hinzufügen oder bearbeiten.

```bash
export ROS_DOMAIN_ID=<ID>
```
