{
  config,
  lib,
  pkgs,
  ...
}: {
  # Collection of useful CLI apps
  home.packages = with pkgs; [
    # Command Line
    bat
    bottom
    brightnessctl
    cava
    cowsay
    dig
    fd
    fzf
    gnugrep
    gnused
    htop
    hwinfo
    jq
    inetutils #provides whois
    killall
    libnotify
    lolcat
    moreutils
    fastfetch
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
