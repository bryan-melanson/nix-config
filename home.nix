{ config, pkgs, ... }:
let
  dotfilesRepo = builtins.fetchGit {
    url = "https://github.com/bryan-melanson/dotfiles.git";
    rev = "e9d5d5685da7a649e7492273cd8c1cd293cf089a";
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
    pkgs.alacritty
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

  programs.alacritty = {
    enable = true;
    settings = {
    	font = {
    size = 12.0;
    use_thin_strokes = true;

    normal.family = "JetBrainsMono Nerd Font";
    bold.family = "JetBrainsMono Nerd Font";
    italic.family = "JetBrainsMono Nerd Font";
  };

  cursor.style = "Beam";

  shell = {
    program = "zsh";
  };

  colors = {
    # Default colors
    primary = {
      background = "0x1b182c";
      foreground = "0xcbe3e7";
    };

    # Normal colors
    normal = {
      black =   "0x100e23";
      red =     "0xff8080";
      green =   "0x95ffa4";
      yellow =  "0xffe9aa";
      blue =    "0x91ddff";
      magenta = "0xc991e1";
      cyan =    "0xaaffe4";
      white =   "0xcbe3e7";
    };

    # Bright colors
    bright = {
      black =   "0x565575";
      red =     "0xff5458";
      green =   "0x62d196";
      yellow =  "0xffb378";
      blue =    "0x65b2ff";
      magenta = "0x906cff";
      cyan =    "0x63f2f1";
      white = "0xa6b3cc";
    };
  };
    };
  };

  home.file = {
   	".config/nvim" = {
	    source = "${dotfilesRepo}/nvim";
	  };
	  ".config/polybar" = {
	    source = "${dotfilesRepo}/polybar";
	  };
	  #".config/alacritty" = {
	  #  source = "${dotfilesRepo}/alacritty";
	  #};
          ".config/i3" = {
	    source = "${dotfilesRepo}/i3";
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
