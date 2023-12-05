{pkgs, ...}: {
  # Specify the bw packages
  home.packages = with pkgs; [
    bitwarden-cli
    bitwarden-menu
  ];

  #maybe use sops for more config
}
