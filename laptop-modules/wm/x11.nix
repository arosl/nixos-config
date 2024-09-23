{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./gnome-keyring.nix
    ./fonts.nix
    ./lightdm.nix
  ];

  # Configure X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
    excludePackages = [pkgs.xterm];
    libinput = {
      touchpad.disableWhileTyping = true;
    };
  };
}
