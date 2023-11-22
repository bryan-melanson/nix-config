## NixOS

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
nix-shell '<home-manager>' -A install

ssh-keygen  # then, add to Github

# clone repo

install.sh
sudo nixos-rebuild switch
home-manager switch
```
