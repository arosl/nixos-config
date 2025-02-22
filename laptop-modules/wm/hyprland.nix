{
  config,
  lib,
  pkgs,
  ...
}: {
  # Import wayland config
  imports = [
    ./wayland.nix
    ./pipewire.nix
    ./dbus.nix
  ];

  # Security
  security = {
    #    pam.services.swaylock = {
    #      text = ''
    #        auth include login
    #      '';
    #    };
    # pam.services.gtklock = {};
    pam.services ={
      hyprlock = {};
      hyprlock.fprintAuth = true ;
      login.enableGnomeKeyring = true;
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    fprintd.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}
