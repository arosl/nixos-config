{
  config,
  pkgs,
  lib,
  ...
}: let
  # Import the vscode-utils
  vscode-utils = import "${pkgs.vscode-utils}/default.nix" {
    inherit (pkgs) stdenv fetchurl unzip;
  };

  # Fetch the Puppet extension
  myPuppetVscode = vscode-utils.extensionsFromVscodeMarketplace {
    pname = "puppet-vscode";
    version = "1.5.0";
    sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with the correct hash
    publisher = "puppet";
    extensionId = "puppet-vscode";
  };
in {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      # amirha.better-comments-2
      # dracula-theme.theme-dracula
      # myPuppetVscode
      bbenoist.nix
      dotenv.dotenv-vscode
      esbenp.prettier-vscode
      golang.go
      jdinhlife.gruvbox
      kamadorueda.alejandra
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-ssh
      ms-vsliveshare.vsliveshare
      tabnine.tabnine-vscode
      yzhang.markdown-all-in-one
    ];
  };
}
