{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkSystem = system: hostName:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./devices/base.nix
            ./devices/${hostName}.nix
            { networking.hostName = hostName; }
          ];
          specialArgs = { inherit inputs; };
        };
    in {
      nixosConfigurations = {
        allium = mkSystem "x86_64-linux" "allium"; # a graphical vm
        poppy = mkSystem "x86_64-linux" "poppy"; # a laptop
      };
    };
}
