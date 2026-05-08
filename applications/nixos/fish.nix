{
  imports = [ ../home/fish.nix ];

  # enables nixpkgs fish completions, as well as integration with e.g. fzf
  programs.fish.enable = true;
  # needed for ,
  programs.command-not-found.enable = true;
}
