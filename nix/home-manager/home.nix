{ config, pkgs, fetchFromGitHub, ... }:
{
	imports = [
		./configs
	]
	home.username = "bryan";
	home.homeDirectory = "/home/bryan";
	home.stateVersion = "23.11"; # Please read the comment before changing.

	home.packages = with pkgs; [
		git
		curl
		kitty
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

	programs.tmux = {
		enable = true;
		baseIndex = 1;
		prefix = "C-Space";

		plugins = with pkgs; [
			tmuxPlugins.better-mouse-mode
				modern-tmux-theme
				tmuxPlugins.catppuccin
				tmuxPlugins.sensible
				tmuxPlugins.vim-tmux-navigator
		];

		extraConfig = ''
			set-option -sa terminal-overrides ",xterm*:Tc"
			set -g mouse on
			bind -n M-h select-pane -L
			bind -n M-j select-pane -D
			bind -n M-k select-pane -U
			bind -n M-l select-pane -R

			bind -n M-H previous-window
			bind -n M-L next-window

			set -g @catppuccin_flavour 'mocha'
			''
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
