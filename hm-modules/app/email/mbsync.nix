{
  config,
  pkgs,
  lib,
  secrets,
  ...
}: let
  # Define a list of email accounts based on your secrets.yaml
  emailAccounts = [
    {
      name = "email1";
      email = secrets.emails.email1.email;
      password = secrets.emails.email1.password;
      imapHost = secrets.emails.email1.imap_host;
      smtpHost = secrets.emails.email1.smtp_host;
    }
    {
      name = "email2";
      email = secrets.emails.email2.email;
      password = secrets.emails.email2.password;
      imapHost = secrets.emails.email2.imap_host;
      smtpHost = secrets.emails.email2.smtp_host;
    }
    {
      name = "email3";
      email = secrets.emails.email3.email;
      password = secrets.emails.email3.password;
      imapHost = secrets.emails.email3.imap_host;
      smtpHost = secrets.emails.email3.smtp_host;
    }
    {
      name = "email4";
      email = secrets.emails.email4.email;
      password = secrets.emails.email4.password;
      imapHost = secrets.emails.email4.imap_host;
      smtpHost = secrets.emails.email4.smtp_host;
    }
  ];

  # Generate mbsync account configurations
  mbsyncConfig = lib.concatStringsSep "\n" (map (
      account: ''
        IMAPAccount ${account.name}
        Host ${account.imapHost}
        User ${account.email}
        Pass ${account.password}
        SSLType IMAPS
        AuthMechs LOGIN

        MaildirStore ${account.name}-mail
        Path ~/Mail/${account.name}
        Inbox ~/Mail/${account.name}/Inbox
        Trash ~/Mail/${account.name}/Trash

        Channel ${account.name}
        Master :${account.name}-mail:
        Subscriptions *
        Patterns *
        Create Both
        Sync All
        Expunge Both
        Push
      ''
    )
    emailAccounts);
in {
  programs.mbsync = {
    enable = true;
    config = mbsyncConfig;
    enableAtLogin = true;
    # Optionally, set up logging
    extraOptions = ''
      Logfile ~/.mbsync.log
      # Set log level if desired
      LogLevel DEBUG
    '';
  };

  # Ensure mail directories exist and have correct permissions
  home.file.".mbsyncrc".text = mbsyncConfig;
}
