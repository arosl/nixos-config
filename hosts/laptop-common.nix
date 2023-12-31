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
  sops-nix,
  ...
}: {
  imports = [
    ../common-modules/app/virtualization.nix
    ../common-modules/app/steam.nix
    ../common-modules/hardware/kernel.nix # Kernel config
    ../common-modules/security/blocklist.nix # Blocklist of known bad hosts
    ../common-modules/security/doas.nix # Use doas instead of sudo to reduce complexity
    ../common-modules/security/firewall.nix # Common firewall config, this might need to be moved
    ../common-modules/security/gpg.nix
    ../common-modules/security/sops-nix.nix
    ../common-modules/security/sshd.nix
    ../laptop-modules/hardware/bluetooth.nix #hardware config for bluetooth
    ../laptop-modules/hardware/opengl.nix
    ../laptop-modules/hardware/power.nix # Power management
    ../laptop-modules/hardware/printing.nix
    ../laptop-modules/style/stylix.nix
    ../laptop-modules/wm/hyprland.nix
    ../laptop-modules/wm/gnome.nix
  ];

  # Fix nix path
  nix = {
    # Ensure nix flakes are enabled
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # I'm sorry Stallman
  nixpkgs.config.allowUnfree = true;

  # Kernel modules
  boot.kernelModules = ["i2c-dev" "i2c-piix4" "cpufreq_powersave"];

  # Timezone and locale
  time.timeZone = timezone; # time zone
  i18n.defaultLocale = locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    cryptsetup
    git
    home-manager
    nftables
    sops
    vim
    wget
    zsh
  ];

  # I use zsh btw
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;

  #Simple programs not needing a separate file
  programs = {
    zsh.enable = true;
    mtr.enable = true;
  };

  #Simple services not needing a separate file
  services = {
    flatpak.enable = true;
    tailscale.enable = true;
  };

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
    ];
  };

  # It is ok to leave this unchanged for compatibility purposes
  system.stateVersion = "23.05";
}
