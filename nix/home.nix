{ config, pkgs, ... }:
{
	home.username = "bryan";
	home.homeDirectory = "/home/bryan";
	home.stateVersion = "23.05"; # Please read the comment before changing.

	home.packages = with pkgs; [
		git
		curl
		tmux
		neovim
		cmake
		meson
		ninja
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
		enableAutosuggestions = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "af-magic";
		};
	};

	home.file = {
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
