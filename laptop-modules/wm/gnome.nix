{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./gdm.nix
  ];
  services = {
    xserver.desktopManager.gnome.enable = false;
  };

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      geary # email reader
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  environment.systemPackages = with pkgs; [
    gnomeExtensions.pop-shell
    ulauncher
  ];

  services.power-profiles-daemon.enable = false;
  services.pulseaudio.enable = false;
}
