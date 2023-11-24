{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "e4295a2e7454b5b04c54a33e14ad5e371b5de4da";
	};
in
{
	home.username = "bryan";
	home.homeDirectory = "/home/bryan";

  	home.stateVersion = "23.05"; # Please read the comment before changing.

	home.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		lazygit
		ripgrep
		fd
		gcc
		feh
		termite
		polybar
		picom
		firefox
		rofi
		nodejs
		xclip
		tree-sitter
		python311
		unzip
		cargo

		(writeShellScriptBin "esp-shell" ''
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
		font = "JetBrainsMono Nerd Font 12";
		backgroundColor = "#1e1e1e";
		foregroundColor = "#a7a7a7";
		foregroundBoldColor = "#a7a7a7";
		cursorColor = "#a7a7a7";
		colorsExtra = ''
# black
color0  = #1e1e1e
color8  = #5f5a60

# red
color1  = #cf6a4c
color9  = #cf6a4c

# green
color2  = #8f9d6a
color10 = #8f9d6a

# yellow
color3  = #f9ee98
color11 = #f9ee98

# blue
color4  = #7587a6
color12 = #7587a6

# magenta
color5  = #9b859d
color13 = #9b859d

# cyan
color6  = #afc4db
color14 = #afc4db

# white
color7  = #a7a7a7
color15 = #ffffff
		'';
	};

	home.file = {
		".config/nvim" = {
		    source = "${dotfilesRepo}/dotfiles/nvim";
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
