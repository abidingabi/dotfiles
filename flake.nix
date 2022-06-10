{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, emacs-overlay, ... }: {
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

      abidingabi-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/abidingabi-laptop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abidingabi =
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
