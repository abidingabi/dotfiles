{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.beets = {
      enable = true;
      package = pkgs.beets-unstable;
      settings = {
        directory = "~/music";
        import.move = true;
        plugins = [ "fetchart" "lyrics" "smartplaylist" ];
        smartplaylist = {
          relative_to = "~/music/.playlists";
          playlist_dir = "~/music/.playlists";
          playlists = [{
            name = "general-listening.m3u";
            query = "-album:soundtrack -generallistening:false";
          }];
        };
      };
    };
  };
}
