{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.vscode.enableUpdateCheck = false;
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # dracula-theme.theme-dracula
      bbenoist.nix
      dotenv.dotenv-vscode
      golang.go
      jdinhlife.gruvbox
      kamadorueda.alejandra
      ms-python.python
      ms-python.vscode-pylance
      yzhang.markdown-all-in-one
    ];
  };
}
