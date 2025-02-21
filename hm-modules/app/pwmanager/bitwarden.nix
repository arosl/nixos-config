{
  pkgs,
  secrets,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      base_url = secrets.bitwarden.host1.base_url;
      email = secrets.bitwarden.host1.email;
    };
  };
}
