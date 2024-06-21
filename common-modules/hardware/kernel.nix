{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Kernel modules
  boot.kernelModules = ["i2c-dev" "i2c-piix4" "cpufreq_powersave"];
}
