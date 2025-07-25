{ pkgs, ... }:

{
  home-manager.users.abi = {
    home.packages = with pkgs; [
      ispell
      # LaTeX
      (texlive.combine {
        inherit (texlive)
          scheme-medium
          # These packages are needed for CalcTeX
          mathalpha soul amsmath adjustbox collectbox mathtools cancel

          # These packages are needed for fast previews
          preview mylatexformat

          # These packages are needed for Org Mode PDF exports
          wrapfig capt-of stix2-type1

          # These let us do nice graphics
          pgf tikz-cd;
      })
    ];

    programs.emacs = {
      enable = true;
      extraPackages = (epkgs: [ epkgs.vterm epkgs.mu4e ]);
    };

    services.emacs.enable = true;
    services.emacs.client.enable = true;

    xdg.configFile = {
      "doom" = {
        source = ./doom;
        recursive = true;
      };
    };
  };
}
