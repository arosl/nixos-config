{
  config,
  pkgs,
  ...
}: {
  # Enable printing
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
