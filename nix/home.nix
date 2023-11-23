{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "330e07ae83d5e5466a2b3d9cfe1a8262e8dbf8ba";
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
    pkgs.nodejs
    pkgs.xclip
    pkgs.tree-sitter

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
		font = "JetBrainsMono Nerd Font 10";
		backgroundColor = "#1d1f21";
		foregroundColor = "#c5c8c6";
		foregroundBoldColor = "#c5c8c6";
		cursorColor = "#c5c8c6";
		colorsExtra = ''
      # black
color0  = #282a2e
color8  = #373b41

# red
color1  = #a54242
color9  = #cc6666

# green
color2  = #8c9440
color10 = #b5bd68

# yellow
color3  = #de935f
color11 = #f0c674

# blue
color4  = #5f819d
color12 = #81a2be

# magenta
color5  = #85678f
color13 = #b294bb

# cyan
color6  = #5e8d87
color14 = #8abeb7

# white
color7  = #707880
color15 = #c5c8c6
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
