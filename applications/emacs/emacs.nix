{ pkgs, ... }:

{
  hmModules = [{
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
