{
  config,
  lib,
  pkgs,
  ...
}: {
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    ansible
    bat
    bottom
    brightnessctl
    cava
    cowsay
    dig
    fastfetch
    fd
    file
    fzf
    gnugrep
    gnused
    htop
    hwinfo
    inetutils #provides whois
    jq
    killall
    libnotify
    lolcat
    moreutils
    octave
    pandoc
    pciutils
    ripgrep
    rsync
    tmux
    tree
    unzip
    vim
    w3m
    yq
    xmlstarlet
    (pkgs.writeShellScriptBin "airplane-mode" ''
      #!/bin/sh
      connectivity="$(nmcli n connectivity)"
      if [ "$connectivity" == "full" ]
      then
          nmcli n off
      else
          nmcli n on
      fi
    '')
  ];
}
