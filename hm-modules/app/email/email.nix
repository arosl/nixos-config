{
  config,
  lib,
  pkgs,
  home,
  sops,
  username,
  ...
}: let
  # Your sops secret variables
  emailAccounts = [
    {
      name = "email1";
      realName = "Name 1";
      email = sops.emails.email1.email;
      password = sops.emails.email1.password;
      smtpHost = sops.emails.email1.smtp_host;
      imapHost = sops.emails.email1.imap_host; # Make sure to define imap_host as well
    }
    {
      name = "email2";
      realName = "Name 2";
      email = sops.emails.email2.email;
      password = sops.emails.email2.password;
      smtpHost = sops.emails.email2.smtp_host;
      imapHost = sops.emails.email2.imap_host;
    }
    {
      name = "email3";
      realName = "Name 3";
      email = sops.emails.email3.email;
      password = sops.emails.email3.password;
      smtpHost = sops.emails.email3.smtp_host;
      imapHost = sops.emails.email3.imap_host;
    }
    {
      name = "email4";
      realName = "Name 4";
      email = sops.emails.email4.email;
      password = sops.emails.email4.password;
      smtpHost = sops.emails.email4.smtp_host;
      imapHost = sops.emails.email4.imap_host;
    }
  ];
in {
  home.programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch = {
    enable = true;
    hooks = {
      preNew = "mbsync --all";
    };
  };

  # Loop over email accounts and configure them
  accounts.email.accounts = builtins.listToAttrs (map (account: {
      name = account.name;
      value = {
        address = account.email;
        realName = account.realName;
        smtp.host = account.smtpHost;
        imap.host = account.imapHost;
        userName = account.email;
        passwordCommand = "echo ${account.password}"; # Use echo to fetch the password
        gpg = {
          signByDefault = false; # Example, you can modify based on your needs
        };
        mbsync = {
          enable = true;
          create = "maildir"; # Create maildir structure
        };
        msmtp.enable = true;
        notmuch.enable = true;
      };
    })
    emailAccounts);
}
