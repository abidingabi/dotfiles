{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
  hardware.pulseaudio.support32Bit = true;
  programs.steam.enable = true;
}
