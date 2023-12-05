{
  config,
  pkgs,
  sops-nix,
  username,
  ...
}: {
  #import sops-nix
  imports = [
    sops-nix.nixosModules.sops
  ];

  #sops setup
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
}
