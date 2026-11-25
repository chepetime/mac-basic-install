# Settings — set these in ~/.zshrc.local:
#   export WEATHER_CITY="Lisbon"      # empty = location from your IP
#   export HOME_CURRENCY="EUR"        # target currency for conversions
: ${HOME_CURRENCY:=USD}

# Weather (metric)
weather() { local c="${1:-$WEATHER_CITY}"; curl -m 5 -s "wttr.in/${c// /+}?format=3&m" || echo "Weather service unavailable"; }
wttr() { local c="${1:-$WEATHER_CITY}"; curl -m 10 -s "wttr.in/${c// /+}?m" || echo "Weather service unavailable"; }
moon() { curl -m 10 -s "wttr.in/Moon" || echo "Weather service unavailable"; }

# Random fun
alias joke='curl -s https://icanhazdadjoke.com/ -H "Accept: text/plain"'
alias advice='curl -s https://api.adviceslip.com/advice | jq -r .slip.advice'
alias fortune='curl -s https://api.quotable.io/random | jq -r "\"\\\"\" + .content + \"\\\" - \" + .author"'
alias chucknorris='curl -s https://api.chucknorris.io/jokes/random | jq -r .value'
alias catfact='curl -s https://catfact.ninja/fact | jq -r .fact'
alias uselessfact='curl -s https://uselessfacts.jsph.pl/random.json?language=en | jq -r .text'
alias bored='curl -s https://bored-api.appbrewery.com/random | jq -r ".activity + \" (Type: \" + .type + \")\""'

# Define a word
define() { curl -s "dict://dict.org/d:$1"; }

# QR code generator (usage: qr "text")
qr() { curl -s "qrcode.show/$1"; }

# Crypto prices
alias btc='curl -s rate.sx/btc'
alias eth='curl -s rate.sx/eth'
crypto() { curl -s "rate.sx/${1:-btc}"; }

# Currency conversion to $HOME_CURRENCY (usage: currency usd)
currency() {
  local from="${${1:-USD}:u}"
  curl -s "https://api.frankfurter.dev/v1/latest?from=${from}&to=${HOME_CURRENCY}" | \
    jq -r --arg t "$HOME_CURRENCY" '"\(.date): 1 \(.base) = \(.rates[$t]) \($t)"'
}

# Watch a rate, refresh every 30 s (Ctrl+C to stop). Usage: watchrate usd
watchrate() { while true; do clear; date; currency "$1"; sleep 30; done }

# Rate history for the last N days (usage: ratehistory usd 7)
ratehistory() {
  local from="${${1:-USD}:u}" days="${2:-7}"
  local end=$(date +%Y-%m-%d) start=$(date -v-"${days}"d +%Y-%m-%d)
  curl -s "https://api.frankfurter.dev/v1/${start}..${end}?from=${from}&to=${HOME_CURRENCY}" | \
    jq -r --arg t "$HOME_CURRENCY" '.rates | to_entries | sort_by(.key)[] | "\(.key): \(.value[$t]) \($t)"'
}

# -----------------------------------------------------------------------------
# ASCII / Visual
# -----------------------------------------------------------------------------

# Party parrot animation
parrot() {
  curl -s parrot.live
}

# Terminal color test
colors() {
  for i in {0..255}; do
    printf "\e[38;5;${i}m%3d " $i
    (( (i + 1) % 16 == 0 )) && echo
  done
  echo -e "\e[0m"
}

# Matrix rain effect (Ctrl+C to stop)
matrix() {
  echo "Press Ctrl+C to exit"
  cmatrix 2>/dev/null || {
    # Fallback if cmatrix not installed
    while true; do
      printf "\e[32m%s\e[0m" "$(head -c 1 /dev/urandom | od -An -tx1 | tr -d ' ')"
      sleep 0.05
    done
  }
}

# Star Wars ASCII movie
alias starwars='telnet towel.blinkenlights.nl'

# ASCII art (requires figlet or toilet)
ascii() { figlet -f slant "$@" 2>/dev/null || toilet "$@" 2>/dev/null || echo "$@"; }

# -----------------------------------------------------------------------------
# Random Content
# -----------------------------------------------------------------------------

# Random trivia question
trivia() {
  local data=$(curl -s "https://opentdb.com/api.php?amount=1&type=multiple")
  echo "$data" | jq -r '.results[0] | "Category: \(.category)\nQ: \(.question | @html)\nA: \(.correct_answer | @html)"' | sed 's/&quot;/"/g; s/&#039;/'\''/g; s/&amp;/\&/g'
}

# Random xkcd comic
xkcd() {
  local num=${1:-$(shuf -i 1-2900 -n 1)}
  local data=$(curl -s "https://xkcd.com/$num/info.0.json")
  echo "$data" | jq -r '"#\(.num): \(.title)\n\(.alt)\nURL: https://xkcd.com/\(.num)"'
}

