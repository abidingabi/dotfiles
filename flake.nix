{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { nixpkgs, home-manager, emacs-overlay, ... }: {
    nixosConfigurations = {
      orchid = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/orchid.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abi = import ./home-manager/home-desktop.nix;
          }

          { nix.registry.nixpkgs.flake = nixpkgs; }
          ({ pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlay ]; })
        ];
      };

      allium = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/allium.nix
          ./nixos/restic.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.abi = import ./home-manager/home-laptop.nix;
          }

          { nix.registry.nixpkgs.flake = nixpkgs; }
          ({ pkgs, ... }: { nixpkgs.overlays = [ emacs-overlay.overlay ]; })
        ];
      };
    };
  };
}
