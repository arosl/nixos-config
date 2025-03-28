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
  sops-nix,
  ...
}: let
  customPkgs = import ../../hm-modules/pkgs/custom-packages.nix {inherit pkgs;};
in {
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  qt.platformTheme.name = "kvantum";
  catppuccin.enable = true;
  catppuccin.lazygit.enable = true;

  imports = [
    stylix.homeManagerModules.stylix
    sops-nix.homeManagerModules.sops
    ../../hm-modules/app/browser/brave.nix # Brave
    ../../hm-modules/app/browser/chromium.nix # chromium
    # ../../hm-modules/app/browser/qutebrowser.nix # qutebrowser
    ../../hm-modules/app/chat/weechat.nix #weechat matrix overlay
    ../../hm-modules/app/editor/helix/helix.nix # helix editor
    #../../hm-modules/app/editor/nvim-lua/neovim.nix # neovim editor
    ../../hm-modules/app/editor/nixvim/nixvim.nix # neovim editor with nixvim
    ../../hm-modules/app/editor/vscode/vscode.nix # vscode editor
    ../../hm-modules/app/editor/zeditor/zeditor.nix # zed-editor
    #  ../../hm-modules/app/email/neomutt.nix #neomutt email client
    # ../../hm-modules/app/email/mbsync.nix #mbsync of email
    # ../../hm-modules/app/email/email.nix # email config
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
    ../../hm-modules/llm/ollama.nix # Ollama LLM
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
      FLAKE = "/home/andreas/repos/nixos-config/";
      NIXOS_OZONE_WL = "1";
    };

    packages = with pkgs; [
      # Core
      zsh
      nh
      alacritty
      dmenu
      rofi
      git
      manix
      restic
      rclone
      obsidian

      #misc
      tldr
      magic-wormhole
      qutebrowser
      browsh
      yazi
      foot
      wezterm
      vial

      #Custom packages
      customPkgs.deco
      customPkgs.mnemo-tools # provides mnemofetch

      #3d printing
      prusa-slicer
      orca-slicer
      freecad
      #openscad
      openscad-unstable
      
      # Office
      libreoffice
      mate.atril
      glib
      geary
      nautilus
      gnome-calendar
      seahorse
      gnome-maps

      #work
      filezilla
      mosh
      ipcalc
      nmap
      spice
      remmina

      #chat
      telegram-desktop
      mattermost-desktop
      matterhorn
      element-desktop
      whatsapp-for-linux
      signal-desktop
      zoom
      # discord

      #diving
      subsurface
      # qgis
      ghostscript
      poppler_utils #pdfunite

      #Astro
      stellarium
      siril

      #Photo
      darktable
      exiflooter
      exifprobe
      exiftool
      exif

      # Various dev packages
      texinfo
      libffi
      zlib
      nodePackages.ungit
      nodejs_20
      sqlite
      cargo
      beekeeper-studio
      opencv

      # Media
      # gimp-with-plugins
      inkscape
      pinta
      krita
      vlc
      mpv
      yt-dlp
      ffmpeg
      movit
      wf-recorder
      mediainfo
      libmediainfo
      mediainfo-gui
      audio-recorder
      vocal
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
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      desktop = null;
      publicShare = null;
      extraConfig = {
        # XDG_ARCHIVE_DIR = "${config.home.homeDirectory}/Archive";
        XDG_VM_DIR = "${config.home.homeDirectory}/Machines";
        XDG_PODCAST_DIR = "${config.home.homeDirectory}/Media/Podcasts";
        XDG_BOOK_DIR = "${config.home.homeDirectory}/Media/Books";
      };
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
}
