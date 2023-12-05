{
  config,
  pkgs,
  ...
}: {
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    (nerdfonts.override {fonts = ["Inconsolata" "Mononoki"];})
    font-awesome
    google-fonts
    inconsolata
    inconsolata-nerdfont
    iosevka
    powerline
    powerline-fonts
    terminus_font
    ubuntu_font_family
  ];
}
