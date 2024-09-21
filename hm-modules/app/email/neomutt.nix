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
      smtpHost = secrets.emails.email1.smtp_host;
    }
    {
      name = "email2";
      email = secrets.emails.email2.email;
      password = secrets.emails.email2.password;
      smtpHost = secrets.emails.email2.smtp_host;
    }
    {
      name = "email3";
      email = secrets.emails.email3.email;
      password = secrets.emails.email3.password;
      smtpHost = secrets.emails.email3.smtp_host;
    }
    {
      name = "email4";
      email = secrets.emails.email4.email;
      password = secrets.emails.email4.password;
      smtpHost = secrets.emails.email4.smtp_host;
    }
  ];
in {
  programs.neomutt = {
    enable = true;

    # General Neomutt settings
    mailboxes =
      lib.concatMapStringsSep "\n" (
        account: "+${account.name}/Inbox"
      )
      emailAccounts;

    set = {
      realname = "Andreas";
      folder = "~/Mail";
      spoolfile = "+Inbox";
      record = "+Sent";
      postponed = "+Drafts";
      header_cache = "~/.cache/neomutt/cache/headers";
      message_cachedir = "~/.cache/neomutt/cache/bodies";
      certificate_file = "~/.cache/neomutt/certificates";
      move = "ask"; # Prompt before moving messages
      # Additional common settings
      imap_keepalive = "900";
      imap_passive = "yes";
      # Adjust as needed
    };

    # SMTP settings and account-specific configurations
    extraConfig =
      lib.concatMapStringsSep "\n" (
        account: ''
          # SMTP configuration for ${account.name}
          set smtp_url_${account.name} = "smtp://${account.smtpHost}/"
          set smtp_pass_${account.name} = "${account.password}"

          # Account hook to set 'from' and SMTP settings
          account-hook ${account.email} "
            set from=${account.email}
            set realname='Andreas'
            set smtp_url='smtp://${account.smtpHost}/'
            set smtp_pass='${account.password}'
          "
        ''
      )
      emailAccounts;
  };
}
