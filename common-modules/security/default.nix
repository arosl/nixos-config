{ config, pkgs, ... }:
{
  imports = [
    ./blocklist.nix
    ./doas.nix
    ./firejail.nix
    ./firewall.nix
    ./gpg.nix
    ./sops-nix.nix
    ./sshd.nix
    ./wireguard.nix
  ];
}
