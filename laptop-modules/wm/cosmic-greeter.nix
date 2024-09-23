{
  lib,
  pkgs,
  ...
}: {
  services.displayManager = {
    cosmic-greeter.enable = true;
  };
}
