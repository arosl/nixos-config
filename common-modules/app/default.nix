{ config, pkgs, ... }:
let
  inherit (pkgs) docker steam virtualization;
in {
  # Import individual modules
  imports = [
    ./docker.nix
    ./steam.nix
    ./virtualization.nix
  ];
}
