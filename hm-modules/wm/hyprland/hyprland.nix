{
  config,
  font,
  lib,
  pkgs,
  timezone,
  inputs,
  ...
}:{
  imports = [
    ./waybar.nix # Status bar
    ./fuzzel.nix # Launcher
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
      # Startup commands
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

      # Define mod key
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

      # Monitor configuration
      # eDP-1: Laptop screen, scaled to 2.0.
      # HDMI-A-2: External screen, scaled to 1.5, auto-positioned to the right of eDP-1.
      monitor = [
        "eDP-1,preferred,auto,2"
        "HDMI-A-2,preferred,auto-right,1.25"
      ];

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      # Keybinding definitions
      # bindd: A keybinding format with descriptions for each shortcut.
      # Syntax: MODS, key, description, dispatcher, params
      bindd = [
        # Launcher
        "$mod,code:47,Open launcher, exec, fuzzel"

        # Launch applications
        "$mod,T,Launch Terminal on current workspace,exec,alacritty --class modTAlacritty"
        "SUPERSHIFT,T,Launch Terminal on terminal workspace,exec,alacritty"
        "SUPERSHIFT,B,Launch Brave browser,exec,brave"

        # Scratchpads
        "$mod,Z,Toggle terminal scratchpad,exec,pypr toggle term && hyprctl dispatch bringactivetotop"
        "$mod,R,Toggle ranger scratchpad,exec,pypr toggle ranger && hyprctl dispatch bringactivetotop"
        "$mod,B,Toggle btm scratchpad,exec,pypr toggle btm && hyprctl dispatch bringactivetotop"

        # Screenshots
        ",code:107,Take screenshot of region,exec,hyprshot -m region"
        "SHIFT,code:107,Screenshot active window,exec,hyprshot -m window -m active"
        "SUPER,code:107,Full monitor screenshot,exec,hyprshot -m output -m eDP-1"
        "CTRL,code:107,Copy region screenshot,exec,hyprshot -m region --clipboard-only"
        "SHIFTCTRL,code:107,Copy active window screenshot,exec,hyprshot -m window -m active --clipboard-only"
        "SUPERCTRL,code:107,Copy full monitor screenshot,exec,hyprshot -m output -m eDP-1 --clipboard-only"

        # Window interactions
        "$mod,SPACE,Toggle fullscreen,fullscreen,1"
        "ALT,TAB,Switch to next window,cyclenext"
        "ALTSHIFT,TAB,Switch to previous window,cyclenext,prev"
        "$mod,P,Swap with master window,layoutmsg,swapwithmaster master"
        "$mod,F,Toggle floating and center window,exec,hyprctl dispatch togglefloating && hyprctl dispatch centerwindow"

        # Lock and exit
        "SUPERSHIFT,RETURN,Lock screen immediately,exec,hyprlock --immediate"
        "$mod,Q,Close active window,killactive"
        "SUPERSHIFT,Q,Exit Hyprland,exit"

        # Audio and brightness controls
        ",code:122,Lower volume,exec,${pkgs.pamixer}/bin/pamixer -d 10"
        ",code:123,Raise volume,exec,${pkgs.pamixer}/bin/pamixer -i 10"
        ",code:121,Toggle mute,exec,${pkgs.pamixer}/bin/pamixer -t"
        ",code:256,Toggle microphone mute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t"
        "SHIFT,code:123,Raise mic volume,exec,${pkgs.pamixer}/bin/pamixer --default-source -i 10"
        "SHIFT,code:122,Lower mic volume,exec,${pkgs.pamixer}/bin/pamixer --default-source -d 10"
        ",code:232,Lower brightness,exec,${pkgs.brightnessctl}/bin/brightnessctl set 15-"
        ",code:233,Raise brightness,exec,${pkgs.brightnessctl}/bin/brightnessctl set +15"

        # Focus movement
        "$mod,H,Move focus left,movefocus,l"
        "$mod,J,Move focus down,movefocus,d"
        "$mod,K,Move focus up,movefocus,u"
        "$mod,L,Move focus right,movefocus,r"

        # Window movement
        "SUPERSHIFT,H,Move window left,movewindow,l"
        "SUPERSHIFT,J,Move window down,movewindow,d"
        "SUPERSHIFT,K,Move window up,movewindow,u"
        "SUPERSHIFT,L,Move window right,movewindow,r"

        # Workspace management
        "$mod,1,Switch to workspace 1,workspace,1"
        "$mod,2,Switch to workspace 2,workspace,2"
        "$mod,3,Switch to workspace 3,workspace,3"
        "$mod,4,Switch to workspace 4,workspace,4"
        "$mod,5,Switch to workspace 5,workspace,5"
        "$mod,6,Switch to workspace 6,workspace,6"
        "$mod,7,Switch to workspace 7,workspace,7"
        "$mod,8,Switch to workspace 8,workspace,8"
        "$mod,9,Switch to workspace 9,workspace,9"

        "SUPERSHIFT,1,Move window to workspace 1,movetoworkspace,1"
        "SUPERSHIFT,2,Move window to workspace 2,movetoworkspace,2"
        "SUPERSHIFT,3,Move window to workspace 3,movetoworkspace,3"
        "SUPERSHIFT,4,Move window to workspace 4,movetoworkspace,4"
        "SUPERSHIFT,5,Move window to workspace 5,movetoworkspace,5"
        "SUPERSHIFT,6,Move window to workspace 6,movetoworkspace,6"
        "SUPERSHIFT,7,Move window to workspace 7,movetoworkspace,7"
        "SUPERSHIFT,8,Move window to workspace 8,movetoworkspace,8"
        "SUPERSHIFT,9,Move window to workspace 9,movetoworkspace,9"
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
        "float, class:^(pavucontrol)$"
        "size 86% 40%, class:^(pavucontrol)$"
        "move 50% 6%, class:^(pavucontrol)$"
        "workspace special silent, class:^(pavucontrol)$"
        "opacity 0.80, class:^(pavucontrol)$"
        "minsize 20%, floating:1"

        # Move Browsers to workspace 2 when they open
        "workspace 1, class:^(brave-browser)$"
        "workspace 1, class:^(Chromium-browser)$"
        "workspace 1, class:^(org.qutebrowser.qutebrowser)$"

        # Move editors to workspace 1 when they open
        "workspace 2, class:^(Code)$"
        "workspace 2, class:^(Alacritty)$, title:^(nvim .*)$"
        "workspace 2, class:^(Alacritty)$, title:^(hx .*)$"

        # Normal terminals on workspace 3
        "workspace 3, class:^(Alacritty)$"

        # Move chat to workspace 4 when they open
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

        # Zed scratchpad floats like the others
        #"float, class:^(ZedScratch)$"
        #"size 80% 85%, class:^(ZedScratch)$"
        #"workspace special silent, class:^(ZedScratch)$"
        #"center, class:^(ZedScratch)$"
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

  # External
  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name =
      if (config.stylix.polarity == "light")
      then "Quintom_Ink"
      else "Quintom_Snow";
    size = 36;
  };

  # Lockscreen
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

  # Idle management
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

  # External software used with hyprland
  home.packages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-hyprland
    wl-clipboard
    font-awesome
    hyprshot
  ];
}
