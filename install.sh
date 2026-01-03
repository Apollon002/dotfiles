#!/usr/bin/bash

BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'

RED='\033[0;31m'
LIGHT_RED='\033[1;31m'

BLUE='\033[0;32m'
LIGHT_BLUE='\033[1;32m'

ORANGE='\033[0;33m'
YELLOW='\033[1;33m'

GREEN='\033[0;34m'
LIGHT_GREEN='\033[1;34m'

PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'

CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'

LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'

# Reset
NC='\033[0m'

printf "${RED}-----------------------------------------\n"
printf "Welcome to the Apollo-Dotfiles installer!\n"
printf "${RED}-----------------------------------------${NC}\n"

printf "${BLUE}Do you wish to install the dotfiles and all needed packages?${NC}\n"
select strictreply in "Yes" "No"; do
        relaxedreply=${strictreply:-$REPLY}
        case $relaxedreply in
        Yes | yes | y)
                sudo -v || exit 1
                printf "${GREEN}Starting installation...${NC}\n"
                sleep 3
                break
                ;;
        No | no | n) exit ;;
        *) exit ;;
        esac
done

cd $HOME
git clone --bare https://github.com/Apollon002/dotfiles.git "$HOME/.dotfiles"
dot() {
        /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
}

dot config --local status.showUntrackedFiles no

# Variable that contains used AUR helper
HELPER=

# check if AUR helper is installed
# if not, let user choose between paru and yay
if command -v paru >/dev/null 2>&1; then
        printf "${GREEN}Paru installation found. Continue with paru as package manager...${NC}\n"
        HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
        printf "${GREEN}Yay installation found. Continue with yay as packagage manager...${NC}\n"
        HELPER="yay"
else
        printf "${ORANGE}No AUR helper found${NC}\n"
        printf "${BLUE}Select your preferred AUR helper${NC}\n"
        select strictreply in "Paru" "Yay"; do
                relaxedreply=${strictreply:-$REPLY}
                case $relaxedreply in
                Paru | paru | p)
                        sudo pacman -S --needed base-devel git
                        git clone https://aur.archlinux.org/paru.git
                        (
                                cd paru || exit 1
                                makepkg -si
                        )
                        rm -rf paru
                        HELPER="paru"
                        printf "${GREEN}paru installation successful!${NC}\n"
                        break
                        ;;
                Yay | yay | y)
                        sudo pacman -S --needed git base-devel
                        git clone https://aur.archlinux.org/yay.git
                        (
                                cd yay || exit 1
                                makepkg -si
                        )
                        rm -rf yay
                        HELPER="yay"
                        printf "${GREEN}yay installation successful!${NC}\n"
                        break
                        ;;
                *)
                        printf "${ORANGE} Please select paru or yay.${NC}\n"
                        ;;
                esac
        done
fi

CORE_PKGS=(
        curl
        yazi
        7zip
        fish
        neovim
        unzip
        nodejs
        npm
        fzf
        sl
        cmatrix
        feh
        zathura
        zathura-pdf-mupdf
        mpv
        starship
        adw-gtk-theme
        nwg-look
        greetd
        greetd-tuigreet
        uwsm
        gnome-keyring
        jq
        hyprshot
        # needed for nvim
        imagemagick
        ripgrep
        fd
        # Noctalia Shell dependencies
        quickshell
        gpu-screen-recorder
        brightnessctl
        qt6-multimedia
        ddcutil
        cliphist
        matugen-git
        cava
        wlsunset
        xdg-desktop-portal
        python3
        evolution-data-server
        polkit-kde-agent
)

printf "${GREEN}Installing core packages...${NC}\n"
sleep 2
# Install core packages
"${HELPER}" -S --needed --noconfirm "${CORE_PKGS[@]}"
# Install mermaid-cli for lazyvim
npm install @mermaid-js/mermaid-cli
# Install noctalia-shell
printf "${GREEN}Installing noctalia-shell...${NC}\n"
mkdir -p ~/.config/quickshell/noctalia-shell && curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell

# Change default shell to fish
printf "${GREEN}Setting fish as default shell...${NC}\n"
chsh -s /usr/bin/fish

# set default applications
printf "${GREEN}Setting default applications...${NC}\n"
xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default feh.desktop image/jpeg
xdg-mime default feh.desktop image/png
xdg-mime default feh.desktop image/webp
xdg-mime default feh.desktop image/gif

# create wallpaper directory
printf "${GREEN}Creating wallpaper directory ~/Pictures/Wallpapers/...${NC}\n"
mkdir -p ~/Pictures/Wallpapers

