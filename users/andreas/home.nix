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
    stylix.homeManagerModules.stylix
    ../../hm-modules/app/browser/chromium.nix # Chromium
    ../../hm-modules/app/browser/qutebrowser.nix # qutebrowser
    ../../hm-modules/app/chat/weechat.nix #weechat matrix overlay
    ../../hm-modules/app/editor/helix/helix.nix # helix editor
    ../../hm-modules/app/editor/nvim-lua/neovim.nix # neovim editor
    ../../hm-modules/app/editor/vscode/vscode.nix # vscode editor
    ../../hm-modules/app/email/neomutt.nix #neomutt email client
    ../../hm-modules/app/flatpak/flatpak.nix # Flatpaks
    ../../hm-modules/app/git/git.nix # My git config
    # ../../hm-modules/app/pwmanager/bitwarden.nix # install bitwarden
    ../../hm-modules/app/pwmanager/pass.nix # install pass
    ../../hm-modules/app/ranger/ranger.nix # My ranger file manager config
    ../../hm-modules/app/terminal/tmux.nix # Tmux setup
    ../../hm-modules/app/virtualization/virtualization.nix # Virtual machines
    ../../hm-modules/hardware/bluetooth.nix # Bluetooth
    ../../hm-modules/lang/lsp-formatters.nix # LSP and formaters availabe
    ../../hm-modules/lang/python/python3.nix # python3
    # ../../hm-modules/llm/ollama/ollama.nix # Ollama LLM
    ../../hm-modules/shell/cli-collection.nix # Useful CLI apps
    ../../hm-modules/shell/sh.nix # My zsh and bash config
    ../../hm-modules/style/stylix.nix # Styling and themes for my apps
    ../../hm-modules/wm/hyprland/hyprland.nix #window manager config
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "andreas";
    homeDirectory = "/home/andreas";
    stateVersion = "23.05"; # Please read the comment before changing.

    sessionVariables = {
      EDITOR = editor;
      TERM = term;
      BROWSER = browser;
    };

    packages = with pkgs; [
      # Core
      zsh
      alacritty
      qutebrowser
      dmenu
      rofi
      git
      syncthing
      manix

      # Office
      libreoffice-fresh
      mate.atril
      glib
      gnome.nautilus
      gnome.gnome-calendar
      gnome.seahorse
      gnome.gnome-maps

      #work
      filezilla
      mosh
      ipcalc

      #chat
      telegram-desktop
      mattermost-desktop
      element-desktop-wayland
      whatsapp-for-linux
      signal-desktop
      discord

      #diving
      # deco
      # mnemo-tools
      subsurface

      #misc
      tldr
      stellarium
      disfetch

      # Various dev packages
      texinfo
      libffi
      zlib
      nodePackages.ungit
      nodejs_20
      sqlite
      cargo
      beekeeper-studio

      # Media
      gimp-with-plugins
      inkscape
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
  services.syncthing.enable = true;

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
