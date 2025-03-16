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
    #cava
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
    lazygit
    libnotify
    lolcat
    moreutils
    octave
    openssl
    pandoc
    pciutils
    ripgrep
    rsync
    speedtest-cli
    tmux
    tree
    unzip
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
