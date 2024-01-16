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

Wenn das Gegenteil gewünscht ist, siehe [ROS Domain]({{site.url}}/ros2/domain.html).

## Localhost Only

Um die Kommunikation mit anderen Systemen im Netzwerk zu deaktivieren, kann der *localhost only* Modus aktiviert werden.

Der `localhost only` Modus kann dauerhaft aktiviert werden, indem die Datei `~/.bashrc` in einem beliebigen Texteditor geöffnet wird und folgende Zeile am Ende hinzufügt oder bearbeitet wird.

```bash
export ROS_LOCALHOST_ONLY=1
```

Um den *localhost only* Modus zu deaktivieren, muss `ROS_LOCALHOST_ONLY` in der obigen Zeile auf `0` gesetzt werden.
