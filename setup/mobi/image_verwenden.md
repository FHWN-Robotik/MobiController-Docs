---
layout: default
title: Verwenden des Prebuild Images
parent: Mobi
grand_parent: Setup
---

# Verwenden des Prebuild Images
{: .no_toc }

## Inhalt
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Installation

1. Image vom Server Herunterladen
2. Flashen des Images auf eine SD-Karte, z. B. mit [balenaEtcher](https://www.balena.io/etcher)
3. SD-Karte in Raspberry stecken und Raspberry einschalten.

## Post-Installation

{: .note}
`xx` ist ein Platzhalter für den Namen oder die letzten beiden Zahlen der IP des Mobis, je nach Kontext.

1. Hostname setzen:

   Zuerst muss der Hostname mittels der `hostnamectl` geändert werden.

   ```bash
   sudo hostnamectl set-hostname mobi-xx
   ```

   Anschließend muss noch in der `/etc/hosts` Datei der Hostname angepasst werden.

   ```diff
   - 127.0.1.1       mobi-template
   + 127.0.1.1       mobi-xx
   ```

2. Deaktivieren von cloud-init

   ```bash
   sudo sh -c 'echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-cloud-init.cfg'
   ```

3. In der Datei `/etc/cloud/cloud.cfg` den Wert `preserve_hostname` von `false` auf `true` ändern

   ```bash
   sudo nano /etc/cloud/cloud.cfg
   ```

4. DHCP deaktivieren und entsprechende IP-Adresse setzten.

   Die Datei `/etc/netplan/50-cloud-init.yaml` zu folgendem ändern. Das WLAN Passwort dabei unverändert lassen.

   ```diff
   network:
    version: 2
    wifis:
        renderer: networkd
        wlan0:
            access-points:
                Robotik Labor:
                    password: <redacted>
   -        dhcp4: true
   +        dhcp4: false
   +        addresses:
   +          - 10.94.160.xx/24
   +        gateway4: 10.94.160.1
   +        nameservers:
   +          addresses: [10.94.32.11, 10.30.0.11, 10.30.0.12]
            optional: true
   ```

5. ROS Domain setzte

    {: .note}
    Mehr Informationen sind [hier]({{site.url}}/ros2/domain.html) zu finden.

   Hierzu in der `~/.bashrc` Datei die folgende Zeile entsprechend anpassen.

   ```bash
   export ROS_DOMAIN_ID=0
   ```

6. Reboot

   ```bash
   suod reboot
   ```

## SSH mit Public Key Authentifikation

{: .note }
Alle folgenden Befehle lokal ausführen.

1. Key Pair generieren

   ```bash
   ssh-keygen -f ~/.ssh/mobi_ed25519 -t ed25519
   ```

2. SSH config bearbeiten

   Die lokale Datei ``~/.ssh/config`` öffnen und folgendes hinzufügen

   ```bash
   Host mobi-xx
     HostName 10.94.160.xx
     User mobi
     IdentityFile= ~/.ssh/mobi_ed25519
     PreferredAuthentications publickey
     Compression yes
     ForwardX11 yes
   ```

3. SSH Key auf den Mobi laden
  
      MacOS & Linux:

      ```bash
      ssh-copy-id -i ~/.ssh/mobi_ed25519.pub mobi@10.94.160.xx
      ```

      Windows:

      ```bash
      type $env:USERPROFILE\.ssh\mobi_ed25519.pub | ssh mobi@10.94.160.xx "cat >> .ssh/authorized_keys"
      ```
  
4. Die Verbindung testen

   Nun mit

   ```bash
   ssh mobi-xx
   ```

   auf dem Mobi verbinden. Es sollte dabei kein Passwort benötigt werden.

## Remote Development mit VS Code

1. VS Code Extension [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) installieren

## SSH X-Forwarding

1. Benötigte Software installieren:

   - Linux: Keine
   - Mac: [XQuartz](https://www.xquartz.org)
   - Windows: [Xming](https://www.straightrunning.com/XmingNotes/)

2. Mit SSH verbinden:

   {: .note}
   Folgender Befehl muss lokal ausgeführt werden.

   - `-X`: X-Forwarding
   - `-C`: Kompression

   ```bash
   ssh -XC mobi@10.94.160.xx
   ```

   Nach Folgen des Abschnittes [SSH mit Public Key Authentifikation](#ssh-mit-public-key-authentifikation) kann auch folgender Befehl verwendet werden:

   ```bash
   ssh mobi-xx
   ```
