{ config, pkgs, ... }:
let
	dotfilesRepo = builtins.fetchGit {
		url = "https://github.com/bryan-melanson/nix-config.git";
		rev = "faa4962d15ff492542467afbe10796d5cdf5d723";
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
		luarocks
		cargo
		killall
		xorg.xmodmap
		vscode
		gnumake
		glibc
    lua

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
		enableAutosuggestions = true;
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "af-magic";
		};
	};

	programs.neovim = {
    enable = true;
  	defaultEditor = true;
	  viAlias = true;
	  vimAlias = true;
    extraLuaPackages = luaPkgs: with luaPkgs; [ luautf8 ];
    extraPython3Packages = pyPkgs: with pyPkgs; [ python-lsp-server ];
		plugins = with pkgs.vimPlugins; [
      # Appearance
      vim-table-mode # vimscript
      indentLine  # vimscript
      indent-blankline-nvim
      barbar-nvim
      nvim-tree-lua
      nvim-web-devicons
      # vim-airline
      feline-nvim
      # lualine-nvim
      one-nvim
      oceanic-material

      # Programming
      vim-which-key          # vimscript
      vim-haskellConcealPlus # vimscript
      vim-nix                # vimscript
      lspkind-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      nvim-lspconfig
      #nvim-lsp-saga
      nvim-compe
      vim-vsnip
      vim-vsnip-integ
      #nvim-rust-tools

      # Text objects
      tcomment_vim    # vimscript
      vim-surround    # vimscript
      vim-repeat      # vimscript
      nvim-autopairs

      # Git
      vim-fugitive  # vimscript
      vim-gitgutter # vimscript

      # DAP
      vimspector # vimscript

      # Fuzzy Finder
      telescope-nvim

      # General Deps
      popup-nvim
      plenary-nvim
      zen-mode-nvim
    ];
    extraLuaConfig =
      ''
        require('feline').setup()
      '';
    extraConfig =
      ''
      colorscheme oceanic_material
      set background=dark
      let g:context_nvim_no_redraw = 1
      set mouse=a
      set termguicolors
    	set number relativenumber
   	  '';
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

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};

	programs.home-manager.enable = true;
}
