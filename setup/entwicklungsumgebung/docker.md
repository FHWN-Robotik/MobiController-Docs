---
layout: default
title: Docker
parent: Entwicklungsumgebung
grand_parent: Setup
---

# Docker
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Eine einfache Methode eine ROS2 Entwicklungsumgebung zu erstellen ist mithilfe eines Docker Containers.

Um Docker verwenden zu können, muss der Docker-Agent installiert sein.
Hierzu siehe die [offizielle Dokumentation](https://www.docker.com/products/docker-desktop) für Docker-Desktop.

## ROS2 Docker Container

{: .note}
Das in diesm Abschnitt verwendete Script funktioniert aktuell nur unter Linux und MacOS.
Windows Nutzer können dennoch den Devcontainer verwenden. Siehe Abschnitt [VS Code Devcontainer](#vs-code-devcontainer)

Ein fertiges ROS2 Humble Dockerimage ist [hier](https://github.com/Flo2410/ros2-docker) zu finden.

1. Herunterladen

    ```bash
    git clone https://github.com/Flo2410/ros2-docker.git
    ```

2. In das Verzeichnis wechseln

    ```bash
    cd ros2-docker
    ```

3. Das Script ausführen

    ```bash
    ./ros2-docker.sh
    ```

    Dies lädt automatisch das Docker Image herunter und startet einen Container mit diesem.

## VS Code Devcontainer
