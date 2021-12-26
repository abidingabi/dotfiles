{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, emacs-overlay, ... }: {
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
            home-manager.users.dansman805 =
              import ./home-manager/home-desktop.nix;
          }

          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              emacs-overlay.overlay
              (self: super: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              })
            ];
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
            home-manager.users.dansman805 =
              import ./home-manager/home-laptop.nix;
          }
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              emacs-overlay.overlay
              (self: super: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              })
            ];
          })
        ];
      };
    };
  };
}
