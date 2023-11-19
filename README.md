## NixOS

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

ssh-keygen  # then, add to Github

nix-shell -p git

git clone https://codeberg.com/bryan-melanson/dotfiles.git $HOME/dotfiles
```
