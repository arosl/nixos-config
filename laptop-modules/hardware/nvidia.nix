{
  config,
  lib,
  pkgs,
  ...
}: {
  # Load nvidia driver on xOrg or Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      # power management not suppored by mx150
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      
      # setting this to false to see if this solves 
      # https://github.com/hyprwm/Hyprland/issues/1728
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        #we want to just run nvidia with offload
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Correct Bus ID for thinkpad 480
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  # enable nivida for hyprland
  programs.hyprland.enableNvidiaPatches = true;
}
