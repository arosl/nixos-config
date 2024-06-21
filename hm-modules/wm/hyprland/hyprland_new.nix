
{
  config,
  font,
  lib,
  pkgs,
  timezone,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      
      general = {
        layout = "master";
        border_size = 4;
        gaps_in = 3;
        gaps_out = 3;
      };

      master = {
        mfact = 0.6;
      };

      bindm = [
        "$mod,code:47,exec,fuzzel"

        "$mod,SPACE,fullscreen,1" 
        "ALT,TAB,cyclenext"
        "ALT,TAB,bringactivetotop"
        "ALTSHIFT,TAB,cyclenext,prev"
        "ALTSHIFT,TAB,bringactivetotop"
        "$mod,T,exec,alacritty"
        
        "$mod,Q,killactive"
        "SUPERSHIFT,Q,exit"

        "SUPER,H,movefocus,l"
        "SUPER,J,movefocus,d"
        "SUPER,K,movefocus,u"
        "SUPER,L,movefocus,r"

        "SUPERSHIFT,H,movewindow,l"
        "SUPERSHIFT,J,movewindow,d"
        "SUPERSHIFT,K,movewindow,u"
        "SUPERSHIFT,L,movewindow,r"

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

  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = font + ":size=13";
      terminal = "${pkgs.alacritty}/bin/alacritty";
    };
    colors = {
      background = config.lib.stylix.colors.base00 + "e6";
      text = config.lib.stylix.colors.base07 + "ff";
      match = config.lib.stylix.colors.base05 + "ff";
      selection = config.lib.stylix.colors.base08 + "ff";
      selection-text = config.lib.stylix.colors.base00 + "ff";
      selection-match = config.lib.stylix.colors.base05 + "ff";
      border = config.lib.stylix.colors.base08 + "ff";
    };
    border = {
      width = 3;
      radius = 7;
    };
  };
  
}
