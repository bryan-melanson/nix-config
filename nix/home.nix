{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/dotfiles.git";
		ref = "main";
	};
in
{
  xresources.properties = {
    "Xft.dpi" = 80;
  };

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
		python311Packages.pip
		unzip
		cargo
		killall
		xorg.xmodmap
		gnumake
		glibc
		tmux
		i3
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
	
	home.file = {
		".config/i3" = {
		    source = "${dotfilesRepo}/dotfiles/i3";
		};
		".config/tmux" = {
		    source = "${dotfilesRepo}/dotfiles/tmux";
		};
		"wallpaper" = {
			source = builtins.fetchGit {
				url = "https://github.com/bryan-melanson/wallpaper.git";
				ref = "master";
			};
			target = "${config.home.homeDirectory}/wallpaper";
		};
	};
	
	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};
	
	programs.home-manager.enable = true;
}