# Install Fonts (Nerd Fonts Noto + FiraCode + Noto CJK Serif)
printf "${GREEN}starting to install fonts...${NC}\n"
(
        set -e

        FONT_DIR="$HOME/.local/share/fonts"
        TMP_DIR="$(mktemp -d)"

        mkdir -p "$FONT_DIR/Noto"

        cd "$TMP_DIR"

        echo "Downloading fonts…"
        curl -L -o Noto.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Noto.zip
        curl -L -o FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
        curl -L -o NotoSerifCJK.ttc https://github.com/googlefonts/noto-cjk/raw/main/Serif/Variable/OTC/NotoSerifCJK-VF.otf.ttc
        curl -L -o NotoColorEmoji.ttf https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf

        echo "Extracting fonts…"
        unzip -o Noto.zip -d "$FONT_DIR/Noto"
        unzip -o FiraCode.zip -d "$FONT_DIR/FiraCodeNerd"

        echo "Installing Noto CJK Serif…"
        mv NotoSerifCJK.ttc "$FONT_DIR/Noto/"

        echo "Installing Noto Emoji"
        mv NotoColorEmoji.ttf "$FONT_DIR/Noto"

        echo "Refreshing font cache…"
        fc-cache -fv

        echo "Fonts installed successfully."
)

# Install browser
BROWSERS=("Brave" "Chrome" "Chromium" "Firefox" "Librewolf" "Zen" "None")
INSTALL_BROWSER=
printf "${BLUE}Please select a browser to install${NC}\n"
select browser in "${BROWSERS[@]}"; do
        case "$browser" in
        "Brave")
                INSTALL_BROWSER=brave-bin
                break
                ;;
        "Chrome")
                INSTALL_BROWSER=google-chrome
                break
                ;;
        "Chromium")
                INSTALL_BROWSER=chromium
                break
                ;;
        "Firefox")
                INSTALL_BROWSER=firefox
                break
                ;;
        "Librewolf")
                INSTALL_BROWSER=librewolf
                break
                ;;
        "Zen")
                INSTALL_BROWSER=zen-browser-bin
                break
                ;;
        "None")
                printf "${ORANGE}no browser will we installed\n${BLUE}"
                break
                ;;
        *)
                echo "please choose a valid option"
                ;;
        esac
done

# install browser if user selected one from the list
if [ -n "$INSTALL_BROWSER" ]; then
        "${HELPER}" -S --needed --noconfirm "${INSTALL_BROWSER}"
fi

OPTIONAL_PKGS=(
        bitwarden
        man-db
        tldr
        texlive
        texlive-langgerman
        biber
        lazygit
        btop
        onlyoffice-bin
        cups
        spotify-launcher
        wget
        thunderbird
        visual-studio-code-bin
        vscodium
)

SELECTED_OPTIONALS=($(printf "%s\n" "${OPTIONAL_PKGS[@]}" | fzf --multi --prompt="Select optional packages > "))

if [ ${#SELECTED_OPTIONALS[@]} -gt 0 ]; then
        printf "${GREEN}Installing:\n"
        printf ' - %s\n' "${SELECTED_OPTIONALS[@]}"
        printf "${NC}"
        "${HELPER}" -S --needed --noconfirm "${SELECTED_OPTIONALS[@]}"
else
        printf "${GREEN}No optional packages selected!${NC}\n"
fi

sudo systemctl enable greetd.service
if "${HELPER}" -Q cups >/dev/null 2>&1; then
        sudo systemctl enable cups.service
fi

dot checkout -f

echo "# Put the programs you want to autostart in this file" >~/.config/hypr/core/autostart_local.conf
echo "# Put your monitor settings in this file" >~/.config/hypr/extra/monitors/local.conf
echo "# Put your window rules in this file" >~/.config/hypr/extra/wrules/user.conf

# set bars for noctalia shell
CONFIG="$HOME/.config/noctalia/settings.json"

if [ ! -f "$CONFIG" ]; then
        printf "${RED}Settings not found: $CONFIG${NC}\n" >&2
        exit 1
fi

# get monitor names
monitors_json=$(hyprctl monitors -j | jq '[.[].name]')

# temp file
tmpfile="$(mktemp)"

# set monitors
jq --argjson mons "$monitors_json" '
  .bar.monitors          = $mons
| .dock.monitors         = $mons
| .notifications.monitors = $mons
| .osd.monitors          = $mons
' "$CONFIG" >"$tmpfile" && mv "$tmpfile" "$CONFIG"

# reboot message
printf "${BLUE}installation completed! Reboot system now?${NC}\n"
select strictreply in "Yes" "No"; do
        relaxedreply=${strictreply:-$REPLY}
        case $relaxedreply in
        Yes | yes | y)
                printf "${GREEN}Rebooting...${NC}\n"
                sleep 1
                sudo systemctl reboot
                ;;
        No | no | n) exit ;;
        *) exit ;;
        esac
done
