function query_ftc_events
    set FTC_EVENTS_KEY (cat ~/ftc-events.key)
    set BASE_API_URL "https://ftc-api.firstinspires.org/v2.0"

    curl -H 'Accept:application/json' -H "Authorization: Basic $FTC_EVENTS_KEY" "$BASE_API_URL/$argv"
end
