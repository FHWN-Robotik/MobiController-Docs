---
layout: default
title: ROS2 (Humble) Installation
parent: Setup
has_children: false
---

# ROS2 (Humble) Installation
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Hier wird die Installation von ROS2 Humble erklärt.
Für mehr Informationen siehe die [offizielle Dokumentation](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html).

## Installation

{: .note}
Der Befehl `nala` kann durch `apt` ersetzt werden, falls `nala` nicht vorhanden ist.

### Sicherstellen, dass das [Ubuntu Universe repository](https://help.ubuntu.com/community/Repositories/Ubuntu) aktiviert ist

```bash
sudo nala install software-properties-common
sudo add-apt-repository universe
```

### Repository hinzufügen

```bash
sudo nala update && sudo nala install curl -y
```

```bash
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
```

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```

{: .note}
Falls hier ein Problem mit dem Key aufgetreten ist, die nächste Zeile ausführen und dann nochmals mit den oberen zwei beginnen und weiter machen.
  
```bash
sudo nala update
```

### ROS Installieren

  Einen der folgenden Befehle ausführen, um das gewünschte ROS Package zu installieren.

  1. Desktop Installation (Empfohlen): ROS, RViz, Demos, Tutorials.

      ```bash
      sudo nala install ros-humble-desktop -y
      ```

  2. ROS-Base Installation (Bare Bones): Communication Libraries, Message Packages, Command line Tools. Keine GUI Tools.

      ```bash
      sudo nala install ros-humble-ros-base -y
      ```

### Installieren von ROS Devtools

```bash
sudo nala install ros-dev-tools -y
```

### Unterdrücken des Python *setuptool deprecation warning*

{: .source}
<https://github.com/ament/ament_cmake/issues/382#issuecomment-1528083515>
[https://robotics.stackexchange.com/questions/...](https://robotics.stackexchange.com/questions/24230/setuptoolsdeprecationwarning-in-ros2-humble/24349#24349)

```bash
echo "PYTHONWARNINGS=\"ignore:setup.py install is deprecated::setuptools.command.install\";
export PYTHONWARNINGS" >> ~/.bashrc
```

## `~/.bashrc` Einstellungen

Folgende Zeilen am Ende der `~/.bashrc` hinzufügen.

```bash
export ROS_LOCALHOST_ONLY=0
export ROS_DOMAIN_ID=0
export XRCE_DOMAIN_ID_OVERRIDE=${ROS_DOMAIN_ID} # micro-ros agent domain id override
export RMW_IMPLEMENTATION=rmw_fastrtps_cpp

source /opt/ros/humble/setup.bash
```

```bash
source ~/.bashrc
```

## ENV überprüfen

```bash
printenv | grep ROS
```

Die ENV Variablen sollten folgende Werte haben:

```bash
ROS_VERSION=2
ROS_PYTHON_VERSION=3
ROS_DISTRO=humble
```
