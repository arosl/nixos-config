{
  config,
  pkgs,
  ...
}: {
  # Firewall
  networking.nftables.enable = true;
  networking.firewall.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
