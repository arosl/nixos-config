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
    eza
    fd
    fzf
    gnugrep
    gnused
    htop
    hwinfo
    jq
    inetutils
    killall
    libnotify
    lolcat
    moreutils
    neofetch
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
    #whois using the inetutils instead 
    #(pkgs.callPackage ../pkgs/ytsub.nix { })
    #(pkgs.callPackage ../pkgs/russ.nix { })
    #(pkgs.callPackage ../pkgs/pokemon-colorscripts.nix {})
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
