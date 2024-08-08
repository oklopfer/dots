#!/usr/bin/env bash

git submodule update --init --recursive

if [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]]; then
	sudo cp -r oh-my-zsh/* /usr/share/oh-my-zsh/oh-my-zsh
else
	cp -r oh-my-zsh/* ~/.oh-my-zsh
fi

for i in p10k.zsh zshrc config; do
	cp -r "${i}" ~/."${i}"
done
