{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { nixpkgs, home-manager, emacs-overlay, ... }: {
    nixosConfigurations = {
      abidingabi-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/abidingabi-desktop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abidingabi =
              import ./home-manager/home-desktop.nix;
          }

          ({ pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlay ]; })
        ];
      };

      abidingabi-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/abidingabi-laptop.nix
          ./nixos/restic.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abidingabi =
              import ./home-manager/home-laptop.nix;
          }
          ({ pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlay ]; })
        ];
      };
    };
  };
}
