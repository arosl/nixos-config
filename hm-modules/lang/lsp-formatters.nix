{
pkgs,
config,
...
  }: {


  home.packages = with pkgs; [
    efm-langserver
    eslint_d
    hadolint
    lua
    lua-language-server
    lua54Packages.luacheck
    nixd
    nodePackages_latest.fixjson
    prettierd
    pyright
    python311Packages.black
    python311Packages.flake8
    rnix-lsp
    shellcheck
    statix
    stylua
    vscode-langservers-extracted
  ];
 }