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

ℹ️ Hinweis

Das Skript installiert benötigte Pakete und richtet die Umgebung automatisch ein.
Benutzung auf eigene Verantwortung.
