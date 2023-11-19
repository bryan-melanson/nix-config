{ config, pkgs, ... }:
let
  dotfilesRepo = builtins.fetchGit {
    url = "https://github.com/bryan-melanson/dotfiles.git";
    rev = "253d1479b793916d16d311baba1ba9c4f3d65aff";
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
    pkgs.brave
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

  home.file = {
   	".config/nvim" = {
	    source = "${dotfilesRepo}/nvim";
	  };
	  ".config/polybar" = {
	    source = "${dotfilesRepo}/polybar";
	  };
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
