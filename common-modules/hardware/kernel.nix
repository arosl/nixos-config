{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
  
  # Kernel modules
  boot.kernelModules = ["i2c-dev" "i2c-piix4" "cpufreq_powersave"];
}
