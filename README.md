Dotfiles

Dieses Repository enthält meine persönlichen Dotfiles sowie ein Installationsskript,
um ein System automatisch damit zu konfigurieren.

📥 Installation

1️⃣ Repository als Bare-Repo klonen
git clone --bare https://github.com/Apollon002/dotfiles.git "$HOME/.dotfiles"


Falls du einen dotfiles-Alias nutzen möchtest:

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout

2️⃣ Installationsskript ausführen

Danach das Installskript mit Root-Rechten starten:

sudo ./install.sh

Autologin für greetd aktivieren:
Nach dem Ausführen des Skripts muss Autologin für greetd aktiviert werden, da die Passwortabfrage von Noctalia-Shell übernommen wird.

sudo nvim /etc/greetd/config.toml
```bash
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --cmd 'uwsm start hyprland.desktop'"
user = "greeter"

[initial_session]
command = "uwsm start hyprland.desktop"
user = "USERNAME"
```
Ändere USERNAME zu deinem Username!

Hinweis

Das Skript installiert benötigte Pakete und richtet die Umgebung automatisch ein.
Benutzung auf eigene Verantwortung.
