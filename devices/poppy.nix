{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")

    ../services/gui.nix
    ../services/tailscale.nix

    ../applications/emacs/emacs.nix
    ../applications/fish.nix
    ../applications/git.nix

    ../applications/kitty.nix
  ];

  virtualisation.qemu.options = [ "-vga qxl" ];

  # I like being able to log into my vms
  users.users.abi.password = "password";
}
