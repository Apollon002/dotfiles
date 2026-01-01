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
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 1

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "tuigreet --time --remember --cmd 'uwsm start hyprland.desktop'"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "greeter"

[initial_session]
command = "uwsm start hyprland.desktop"
user = "jannik"
```
Hinweis

Das Skript installiert benötigte Pakete und richtet die Umgebung automatisch ein.
Benutzung auf eigene Verantwortung.
