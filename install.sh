#!/usr/bin/env bash

pacinst=()
if  [[ -f /usr/bin/pacstall ]]; then
    if ! [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]]; then
        pacinst+=(oh-my-zsh-git)
    fi
    if ! [[ -f /usr/bin/neofetch ]]; then
        pacinst+=(neofetch)
    fi
    pacstall -PI "${pacinst[@]}"
else
    echo "Ensure oh-my-zsh and neofetch are installed"
fi

inst=()
if [[ -f /usr/bin/apt ]]; then
    if ! [[ -f /usr/bin/eza ]]; then
        inst+=(eza)
    fi
    if ! [[ -f /usr/bin/bat ]]; then
        inst+=(bat)
    fi
    sudo apt install "${inst[@]}" -y
else
    echo "eza and bat are recommended"
fi

git submodule update --init --recursive

sudo mkdir -p ~/.config/neofetch ~/.oh-my-zsh
sudo chown -cR "${USER}":"${USER}" ~/.config ~/.oh-my-zsh

if [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]]; then
    sudo cp -r ./oh-my-zsh/* /usr/share/oh-my-zsh
else
    cp -r ./oh-my-zsh/* ~/.oh-my-zsh
fi

sudo cp ./config/neofetch/config.conf ~/.config/neofetch
sudo chown -cR "${USER}":"${USER}" ~/.config/neofetch

for i in p10k.zsh zshrc; do
    cp -r "${i}" ~/."${i}"
done

if [[ -d /usr/share/xfce4/terminal/colorschemes/ ]]; then
    sudo cp darkula-plus.theme /usr/share/xfce4/terminal/colorschemes/
fi

if [[ $(uname) == "Darwin" ]]; then
    cp meslolgsnf/*.ttf ~/Library/Fonts
else
    sudo mkdir -p /usr/share/fonts/truetype
    sudo cp -r meslolgsnf /usr/share/fonts/truetype
fi

neofetch
"$(which zsh)"
