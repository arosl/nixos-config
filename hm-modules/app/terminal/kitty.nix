{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true;
  programs.kitty.settings = {
    background_opacity = lib.mkForce "0.65";
    enable_audio_bell = "no"; 
    font_size = lib.mkForce "12.0";
  };
}
