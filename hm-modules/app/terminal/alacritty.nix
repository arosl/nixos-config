{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.9;

    font = {
      size = lib.mkForce 12;
    };
  };
}
