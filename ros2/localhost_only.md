---
layout: default
title: ROS Localhost Only
parent: ROS2
has_children: false
---

# ROS Localhost Only
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Manchmal kann es gewünscht sein die Kommunikation mit anderen Systemen zu deaktivieren. Dies kann mittels des *localhost only* Modus erreicht werden.

## Localhost Only

{: .source}
<https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html#the-ros-localhost-only-variable>

Um die Kommunikation mit anderen Systemen im Netzwerk zu deaktivieren, kann der *localhost only* Modus aktiviert werden.

Der `localhost only` Modus kann dauerhaft aktiviert werden, indem die Datei `~/.bashrc` in einem beliebigen Texteditor geöffnet wird und folgende Zeile am Ende hinzufügt oder bearbeitet wird.

```bash
export ROS_LOCALHOST_ONLY=1
```

Um den *localhost only* Modus zu deaktivieren, muss `ROS_LOCALHOST_ONLY` in der obigen Zeile auf `0` gesetzt werden.
