{ pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
  services.pulseaudio.support32Bit = true;
  programs.steam.enable = true;
}
