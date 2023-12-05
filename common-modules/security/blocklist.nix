{
  config,
  blocklist-hosts,
  pkgs,
  ...
}: let
  blocklist = builtins.readFile "${blocklist-hosts}/hosts";
in {
  networking.extraHosts = ''
    "${blocklist}"
  '';
}
