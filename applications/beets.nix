{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.beets = {
      enable = true;
      package = pkgs.beets-unstable;
      settings = {
        directory = "~/music";
        import.move = true;
        plugins = [ "fetchart" "lyrics" ];
      };
    };
  };
}
