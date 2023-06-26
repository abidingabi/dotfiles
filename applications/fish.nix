{
  # enables nixpkgs fish completions, as well as integration with e.g. fzf
  programs.fish.enable = true;

  hmModules = [{
    programs.fish = {
      enable = true;

      shellInit = ''
        set -x EDITOR 'vim'

        # workaround for https://github.com/kovidgoyal/kitty/issues/713
        if [ $TERM = "xterm-kitty" ]
          set TERM "xterm-256color"
        end
      '';

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

        # FIRST-related APIs
        query_ftc_events = ''
          set FTC_EVENTS_KEY (cat ~/ftc-events.key)
          set BASE_API_URL "https://ftc-api.firstinspires.org/v2.0"
          curl -H 'Accept:application/json' -H "Authorization: Basic $FTC_EVENTS_KEY" "$BASE_API_URL/$argv"
        '';

        query_frc_events = ''
          set FRC_EVENTS_KEY (cat ~/frc-events.key)
          set BASE_API_URL "https://frc-api.firstinspires.org/v2.0"
          curl -H 'Accept:application/json' -H "Authorization: Basic $FRC_EVENTS_KEY" "$BASE_API_URL/$argv"
        '';

        query_toa = ''
          set TOA_KEY (cat ~/theorangealliance.key)
          curl -H "X-TOA-Key:$TOA_KEY" -H "Content-Type:application/json" -H "X-Application-Origin:abidingabi-interactive-api-usage" "https://theorangealliance.org/api/$argv"
        '';
      };
    };
  }];
}
