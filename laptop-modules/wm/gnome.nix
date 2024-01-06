{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      displayManager.gdm ={ 
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };
  };

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
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

  services.power-profiles-daemon.enable = false;
  hardware.pulseaudio.enable = false;
}
