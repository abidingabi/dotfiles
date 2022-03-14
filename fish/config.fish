set -x EDITOR "vim"
set -x VISUAL "emacsclient -c"

# Convenience functions
function upload_file
	curl http://0x0.st -F'file=@'$argv
end

# FIRST-related APIs
function query_ftc_events
    set FTC_EVENTS_KEY (cat ~/ftc-events.key)
    set BASE_API_URL "https://ftc-api.firstinspires.org/v2.0"

    curl -H 'Accept:application/json' -H "Authorization: Basic $FTC_EVENTS_KEY" "$BASE_API_URL/$argv"
end

function query_frc_events
    set FRC_EVENTS_KEY (cat ~/frc-events.key)
    set BASE_API_URL "https://frc-api.firstinspires.org/v2.0"

    curl -H 'Accept:application/json' -H "Authorization: Basic $FRC_EVENTS_KEY" "$BASE_API_URL/$argv"
end

function get_TOA_data
	set TOA_KEY (cat /home/dansman805/theorangealliance.key)
	curl -H "X-TOA-Key:$TOA_KEY" -H "Content-Type:application/json" -H "X-Application-Origin:dansman805-interactive-api-usage" "https://theorangealliance.org/api/$argv"
end

