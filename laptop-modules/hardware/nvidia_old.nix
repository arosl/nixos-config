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
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      # mx150 not supported by open
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
}
