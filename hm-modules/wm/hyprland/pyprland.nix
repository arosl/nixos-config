{
  config,
  font,
  lib,
  pkgs,
  timezone,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    pyprland
    pavucontrol
  ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = ["scratchpads"]

    [scratchpads.term]
    command = "alacritty --class scratchpad"
    margin = 50
    lazy = true

    [scratchpads.ranger]
    command = "kitty --class scratchpad -e ranger"
    margin = 50
    lazy = true

    [scratchpads.btm]
    command = "alacritty --class scratchpad -e btm --battery"
    margin = 50
    lazy = true

  '';
}
