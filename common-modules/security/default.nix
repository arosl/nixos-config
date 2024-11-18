{ config, pkgs, ... }:
{
  imports = [
    ./blocklist.nix
    ./firejail.nix
    ./firewall.nix
    ./gpg.nix
    ./sops-nix.nix
    ./sshd.nix
  ];
}
