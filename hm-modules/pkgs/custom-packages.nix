{ pkgs, ... }: {
  deco = import ./deco/default.nix { inherit pkgs; };
  mnemo-tools = import ./mnemo-tools/default.nix { inherit pkgs; };
}
