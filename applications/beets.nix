{ pkgs, ... }:

{
  home-manager.users.abi = {
    programs.beets = {
      enable = true;
      # see https://github.com/arximboldi/dotfiles/blob/42f44ae499356120957b375146c1325b60703914/nix/os/common/desktop.nix#L103
      package = let
        beetcamp = (pkgs.python3Packages.buildPythonApplication {
          pname = "beets-beetcamp";
          version = "0.21.0";
          src = pkgs.fetchFromGitHub {
            repo = "beetcamp";
            owner = "snejus";
            rev = "64c7afc9d87682fb2b7c9f2deb76525e44afb248";
            sha256 = "sha256-d0yvOyfxPPBUpoO6HCWfMq2vVw+CcQo16hx+JRDMkBw=";
          };
          format = "pyproject";
          buildInputs = with pkgs.python3Packages; [ poetry-core ];
          propagatedBuildInputs = with pkgs.python3Packages; [
            setuptools
            requests
            cached-property
            pycountry
            dateutil
            ordered-set
          ];
          checkInputs = with pkgs.python3Packages;
            [
              # pytestCheckHook
              pytest-cov
              pytest-randomly
              pytest-lazy-fixture
              rich
              tox
              types-setuptools
              types-requests
            ] ++ [ pkgs.beets ];
          meta = {
            homepage = "https://github.com/snejus/beetcamp";
            description = "Bandcamp autotagger plugin for beets.";
            license = pkgs.lib.licenses.gpl2;
            inherit (pkgs.beets.meta) platforms;
            maintainers = with pkgs.lib.maintainers; [ rrix ];
          };
        });

      in pkgs.beets-unstable.override {
        pluginOverrides = {
          beetcamp = {
            enable = true;
            propagatedBuildInputs = [ beetcamp ];
          };
        };
      };
      settings = {
        directory = "~/music";
        import.move = true;
        plugins = [ "bandcamp" "fetchart" "lyrics" ];

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
