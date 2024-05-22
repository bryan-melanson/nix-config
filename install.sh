#!/usr/bin/bash

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

cp -r ./home-manager/* ~/.config/home-manager/
cp .Xresources ~/
ln -s ./home-manager/configs/i3/config ~/.config/i3/config
