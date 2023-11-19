## NixOS

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

ssh-keygen  # then, add to Github

sudo nixos-rebuild switch

# Install home manager

home-manager switch
```
