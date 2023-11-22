#!/bin/sh

# Define paths
home_manager_config_dir="$HOME/.config/home-manager/"
home_manager_config_old="$HOME/.config/home-manager/home.nix"
home_manager_config="$PWD/nix/home.nix"

# Check if ~/.config/home-manager/home.nix exists
if [ -e "$home_manager_config_old" ]; then
	# If it exists, delete it
	mv "$home_manager_config_old" ./nix/home.old
	echo "Deleted existing $home_manager_config_old"
fi

# Copy the local home.nix to ~/.config/home-manager/
cp "$home_manager_config" "$home_manager_config_dir"
echo "Copied home.nix to $home_manager_config_dir"

system_config_dir="/etc/nixos"
system_config_old="/etc/nixos/configuration.nix"
system_config="$PWD/nix/configuration.nix"

if [ -e "$system_config_old" ]; then
	# If it exists, delete it
	sudo mv "$system_config_old" ./nix/configuration.old
	echo "Deleted existing $system_config_old"
fi

sudo cp "$system_config" "$system_config_dir"
echo "Copied configuration.nix to $system_config_dir"
