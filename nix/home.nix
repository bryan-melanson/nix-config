{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "dfe70fca2dd777a9a2439ef97e16925397936288";
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
		backgroundColor = "#0c0d0e";
		foregroundColor = "#b7b8b9";
		foregroundBoldColor = "#dadbdc";
		cursorColor = "#dadbdc";
		colorsExtra = ''
			# Black, Gray, Silver, White
			color0  = "#0c0d0e"
			color8  = "#737475"
			color7  = "#b7b8b9"
			color15 = "#fcfdfe"
			
			# Red
			color1  = "#e31a1c"
			color9  = "#e31a1c"
			
			# Green
			color2  = "#31a354"
			color10 = "#31a354"
			
			# Yellow
			color3  = "#dca060"
			color11 = "#dca060"
			
			# Blue
			color4  = "#3182bd"
			color12 = "#3182bd"
			# Purple
			color5  = "#756bb1"
			color13 = "#756bb1"
			
			# Teal
			color6  = "#80b1d3"
			color14 = "#80b1d3"
			
			# Extra colors
			color15 = "#fcfdfe"
			color16 = "#e6550d"
			color17 = "#b15928"
			color18 = "#2e2f30"
			color19 = "#515253"
			color20 = "#959697"
			color21 = "#dadbdc"
		'';
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
