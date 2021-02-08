{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    home-manager.url = "github:nix-community/home-manager/release-20.09";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { nixpkgs, home-manager, emacs-overlay, ... }: {
    nixosConfigurations = {
      dansman805-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/dansman805-desktop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dansman805 = import ./home-manager/home-desktop.nix;
          }

          ({ pkgs, ... }: {
            nixpkgs.overlays = [ emacs-overlay.overlay ];
          })
        ];
      };

      dansman805-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/dansman805-laptop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dansman805 = import ./home-manager/home-laptop.nix;
          }

          ({ pkgs, ... }: {
            nixpkgs.overlays = [ emacs-overlay.overlay ];
          })
        ];
      };
    };
  };
}
