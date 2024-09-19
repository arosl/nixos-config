{
  config,
  lib,
  pkgs,
  username,
  storageDriver ? null,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  users.users.${username}.extraGroups = ["docker"];
  environment.systemPackages = [pkgs.docker-compose];
}
