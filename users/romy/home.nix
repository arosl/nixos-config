{
  config,
  lib,
  pkgs,
  stdenv,
  fetchurl,
  stylix,
  username,
  email,
  theme,
  wm,
  browser,
  editor,
  term,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [
    # ../../hm-modules/wm/gnome.nix #window manager config
    ../../hm-modules/shell/sh.nix # My zsh and bash config
    ../../hm-modules/shell/cli-collection.nix # Useful CLI apps
    ../../hm-modules/app/ranger/ranger.nix # My ranger file manager config
    ../../hm-modules/app/terminal/tmux.nix # Tmux setup
    ../../hm-modules/lang/lsp-formatters.nix # LSP and formaters availabe
    ../../hm-modules/app/editor/vscode/vscode.nix # vscode editor
    ../../hm-modules/app/editor/nvim-lua/neovim.nix # neovim editor
    ../../hm-modules/app/editor/helix/helix.nix # helix editor
    ../../hm-modules/hardware/bluetooth.nix # Bluetooth
    ../../hm-modules/app/browser/chromium.nix # Chromium
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "romy";
    homeDirectory = "/home/romy";
    stateVersion = "23.05"; # Please read the comment before changing.

    packages = with pkgs; [
      # Core
      zsh
      alacritty
      
      #3d printing
      prusa-slicer
      # super-slicer
      # cura

      #chat
      telegram-desktop

      # Office
      libreoffice-fresh
      mate.atril
      glib
      gnome.nautilus
      gnome.gnome-calendar
      gnome.seahorse
      gnome.gnome-maps

      # Media
      # gimp-with-plugins
      pinta
      krita
      vlc
      mpv
      yt-dlp
      ffmpeg
      movit
      mediainfo
      libmediainfo
      mediainfo-gui
      audio-recorder

    ];
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Videos";
      pictures = "${config.home.homeDirectory}/Media/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      desktop = null;
      publicShare = null;
      extraConfig = {
        XDG_DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
        XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
        XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
        XDG_ORG_DIR = "${config.home.homeDirectory}/Org";
        XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
        XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
      };
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
}
