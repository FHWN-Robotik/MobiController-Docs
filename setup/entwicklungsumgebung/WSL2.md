---
layout: default
title: WSL2
parent: Entwicklungsumgebung
grand_parent: Setup
---

# WSL2
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Einleitung

Das Ziel ist die Installation von ROS2 auf ein Linux Betriebssystem mittels des *Windows-Subsystem für Linux* (WSL).

<!-- TODO: Add img docs: https://www.xda-developers.com/how-back-up-restore-wsl/ -->

## Installation von Windows Terminal (empfohlen)

{: .source}
<https://learn.microsoft.com/de-at/windows/terminal/install>

Das Windows Terminal ermöglicht einen besseren Workflow als mit den herkömmlichen *cmd* Fenster.
Zur Installation müssen folgende Schritte ausgeführt werden.

1. Folgenden Link aufrufen <https://aka.ms/terminal>

2. Auf der sich öffnenden Seite oder Pop-up auf `Installieren` klicken.

3. Nach der Installation das Windows-Terminal öffnen und darin die *Einstellungen*.

4. *Windows-Terminal* als Standardterminalanwendung  auswählen.

![Settings Default Shell]({{site.url}}/assets/imgs/wsl2/settings-default-shell.png)

## WSL2 und Ubuntu 22.04 Installieren

{: .source}
<https://learn.microsoft.com/en-us/windows/wsl/install>

Um Ubuntu 22.04 auf dem *Windows Subsystem for Linux* (WSL) zu installieren müssen folgende Befehle ausgeführt werden.

1. Ein *PowerShell* Fenster öffnen.

2. Die WSL Version auf WSL2 fixieren.

   ```powershell
   wsl --set-default-version 2
   ```

3. WSL2 und Ubuntu 22.04 installieren.

   ```powershell
   wsl --install -d Ubuntu-22.04
   ```

4. Installation abwarten.

5. Username eingeben.

6. Password eingeben.

7. Überprüfen, ob die Linux-Distribution auf WSL2 läuft.

   ```powershell
   wsl --list --verbose
   ```

   Die Ausgabe sollte wie folgt aussehen.

   ```powershell
   NAME                   STATE           VERSION
   Ubuntu-22.04           Stopped         2
   ```

## Installation von ROS2 Humble

Die Installationsanleitung für ROS ist [hier]({{site.url}}/setup/ros.html) zu finden.

## Netzwerk fix für Windows

{: .source}
<https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking>
<https://github.com/microsoft/WSL/issues/10769#issuecomment-1815884540>

{: .warning}
Dies ist erst ab `Windows 11, Version 22H2, Build 22621.2359` möglich.
Systeme mit einer älteren Windows Version können daher leider nicht mit anderen ROS Systemen kommunizieren.

Um die ROS Kommunikation zwischen dem WSL und anderen Systemen zu ermöglichen muss das WSL noch entsprechend konfiguriert werden.

### WSL2 Networking Mode anpassen

Um die für ROS benötigte Multicast Kommunikation zu ermöglichen, muss die Netzwerkisolation des WSL deaktiviert werden.
Damit eingehende Verbindung funktionieren, muss die *Hyper-V* Firewall entsprechend konfiguriert werden.
Dazu müssen folgende Schritte ausgeführt werden.

1. Die Datei `%UserProfile%\.wslconfig` erstellen (oder bearbeiten, falls bereits vorhanden) und mit einem Texteditor öffnen.

   {: .note}
   `%UserProfile%` ist der Home-Ordner des Benutzers. Dieser ist in der Regel `C:\Users\<UserName>`.

2. Folgende Einstallungen in die `.wslconfig` Datei eintragen.

   ```text
   [wsl2]
   networkingMode=mirrored
   firewall=true
   ```

3. Anschließend muss noch die *Hyper-V* Firewall so konfiguriert werden, dass eingehende Verbindungen aus dem lokalen Netzwerk erlaubt werden.
   1. Ein *PowerShell* Fenster als **Administrator** öffnen.

   2. Folgenden Befehl ausführen.

   ```powershell
   New-NetFirewallHyperVRule `
   -DisplayName 'Allow All Inbound Traffic to WSL in Private Network' `
   -Name 'WSL Rule' `
   -Profiles Private `
   -Direction Inbound `
   -Action Allow `
   -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' `
   -Enabled True
   ```