# Top Hacker News stories
hn() {
  local count=${1:-5}
  echo "Top $count Hacker News stories:"
  curl -s "https://hacker-news.firebaseio.com/v0/topstories.json" | \
    jq -r ".[:$count][]" | \
    while read id; do
      curl -s "https://hacker-news.firebaseio.com/v0/item/$id.json" | \
        jq -r '"\(.score)pts | \(.title)"'
    done
}

# Today in history
today() {
  local month=$(date +%-m)
  local day=$(date +%-d)
  curl -s "https://history.muffinlabs.com/date/$month/$day" | \
    jq -r '.data.Events[:5][] | "\(.year): \(.text)"'
}

# -----------------------------------------------------------------------------
# Generators
# -----------------------------------------------------------------------------

# Random password (default 16 chars)
randpw() {
  local len=${1:-16}
  LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c "$len"
  echo
}

# Random number (default 1-100)
randnum() {
  local min=${1:-1}
  local max=${2:-100}
  echo $((RANDOM % (max - min + 1) + min))
}

# Lorem ipsum generator
lorem() {
  local paragraphs=${1:-1}
  curl -s "https://loripsum.net/api/$paragraphs/short/plaintext"
}

# Kaomoji to clipboard
alias shrug='echo "¯\_(ツ)_/¯" | pbcopy && echo "¯\_(ツ)_/¯ copied!"'
alias flip='echo "(╯°□°)╯︵ ┻━┻" | pbcopy && echo "(╯°□°)╯︵ ┻━┻ copied!"'
alias unflip='echo "┬─┬ノ( º _ ºノ)" | pbcopy && echo "┬─┬ノ( º _ ºノ) copied!"'
alias lenny='echo "( ͡° ͜ʖ ͡°)" | pbcopy && echo "( ͡° ͜ʖ ͡°) copied!"'
alias disapprove='echo "ಠ_ಠ" | pbcopy && echo "ಠ_ಠ copied!"'

# -----------------------------------------------------------------------------
# Timers
# -----------------------------------------------------------------------------

# Countdown timer (usage: countdown 60)
countdown() {
  local secs=${1:-10}
  while [ $secs -gt 0 ]; do
    printf "\r%02d:%02d" $((secs/60)) $((secs%60))
    sleep 1
    ((secs--))
  done
  printf "\r00:00\n"
  echo -e "\a"  # terminal bell
  osascript -e 'display notification "Timer finished!" with title "Countdown"' 2>/dev/null
}

# Pomodoro timer (25 min work, optional break)
pomodoro() {
  echo "Pomodoro started (25 minutes)..."
  countdown 1500
  osascript -e 'display notification "Take a 5 minute break!" with title "Pomodoro Complete"' 2>/dev/null
  echo "Time for a break!"
}

# Stopwatch
stopwatch() {
  echo "Stopwatch started. Press Ctrl+C to stop."
  local start=$(date +%s)
  while true; do
    local elapsed=$(($(date +%s) - start))
    printf "\r%02d:%02d:%02d" $((elapsed/3600)) $((elapsed%3600/60)) $((elapsed%60))
    sleep 1
  done
}

# -----------------------------------------------------------------------------
# Mini Games / Random
# -----------------------------------------------------------------------------

# Flip a coin
coin() {
  if (( RANDOM % 2 )); then
    echo "Heads"
  else
    echo "Tails"
  fi
}

# Roll dice (default 6 sides)
dice() {
  local sides=${1:-6}
  echo $((RANDOM % sides + 1))
}

# Magic 8 ball
8ball() {
  local answers=(
    "It is certain"
    "It is decidedly so"
    "Without a doubt"
    "Yes definitely"
    "You may rely on it"
    "As I see it, yes"
    "Most likely"
    "Outlook good"
    "Yes"
    "Signs point to yes"
    "Reply hazy, try again"
    "Ask again later"
    "Better not tell you now"
    "Cannot predict now"
    "Concentrate and ask again"
    "Don't count on it"
    "My reply is no"
    "My sources say no"
    "Outlook not so good"
    "Very doubtful"
  )
  echo "${answers[$((RANDOM % ${#answers[@]}))]}"
}

# Rock paper scissors
rps() {
  local choices=("rock" "paper" "scissors")
  local computer=${choices[$((RANDOM % 3))]}
  echo -n "Your choice (rock/paper/scissors): "
  read player
  player=${player:l}
  echo "Computer chose: $computer"
  if [[ "$player" == "$computer" ]]; then
    echo "It's a tie!"
  elif [[ ("$player" == "rock" && "$computer" == "scissors") || \
          ("$player" == "paper" && "$computer" == "rock") || \
          ("$player" == "scissors" && "$computer" == "paper") ]]; then
    echo "You win!"
  else
    echo "You lose!"
  fi
}

