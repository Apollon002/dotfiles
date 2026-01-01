Dotfiles

This repository contains my personal dotfiles along with an installation script
to automatically configure a system using them.

Dependencies:
A working hyprland installation as well as curl and git.
```bash
sudo pacman -S curl
sudo pacman -S git
```

📥 Installation

1️⃣ Download the install script
```bash
curl -fsSL https://raw.githubusercontent.com/Apollon002/dotfiles/main/install.sh > install.sh
```

If you want to use a dotfiles alias:

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout

2️⃣ Run the installation script

After cloning, run the installation script WITHOUT root privileges:

./install.sh

🔐 Enable greetd Autologin

After running the script, enable autologin for greetd.
Noctalia Shell will handle authentication instead of greetd.

Edit the greetd config:

sudo nvim /etc/greetd/config.toml


Example configuration:
```
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --cmd 'uwsm start hyprland.desktop'"
user = "greeter"

[initial_session]
command = "uwsm start hyprland.desktop"
user = "USERNAME"
```
Replace USERNAME with your actual system username.

⚠️ Notice

The script installs required packages and sets up the environment automatically.
Use at your own risk. If you encounter issues, review the script and configuration.
