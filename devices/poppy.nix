{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")

    ../services/gui/gui.nix
    ../services/tailscale.nix

    ../applications/home/emacs/emacs.nix
    ../applications/home/fish.nix
    ../applications/home/git.nix

    ../applications/home/kitty.nix
  ];

  virtualisation.qemu.options = [ "-vga qxl" ];

  # I like being able to log into my vms
  users.users.abi.password = "password";
}
