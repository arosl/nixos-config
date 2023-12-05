{
  config,
  pkgs,
  username,
  sshkey_public,
  ...
}: {
  # Enable incoming ssh
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  users.users.${username}.openssh.authorizedKeys.keys = [
    sshkey_public
  ];
}
