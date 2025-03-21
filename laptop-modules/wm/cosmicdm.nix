{
  lib,
  pkgs,
  ...
}: {
  imports = [
    #    ./cosmic-greeter.nix
    ./gdm.nix
  ];
  services.desktopManager = {
    cosmic.enable = true;
  };
}
