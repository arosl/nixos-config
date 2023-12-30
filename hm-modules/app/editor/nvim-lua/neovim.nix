{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  #I'm configuring nvim with lua directly in .config/nvim but I will add system dependencies here
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override {fonts = ["Mononoki"];})
    gcc
    lua
    go
  ];

  #make sure nerdfonts is installed
  fonts.fontconfig.enable = true;
}
