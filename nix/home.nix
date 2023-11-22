{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "d098226879f1a874f380ce34de3e517408dc7ffe";
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
		pkgs.termite
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
