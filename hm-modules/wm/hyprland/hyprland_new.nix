{
  config,
  font,
  lib,
  pkgs,
  timezone,
  inputs,
  ...
}: {
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      #statup commands
      exec-once = [
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${builtins.toString config.gtk.cursorTheme.size}"
        "nm-applet"
        "blueman-applet"
        "waybar"
      ];

      #define mod key
      "$mod" = "SUPER";

      general = {
        layout = "master";
        border_size = 4;
        gaps_in = 3;
        gaps_out = 3;
        "col.active_border" = "0xff${config.lib.stylix.colors.base08}";
        "col.inactive_border" = "0x33${config.lib.stylix.colors.base00}";
      };

      master = {
        mfact = 0.6;
      };

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      bind = [
        #launcher
        "$mod,code:47,exec,fuzzel"

        #Shortcuts
        "$mod,T,exec,alacritty"

        #interactions
        "$mod,SPACE,fullscreen,1"
        "ALT,TAB,cyclenext"
        "ALT,TAB,bringactivetotop"
        "ALTSHIFT,TAB,cyclenext,prev"
        "ALTSHIFT,TAB,bringactivetotop"
        "$mod,P,layoutmsg,swapwithmaster master"

        "$mod,Q,killactive"
        "SUPERSHIFT,Q,exit"

        "$mod,H,movefocus,l"
        "$mod,J,movefocus,d"
        "$mod,K,movefocus,u"
        "$mod,L,movefocus,r"

        "SUPERSHIFT,H,movewindow,l"
        "SUPERSHIFT,J,movewindow,d"
        "SUPERSHIFT,K,movewindow,u"
        "SUPERSHIFT,L,movewindow,r"

        "$mod,1,workspace,1"
        "$mod,2,workspace,2"
        "$mod,3,workspace,3"
        "$mod,4,workspace,4"
        "$mod,5,workspace,5"
        "$mod,6,workspace,6"
        "$mod,7,workspace,7"
        "$mod,8,workspace,8"
        "$mod,9,workspace,9"

        "SUPERSHIFT,1,movetoworkspace,1"
        "SUPERSHIFT,2,movetoworkspace,2"
        "SUPERSHIFT,3,movetoworkspace,3"
        "SUPERSHIFT,4,movetoworkspace,4"
        "SUPERSHIFT,5,movetoworkspace,5"
        "SUPERSHIFT,6,movetoworkspace,6"
        "SUPERSHIFT,7,movetoworkspace,7"
        "SUPERSHIFT,8,movetoworkspace,8"
        "SUPERSHIFT,9,movetoworkspace,9"
      ];

      input = {
        kb_layout = "us";
        kb_options = "ctrl:nocaps";
        kb_variant = "mac";
        repeat_delay = "350";
        repeat_rate = "50";
        accel_profile = "adaptive";
        follow_mouse = "2";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          ignore_opacity = true;
          contrast = 1.17;
          brightness = 0.8;
        };
      };
    };
  };

  #External
  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name =
      if (config.stylix.polarity == "light")
      then "Quintom_Ink"
      else "Quintom_Snow";
    size = 36;
  };

  #External software used with hyprland
  home.packages = with pkgs; [
    font-awesome
  ];
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
