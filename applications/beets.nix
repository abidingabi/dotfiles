{ pkgs, ... }:

{
  hmModules = [{
    programs.beets = {
      enable = true;
      package = pkgs.beets-unstable;
      settings = {
        directory = "~/music";
        import.move = true;
        plugins = [ "fetchart" "lyrics" "web" "chroma" ];
      };
    };
  }];
}
