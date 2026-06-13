{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.beets = {
      enable = true;
      # see https://github.com/arximboldi/dotfiles/blob/42f44ae499356120957b375146c1325b60703914/nix/os/common/desktop.nix#L103
      settings = {
        directory = "~/music";
        import.move = true;
        plugins = [
          "fetchart"
          "lyrics"
          "musicbrainz"
        ];

        paths = {
          default = "$albumartist/$album%aunique{}/$track $title";
          singleton = "$artist/singles/$title";
          comp = "Compilations/$album%aunique{}/$track $title";
        };

        lyrics.synced = true;
      };
    };
  };
}
