{ pkgs, ... }:

{
  hmModules = [{
    home.packages = with pkgs; [
      ispell
      # LaTeX
      (texlive.combine {
        inherit (texlive)
          scheme-medium
          # These packages are needed for CalcTeX
          mathalpha soul amsmath adjustbox collectbox mathtools cancel

          # These packages are needed for Org Mode PDF exports
          wrapfig capt-of

          stix2-type1;
      })
    ];

    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtk;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };

    services.emacs.enable = true;
    services.emacs.client.enable = true;

    xdg.configFile = {
      "doom" = {
        source = ./doom;
        recursive = true;
      };
    };
  }];
}
