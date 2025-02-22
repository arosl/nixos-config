{
  config,
  font,
  lib,
  pkgs,
  timezone,
  inputs,
  ...
}: {
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = font + ":size=13";
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };
    colors = {
      background = "${config.lib.stylix.colors.base00}e6";
      text = "${config.lib.stylix.colors.base07}ff";
      match = "${config.lib.stylix.colors.base05}ff";
      selection = "${config.lib.stylix.colors.base08}ff";
      selection-text = "${config.lib.stylix.colors.base00}ff";
      selection-match = "${config.lib.stylix.colors.base05}ff";
      border = "${config.lib.stylix.colors.base08}ff";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };
}
