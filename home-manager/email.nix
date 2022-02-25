{ pkgs, ... }:

{
  programs.mbsync.enable = true;
  services.mbsync = {
    enable = true;
    postExec = "${pkgs.mu}/bin/mu index";
  };

  programs.mu.enable = true;
  programs.msmtp.enable = true;

  accounts.email = {
    maildirBasePath = ".mail";

    accounts.abigail = {
      address = "abigail@dogbuilt.net";
      userName = "abigail@dogbuilt.net";
      primary = true;
      realName = "Abigail";

      imap.host = "imap.migadu.com";
      imap.port = 993;

      smtp.host = "smtp.migadu.com";
      smtp.port = 465;

      mbsync = {
        enable = true;
        create = "maildir";
      };

      msmtp.enable = true;
      mu.enable = true;

      passwordCommand =
        "${pkgs.coreutils}/bin/cat ~/.local/share/email/abigail-password";
    };
  };
}
