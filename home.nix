{ config, pkgs, ... }:
let
  dotfilesRepo = builtins.fetchGit {
    url = "https://github.com/bryan-melanson/dotfiles.git";
    rev = "92f95142fa42d51c30c22a9b48e14d48ce487c36";
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