# -----------------------------------------------------------------------------
# More Content
# -----------------------------------------------------------------------------

# Shakespearean insult
insult() {
  curl -s https://evilinsult.com/generate_insult.php?lang=en
  echo
}

# Random compliment
compliment() {
  local compliments=(
    "You're an awesome person!"
    "You're doing great!"
    "You have a great sense of humor!"
    "You're making a difference!"
    "You're more helpful than you realize!"
    "You bring out the best in people!"
    "You're a great listener!"
    "You have impeccable taste!"
    "You're really talented!"
    "You have the best ideas!"
  )
  echo "${compliments[$((RANDOM % ${#compliments[@]}))]}"
}

# Shower thought (via reddit)
showerthought() {
  curl -s "https://www.reddit.com/r/showerthoughts/random.json" | \
    jq -r '.[0].data.children[0].data.title' 2>/dev/null || \
    echo "Hmm, couldn't fetch a thought right now."
}

# Positive affirmation
affirmation() {
  local affirmations=(
    "You are capable of amazing things."
    "You are worthy of love and respect."
    "You have the power to create change."
    "You are enough just as you are."
    "You are getting better every day."
    "You deserve to be happy."
    "You are stronger than you think."
    "You make the world a better place."
    "Your potential is limitless."
    "You are in charge of your own happiness."
  )
  echo "${affirmations[$((RANDOM % ${#affirmations[@]}))]}"
}

# -----------------------------------------------------------------------------
# Date Utilities
# -----------------------------------------------------------------------------

# Days until a date (usage: daysuntil 2024-12-25)
daysuntil() {
  if [[ -z "$1" ]]; then
    echo "Usage: daysuntil YYYY-MM-DD"
    return 1
  fi
  local target=$(date -j -f "%Y-%m-%d" "$1" "+%s" 2>/dev/null)
  if [[ -z "$target" ]]; then
    echo "Invalid date format. Use YYYY-MM-DD"
    return 1
  fi
  local now=$(date "+%s")
  local days=$(( (target - now) / 86400 ))
  if (( days < 0 )); then
    echo "${days#-} days ago"
  elif (( days == 0 )); then
    echo "That's today!"
  else
    echo "$days days from now"
  fi
}

# Calculate age from birthdate (usage: age 1990-05-15)
age() {
  if [[ -z "$1" ]]; then
    echo "Usage: age YYYY-MM-DD"
    return 1
  fi
  local birth_year=${1:0:4}
  local birth_month=${1:5:2}
  local birth_day=${1:8:2}
  local now_year=$(date +%Y)
  local now_month=$(date +%m)
  local now_day=$(date +%d)
  local years=$((now_year - birth_year))
  if (( now_month < birth_month || (now_month == birth_month && now_day < birth_day) )); then
    ((years--))
  fi
  echo "$years years old"
}

# -----------------------------------------------------------------------------
# More Visual
# -----------------------------------------------------------------------------

# Fire animation (requires libaa)
alias fire='aafire 2>/dev/null || echo "Install aafire: brew install aalib"'

# Pipes screensaver
alias pipes='pipes.sh 2>/dev/null || echo "Install pipes: brew install pipes-sh"'

# Big terminal clock
clock() {
  while true; do
    clear
    date +"%H:%M:%S" | figlet -f big 2>/dev/null || date +"%H:%M:%S"
    sleep 1
  done
}

# Nyan cat
alias nyan='nyancat 2>/dev/null || curl -s https://pv.nyancat.lol'

# ASCII aquarium
alias aquarium='asciiquarium 2>/dev/null || echo "Install: brew install asciiquarium"'

# -----------------------------------------------------------------------------
# Misc Fun
# -----------------------------------------------------------------------------

# "I'm in" hackerman moment
hackerman() {
  echo "
  ╔═══════════════════════════════════════╗
  ║                                       ║
  ║     ACCESS GRANTED                    ║
  ║                                       ║
  ║     > I'm in.                         ║
  ║                                       ║
  ╚═══════════════════════════════════════╝
  "
}

# Spinner animation demo
spin() {
  local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
  local i=0
  echo -n "Loading "
  for _ in {1..20}; do
    printf "\r${chars:$i:1} Loading..."
    i=$(( (i + 1) % ${#chars} ))
    sleep 0.1
  done
  echo -e "\rDone!        "
}

# Print a random emoji
emoji() {
  local emojis=("🎉" "🚀" "✨" "🔥" "💡" "🎯" "⭐" "🌟" "💪" "🙌" "👏" "🤖" "🦄" "🌈" "🍕" "🎸" "🏆" "💎")
  echo "${emojis[$((RANDOM % ${#emojis[@]}))]}"
}
