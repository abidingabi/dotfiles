{
  home-manager.users.abi = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
