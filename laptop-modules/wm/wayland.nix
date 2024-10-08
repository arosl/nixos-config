{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = [pkgs.wayland pkgs.waydroid];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "mac";
      options = "caps:escape";
    };
  };
}
