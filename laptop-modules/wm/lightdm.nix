{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    displayManager = {
      lightdm.enable = true;
      sessionCommands = ''
        xset -dpms
        xset s blank
        xset r rate 350 50
        xset s 300
        ${pkgs.lightlocker}/bin/light-locker --idle-hint &
      '';
    };
  };
}
