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
    ./waybar.nix # Status bar
    ./fuzzel.nix # Lancher
    ./fnott.nix # Notifications
    ./pyprland.nix # pyprland config
    (import ../../app/dmenu-scripts/networkmanager-dmenu.nix {
      dmenu_command = "fuzzel -d";
      inherit config lib pkgs;
    }) # wifi menu
    ../../app/ranger/ranger.nix # ranger config
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
        "pypr"
      ];
      exec = [
        "${pkgs.swaybg}/bin/swaybg -m fill -i /nix/store/aixnra3apbslq615qqg9rmif7xkxyn8a-vector-forest-sunset-forest-sunset-forest-wallpaper-b3abc35d0d699b056fa6b247589b18a8.jpg-"
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
        #launcher win+;
        "$mod,code:47,exec,fuzzel"

        # Launch Alacritty on the current workspace with $mod+T,  with modified class label
        "$mod,T,exec,alacritty --class modTAlacritty"
        # Default behavior for other Alacritty windows
        "SUPERSHIFT,T,exec,alacritty"

        #Scratchpads
        "$mod,Z,exec,pypr toggle term && hyprctl dispatch bringactivetotop"
        "$mod,R,exec,pypr toggle ranger && hyprctl dispatch bringactivetotop"
        "$mod,B,exec,pypr toggle btm && hyprctl dispatch bringactivetotop"

        #Screenshots
        ",code:107,exec,hyprshot -m region" # 1. Default Screenshot with User Selection (Region)
        "SHIFT,code:107,exec,hyprshot -m window -m active" # 2. Shift + Print Screen to Capture Active Window
        "SUPER,code:107,exec,hyprshot -m output -m eDP-1" # 3. Super + Print Screen to Capture Full Monitor
        "CTRL,code:107,exec,hyprshot -m region --clipboard-only" # 4. Ctrl + Print Screen to Capture Region and Copy to Clipboard
        "SHIFTCTRL,code:107,exec,hyprshot -m window -m active --clipboard-only" # 5. Shift + Ctrl + Print Screen to Capture Active Window and Copy to Clipboard
        "SUPERCTRL,code:107,exec,hyprshot -m output -m eDP-1 --clipboard-only" # 6. Super + Ctrl + Print Screen to Capture Full Monitor and Copy to Clipboard

        #Interactions
        "$mod,SPACE,fullscreen,1"
        "ALT,TAB,cyclenext"
        "ALT,TAB,bringactivetotop"
        "ALTSHIFT,TAB,cyclenext,prev"
        "ALTSHIFT,TAB,bringactivetotop"
        "$mod,P,layoutmsg,swapwithmaster master"
        "$mod,I,exec,networkmanager_dmenu"
        "$mod,F,exec,hyprctl dispatch togglefloating && hyprctl dispatch centerwindow"
        "SUPERSHIFT,RETURN,exec,hyprlock --immediate"

        "$mod,Q,killactive"
        "SUPERSHIFT,Q,exit"

        ",code:122,exec,${pkgs.pamixer}/bin/pamixer -d 10"
        ",code:123,exec,${pkgs.pamixer}/bin/pamixer -i 10"
        ",code:121,exec,${pkgs.pamixer}/bin/pamixer -t"
        ",code:256,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
        "SHIFT,code:123,exec,${pkgs.pamixer}/bin/pamixer --default-source -i 10"
        "SHIFT,code:122,exec,${pkgs.pamixer}/bin/pamixer --default-source -d 10"
        ",code:232,exec,${pkgs.brightnessctl}/bin/brightnessctl set 15-"
        ",code:233,exec,${pkgs.brightnessctl}/bin/brightnessctl set +15"

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

      windowrulev2 = [
        # General scratchpad rules
        "float, class:^(scratchpad)$"
        "size 80% 85%, class:^(scratchpad)$"
        "workspace special silent, class:^(scratchpad)$"
        "center, class:^(scratchpad)$"

        # Geary scratchpad rules
        "float, class:^(geary)$"
        "size 80% 85%, class:^(geary)$"
        "workspace special silent, class:^(geary)$"
        "center, class:^(geary)$"
        "opacity 0.85, class:^(geary)$"

        # Pavucontrol scratchpad rules
        # "float, class:^(pavucontrol)$"
        # "size 86% 40%, class:^(pavucontrol)$"
        # "move 50% 6%, class:^(pavucontrol)$"
        # "workspace special silent, class:^(pavucontrol)$"
        # "opacity 0.80, class:^(pavucontrol)$"

        # Move editors to workspace 1 when they opens
        "workspace 1, class:^(Code)$"
        "workspace 1, class:^(Alacritty)$, title:^(nvim .*)$"
        "workspace 1, class:^(Alacritty)$, title:^(hx .*)$"

        # Move Browsers to workspace 2 when they opens
        "workspace 2, class:^(Brave-browser)$"
        "workspace 2, class:^(Chromium-browser)$"
        "workspace 2, class:^(org.qutebrowser.qutebrowser)$"

        # Normal terminals on workspace 3
        "workspace 3, class:^(Alacritty)$"

        # Move chat to workspace 4 when they opens
        "workspace 4, class:^(whatsapp-for-linux)$"
        "workspace 4, class:^(org.telegram.desktop)$"

        # Move Filezilla to workspace 7 when it opens
        "workspace 7, class:^(filezilla)$"

        # Move remmina to workspace 8 when it opens
        "workspace 8, class:^(org.remmina.Remmina)$"

        # Move Mattermost to workspace 9 when it opens
        "workspace 9, class:^(Mattermost)$"

        # Opacity rules for specific apps
        "opacity 0.80, title:Heimdall"
        "opacity 0.75, title:^(New Tab - Brave)$"
        "opacity 0.65, title:^(Home - qutebrowser)$"
        "opacity 0.65, title:\\[.*\\] - Home"
        # "opacity 0.75, class:^(org.gnome.Nautilus)$"
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

  #Lockscreen
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 300;
      hide_cursor = true;
      no_fade_in = false;
      enable_fingerprint = true;
      fingerprint_ready_message = "fprint ready";
    };

    background = [
      {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }
    ];

    input-field = [
      {
        placeholder_text = "<i>Password or FP ...</i>";
        size = "550, 70";
        position = "0, 0";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        shadow_passes = 2;
      }
    ];

    label = [
      {
        text = "$TIME<br/>Hi there, $DESC.";
        text_align = "center";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 25;
        position = "0, 120";
        halign = "center";
        valign = "center";
      }
    ];
  };

  #Idle management
  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      {
        timeout = 600;
        on-timeout = "hyprlock";
      }
      {
        timeout = 1200;
        on-timeout = "hyprctl dispatch dpms off";
        on-resume = "hyprctl dispatch dpms on";
      }
    ];
  };

  #External software used with hyprland
  home.packages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-hyprland
    wl-clipboard
    font-awesome
    hyprshot
  ];
}
