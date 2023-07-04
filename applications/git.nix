{ pkgs, ... }:

{
  hmModules = [{
    programs.git = {
      enable = true;

      userName = "Abigail";
      userEmail = "abigail@dogbuilt.net";

      ignores = [ "*~" "*.swp" ".envrc" ];

      aliases = { pushf = "push --force-with-lease"; };

      extraConfig = {
        merge.ff = "only";
        branch.autosetuprebase = "always";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };

        init.defaultBranch = "main";

        github.user = "abidingabi";

        mailmap.file = toString (pkgs.writeText "mailmap" ''
          Abigail <abigail@dogbuilt.net>
          Abigail <abigail@dogbuilt.net> <daniel@dgoz.net>
          Abigail <abigail@dogbuilt.net> <dansman805@gmail.com>
        '');
      };
    };
  }];
}
