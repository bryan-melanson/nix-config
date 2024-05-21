{ config, pkgs, fetchFromGitHub, ... }:
{
	imports = [
		./configs
	];

	xdg.configFile = {
		"i3/config".text = builtins.readFile ./configs/i3/config;
	};

	home.username = "bryan";
	home.homeDirectory = "/home/bryan";
	home.stateVersion = "23.05"; # Please read the comment before changing.

	home.packages = with pkgs; [
		git
		curl
		kitty
		qemu
		pre-commit
		neovim
		cmake
		meson
		ninja
		lazygit
		rustup
		zig
		ripgrep
		fd
		gcc
		feh
		picom
		firefox
		rofi
		nodejs
		xclip
		tree-sitter
		python311
		python311Packages.pip
		unzip
		killall
		xorg.xmodmap
		gnumake
		glibc
		(writeShellScriptBin "esp-shell" ''
		 nix --experimental-features 'nix-command flakes' develop github:mirrexagon/nixpkgs-esp-dev#esp32-idf
		 '')
		(pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
	];

	home.sessionVariables = {
		EDITOR = "nvim";
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
