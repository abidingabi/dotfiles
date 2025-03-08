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

        paths = {
          default = "$albumartist/$album%aunique{}/$track $title";
          singleton = "$artist/singles/$title";
          comp = "Compilations/$album%aunique{}/$track $title";
        };
      };
    };
  };
}
