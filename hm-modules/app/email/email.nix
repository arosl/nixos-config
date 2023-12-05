{
  pkgs,
  config,
  ...
}: {


  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };
  };

  #WIP not finished
  accounts.email = {
    accounts.fastmail = {
      address = "cat ${config.sops.secrets.fastmail.address.path}";
      imap.host = "imap.fastmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      notmuch.enable = true;
      primary = true;
      realName = "Andreas Rosland";
      passwordCommand = "cat ${config.sops.secrets.fastmail.password.path}";
      smtp = {
        host = "smtp.fastmail.com";
      };
      userName = config.sops.secrets.fastmail.address;
    };
  };

}
