{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cosmic-greeter.nix
  ];
  services.desktopManager = {
    cosmic.enable = true;
  };
}
