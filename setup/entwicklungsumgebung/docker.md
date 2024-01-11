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

{: .warning}
Aktuell ist die Kommunikation zwischen dem Docker Container und dem Roboter nicht möglich.
Der Grund hierfür ist die Netzwerkisolation von Docker Desktop.

## Einleitung

Eine einfache Methode eine ROS2 Entwicklungsumgebung zu erstellen ist mithilfe eines Docker Containers.

Um Docker verwenden zu können, muss der Docker-Agent installiert sein.
Hierzu siehe die [offizielle Dokumentation](https://www.docker.com/products/docker-desktop) für Docker-Desktop.

## VS Code Dev-Container

Der Dev-Container ermöglicht es mit VS Code in einer ROS Umgebung arbeiten zu können.
Um diesen verwenden zu können müssen folgende Schritte ausgeführt werden:

1. Installieren der [Dev-Container](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VS Code Erweiterung.

2. Erstellen der Dev-Container Konfigurationsdatei:

    Hierfür muss im gewünschten ROS Workspace (z.B. `~/ros2_ws`) die Datei `.devcontainer/devcontainer.json` erstellt werden. Vorkonfigurierte Dateien können für [Windows](https://github.com/Flo2410/ros2-docker/blob/main/example_devcontainers/windows_devcontainer.json) und [Linux/Mac OS](https://github.com/Flo2410/ros2-docker/blob/main/example_devcontainers/linux_devcontainer.json) heruntergeladen werden.
    Für Windows ist diese auch nachstehend zu finden.

    {: .note}
    Mit der Umgebungsvariable `ROS_DOMAIN` kann die vom Roboter verwendete ROS Domain gesetzt werde.
    Dies ermöglicht die Kommunikation zischen dem Dev-Container und dem Roboter.

    ```jsonc
    {
      "image": "ghcr.io/flo2410/ros2-docker:latest",
      "remoteUser": "ros",
      "runArgs": [
        "--volume=/run/desktop/mnt/host/wslg/.X11-unix:/tmp/.X11-unix",
        "--volume=/run/desktop/mnt/host/wslg:/mnt/wslg",
        "--security-opt=apparmor:unconfined",
        "--security-opt=seccomp:unconfined",
        "--ipc=host",
        "--network=host",
        "--name=ros2-docker",
        "--hostname=ros2-docker"
        // "--device=/dev/ttyACM0" // This is how to mount a device
      ],
      "containerEnv": {
        "DISPLAY": ":0",
        "WAYLAND_DISPLAY": "wayland-0",
        "XDG_RUNTIME_DIR": "/mnt/wslg/runtime-dir",
        "PULSE_SERVER": "/mnt/wslg/PulseServer",
        "LIBGL_ALWAYS_SOFTWARE": "1", // Needed for software rendering of opengl
        "PYTHONWARNINGS": "ignore:setup.py install is deprecated::setuptools.command.install", // disabel deprecation warning
        "ROS_DOMAIN_ID": "0" // Set the ROS Domain used by the robot
      },
      "customizations": {
        "vscode": {
          "extensions": [
            "althack.ament-task-provider",
            "betwo.b2-catkin-tools",
            "DotJoshJohnson.xml",
            "ms-azuretools.vscode-docker",
            "ms-iot.vscode-ros",
            "ms-python.python",
            "ms-vscode.cpptools",
            "redhat.vscode-yaml",
            "smilerobotics.urdf",
            "streetsidesoftware.code-spell-checker",
            "twxs.cmake",
            "yzhang.markdown-all-in-one",
            "zachflower.uncrustify",
            "ms-vscode.cmake-tools"
          ]
        }
      }
    }
    ```

## ROS2 Docker Container Script

{: .warning}
Das in diesem Abschnitt verwendete Script funktioniert aktuell nur unter Linux und MacOS.
Windows Nutzer können dennoch den Dev-Container verwenden. Siehe Abschnitt [VS Code Dev-Container](#vs-code-dev-container)

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
