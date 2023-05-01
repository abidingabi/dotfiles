{
  # enables nixpkgs fish completions, as well as integration with e.g. fzf
  programs.fish.enable = true;

  hmModules = [{
    programs.fish = {
      enable = true;

      shellInit = "set -x EDITOR 'vim'";

      functions = {
        fish_greeting = "";
        fish_prompt = ''
          test $SSH_TTY
               and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
          test "$USER" = 'root'
               and echo (set_color red)"#"

          # Main
          echo -n (set_color cyan)(prompt_pwd) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
        '';

        upload_file = "curl http://0x0.st -F 'file=@'$argv";
      };
    };
  }];
}
