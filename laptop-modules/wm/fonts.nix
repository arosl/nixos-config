{
  config,
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.inconsolata
    nerd-fonts.mononoki
    font-awesome
    google-fonts
    iosevka
    powerline
    powerline-fonts
    terminus_font
    ubuntu_font_family
  ];
}
