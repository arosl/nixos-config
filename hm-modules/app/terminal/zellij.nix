{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    zellij
  ];
  programs.zellij.enable = true;
  #  programs.zellij.settings = {
  # };
}
