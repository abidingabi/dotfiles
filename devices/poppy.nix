{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")

    ../services/nixos/gui/gui.nix
    ../services/nixos/tailscale.nix

    ../applications/home/emacs/emacs.nix
    ../applications/nixos/fish.nix
    ../applications/home/git.nix

    ../applications/home/kitty.nix
  ];

  virtualisation.qemu.options = [ "-vga virtio" ];

  # I like being able to log into my vms
  users.users.abi.password = "password";
}
