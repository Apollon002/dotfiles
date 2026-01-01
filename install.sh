#!/usr/bin/bash

cd $HOME
git clone --bare https://github.com/Apollon002/dotfiles.git "$HOME/.dotfiles"
dot() {
        /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"
}

dot config --local status.showUntrackedFiles no

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
printf "${RED}-----------------------------------------${BLUE}\n"

printf "Do you wish to install the dotfiles and all needed packages?\n"
select strictreply in "Yes" "No"; do
        relaxedreply=${strictreply:-$REPLY}
        case $relaxedreply in
        Yes | yes | y)
                printf "${GREEN}Starting installation...${BLUE}\n"
                sleep 3
                break
                ;;
        No | no | n) exit ;;
        *) exit ;;
        esac
done

# Variable that contains used AUR helper
HELPER=

# check if AUR helper is installed
# if not, let user choose between paru and yay
if command -v paru >/dev/null 2>&1; then
        echo "paru installation found... continue with paru as package manager"
        HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
        echo "yay installation found... continue with yay as packagage manager"
        HELPER="yay"
else
        printf "${RED}No AUR helper found\n"
        printf "${BLUE}Select your preferred AUR helper\n"
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
                        printf "paru installation successful!\n"
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
                        printf "yay installation successful!\n"
                        break
                        ;;
                *)
                        printf "${ORANGE} Pls select paru or yay${BLUE}\n"
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

printf "${GREEN}installing core packages...${BLUE}\n"
sleep 2
# Install core packages
"${HELPER}" -S --needed --noconfirm "${CORE_PKGS[@]}"
# Install mermaid-cli for lazyvim
npm install @mermaid-js/mermaid-cli
# Install noctalia-shell
printf "${GREEN}installing noctalia-shell${BLUE}\n"
mkdir -p ~/.config/quickshell/noctalia-shell && curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell

# Change default shell to fish
printf "${GREEN}set fish as default shell${BLUE}\n"
chsh -s /usr/bin/fish

# set default applications
printf "${GREEN}setting default applications${BLUE}\n"
xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default feh.desktop image/jpeg
xdg-mime default feh.desktop image/png
xdg-mime default feh.desktop image/webp
xdg-mime default feh.desktop image/gif

# create wallpaper directory
printf "${GREEN}creating wallpaper directory ~/Pictures/Wallpapers/${BLUE}\n"
mkdir -p ~/Pictures/Wallpapers

# Install Fonts (Nerd Fonts Noto + FiraCode + Noto CJK Serif)
printf "${BLUE}starting to install fonts...${GREEN}\n"
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

        echo "Extracting fonts…"
        unzip -o Noto.zip -d "$FONT_DIR"
        unzip -o FiraCode.zip -d "$FONT_DIR"

        echo "Installing Noto CJK Serif…"
        mv NotoSerifCJK.ttc "$FONT_DIR/Noto/"

        echo "Refreshing font cache…"
        fc-cache -fv

        echo "Fonts installed successfully."
)

# Install browser
BROWSERS=("Brave" "Chrome" "Chromium" "Firefox" "Librewolf" "Zen" "None")
INSTALL_BROWSER=
printf "${BLUE}Please select a browser to install${GREEN}\n"
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
)

SELECTED_OPTIONALS=($(printf "%s\n" "${OPTIONAL_PKGS[@]}" | fzf --multi --prompt="Select optional packages > "))

if [ ${#SELECTED_OPTIONALS[@]} -gt 0 ]; then
        echo "installing:"
        printf ' - %s\n' "${SELECTED_OPTIONALS[@]}"
        "${HELPER}" -S --needed --noconfirm "${SELECTED_OPTIONALS[@]}"
else
        echo "no optional packages selected"
fi

if "${HELPER}" -Q cups >/dev/null 2>&1; then
        sudo systemctl enable cups.service
fi

dot checkout

echo "# Put the programs you want to autostart in this file" >~/.config/hypr/core/autostart_local.conf
echo "# Put your monitor settings in this file" >~/.config/hypr/extra/monitors/local.conf
echo "# Put your window rules in this file" >~/.config/hypr/extra/wrules/user.conf
