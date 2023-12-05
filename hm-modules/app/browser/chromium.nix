{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.chromium.enable = true;
  programs.chromium.extensions = [
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark-reader
    "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin - Mocha
  ];
}
