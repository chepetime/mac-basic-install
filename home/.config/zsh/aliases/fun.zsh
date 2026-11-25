# Weather and exchange rate history

# Settings — set these in ~/.zshrc.local:
#   export WEATHER_CITY="Lisbon"      # empty = location from your IP
#   export HOME_CURRENCY="EUR"        # target currency for conversions
: ${HOME_CURRENCY:=USD}

# Weather (metric)
weather() { local c="${1:-$WEATHER_CITY}"; curl -m 5 -s "wttr.in/${c// /+}?format=3&m" || echo "Weather service unavailable"; }

# Rate history for the last N days (usage: ratehistory usd 7)
ratehistory() {
  local from="${${1:-USD}:u}" days="${2:-7}"
  local end=$(date +%Y-%m-%d) start=$(date -v-"${days}"d +%Y-%m-%d)
  curl -s "https://api.frankfurter.dev/v1/${start}..${end}?from=${from}&to=${HOME_CURRENCY}" | \
    jq -r --arg t "$HOME_CURRENCY" '.rates | to_entries | sort_by(.key)[] | "\(.key): \(.value[$t]) \($t)"'
}
