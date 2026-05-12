---
layout: default
title: Verwenden des Prebuild Images
parent: Mobi Image
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

5. ROS Domain setzen

    {: .note}
    Mehr Informationen sind [hier]({{site.url}}/ros2/domain.html) zu finden.

   Hierzu in der `~/.bashrc` Datei die folgende Zeile entsprechend anpassen.

   ```bash
   export ROS_DOMAIN_ID=0
   ```

6. Reboot

   ```bash
   sudo reboot
   ```

## SSH mit Public Key Authentifikation

{: .note }
Die folgenden Schritte werden auf den Labor-PCs ausgeführt (nicht auf dem Raspi).

1. **SSH-Key-Pair generieren** (bei „Enter passphrase:“ einfach Enter drücken, keine Passphrase eingeben):

   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/id_mobi
   ```

2. **SSH-Konfiguration anpassen**

   ```bash
   nano ~/.ssh/config
   ```

   Folgenden Inhalt in die Datei einfügen; dabei `xxxxxxxxx` durch den Namen des Mobis (zB `omega`) ersetzen, und `yyy` durch den entsprechenden Teil der IP-Adresse des Mobi:

   ```
   Host mobi-xxxxxxxxx
     HostName 10.94.160.yyy
     User mobi
     IdentityFile ~/.ssh/id_mobi
   ```

3. **Verbindung (mit Passwort) testen:**

   ```bash
   ssh mobi-xxxxxxxx
   ```

   Beim ersten Verbinden erscheint eine Warnung:

   ```
   The authenticity of host … can't be established.
   …
   Are you sure you want to continue connecting (yes/no/[fingerprint])?
   ```

   Diese Warnung mit Enter bestätigen, anschließend das Passwort eingeben. Danach sollte die Willkommensmeldung des Mobi angezeigt werden.

   Mit `exit` die Verbindung wieder beenden.


4. **SSH-Key auf den Mobi kopieren:**

   ```bash
   ssh-copy-id -i ~/.ssh/id_mobi mobi-xxxxxxxx
   ```

   (Auch hier `xxxxxxxx` durch Namen des Mobi ersetzen.)

5. **Verbindung ohne Passwort testen:**

   ```bash
   ssh mobi-xxxxxxxxx
   ```

   Die Willkommensmeldung sollte erscheinen, ohne dass ein Passwort eingegeben werden muss.


## Remote Development mit VS Code

1. VS Code Extension [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) installieren
2. Befehl ausführen (<kbd>F1</kbd>): `Remote-SSH: Connect to Host…` und `mobi-xxxxxxxxx` auswählen
3. „Open Folder“ anklicken und `/home/mobi` auswählen.

Die Sidebar auf der linken Seite zeigt jetzt den Inhalt des Homedirectories auf dem Raspi an. Dateien können von dort direkt geöffnet, bearbeitet, gespeichert etc. werden.

Über den Befehl `Terminal: Create new Terminal` kann ein Terminalfenster geöffnet werden, dessen Shell ebenfalls direkt auf dem Raspi läuft (die SSH-Verbindung muss also nicht manuell aufgebaut werden).


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
