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
    command = "ghostty --class=com.ghostty.scratchpad"
    lazy = true

    [scratchpads.yazi]
    command = "ghostty --class=com.ghostty.scratchpad -e yazi" 
    margin = 50
    lazy = true

    [scratchpads.btm]
    command = "ghostty --class=com.ghostty.scratchpad -e btm --battery"
    margin = 50
    lazy = true

    [scratchpads.geary]
    command = "geary"
    size = "90% 90%"
    lazy = true

    [scratchpads.obs]
    animation = ""
    command = "obsidian"
    class = "obsidian"
    lazy = true
    size = "90% 90%"
    excludes = "*"

    [scratchpads.pavucontrol]
    command = "pavucontrol"
    class = "org.pulseaudio.pavucontrol"
    margin = 50
    lazy = true

  '';
}
