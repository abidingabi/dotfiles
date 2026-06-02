{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        user = {
          name = "Abigail Goz";
          email = "abigail@dogbuilt.net";
        };

        aliases = { pushf = "push --force-with-lease"; };

        merge.ff = "only";
        branch.autosetuprebase = "always";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };

        init.defaultBranch = "main";

        github.user = "abidingabi";

        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        commit.gpgsign = true;
      };

      includes = [{
        condition = "gitdir:~/Work/AlphaROC/";
        contents = {
          user.email = "abigail@alpharoc.ai";
          commit.gpgsign = false;
          github.user = "alphaabigail";
          core.sshCommand = "ssh -i ~/.ssh/id_ed25519_alpharoc_github";
        };
      }];
    };
  };
}
