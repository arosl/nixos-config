# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  lib,
  pkgs,
  blocklist-hosts,
  username,
  name,
  hostname,
  timezone,
  locale,
  wm,
  theme,
  sshkey_public,
  ...
}: {
  imports = [
    ../laptop-common.nix #shared config between laptops
    ../../laptop-modules/hardware/nvidia.nix #nvidia config for newer cards
    ./hardware-configuration.nix
    ./security/wireguard.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.memtest86.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = hostname; # Define your hostname.
    networkmanager.enable = true; # Use networkmanager
    enableIPv6 = false; #disabled for now as it bypasses wg routes when on ipv6
    hosts = {
      "127.0.0.1" = ["arianesline.com" "arianesline.azurewebsites.net"];
    };
  };

  # User account
  users.users = {
    andreas = {
      isNormalUser = true;
      description = "Andreas";
      extraGroups = ["networkmanager" "wheel" "dialout"];
      packages = with pkgs; [];
      uid = 1000;
    };
    romy = {
      isNormalUser = true;
      description = "Romy";
      extraGroups = ["networkmanager"];
      packages = with pkgs; [];
      uid = 1001;
    };
  };
}
