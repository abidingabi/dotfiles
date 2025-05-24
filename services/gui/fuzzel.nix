{
  home-manager.users.abi = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Fira Mono:14";
          use-bold = true;
        };

        colors = {
          # taken from doom-plain
          background = "ffffffff";
          selection = "f3f3f3ff";
          text = "969896ff";
          match = "444444ff";
          selection-match = "444444ff";
        };

        border = {
          width = 1;
          radius = 0;
        };
      };
    };
  };
}
