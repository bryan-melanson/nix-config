{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "0e9b10d7c5e5b9b3f5202e2e700e9a634add77de";
	};
in
{
	home.username = "bryan";
	home.homeDirectory = "/home/bryan";

  	home.stateVersion = "23.05"; # Please read the comment before changing.

	home.packages = [
		(pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		pkgs.lazygit
		pkgs.ripgrep
		pkgs.fd
		pkgs.gcc
		pkgs.feh
		pkgs.kitty
		pkgs.polybar
		pkgs.picom
		pkgs.firefox
		pkgs.rofi

		(pkgs.writeShellScriptBin "esp-shell" ''
			nix --experimental-features 'nix-command flakes' develop github:mirrexagon/nixpkgs-esp-dev#esp32-idf
		'')
	];

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.git = {
		enable = true;
		userName = "Bryan Melanson";
		userEmail = "hello@bryan.horse";
	};

	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -l";
			update = "sudo nixos-rebuild switch";
			config = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
		};
		enableAutosuggestions  = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "af-magic";
		};
	};

	programs.termite = {
		enable = true;
		font = "JetBrainsMono Nerd Font 13";
	};

	home.file = {
		".config/nvim" = {
		    source = "${dotfilesRepo}/dotfiles/nvim";
		  };
		".config/polybar" = {
		    source = "${dotfilesRepo}/dotfiles/polybar";
		  };
		".config/i3" = {
		    source = "${dotfilesRepo}/dotfiles/i3";
		  };
		"wallpaper" = {
			source = builtins.fetchGit {
				url = "https://github.com/bryan-melanson/wallpaper.git";
				ref = "master";
			};
			target = "${config.home.homeDirectory}/wallpaper";
		};
	};

	programs.home-manager.enable = true;
}
