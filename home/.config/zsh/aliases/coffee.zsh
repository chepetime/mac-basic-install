# AeroPress brewing timer. Usage: coffee [grams] [ratio]

coffee() {
  # ─────────────────────────────────────────────────────────────────────────
  # Configuration (edit these to customize your brew)
  # ─────────────────────────────────────────────────────────────────────────
  local default_coffee=20        # default coffee in grams
  local default_ratio=12         # default water:coffee ratio
  local bloom_multiplier=2       # bloom water = coffee × this
  local bloom_time=30            # bloom time in seconds
  local pour_time=45             # time after main pour in seconds
  local total_time=240           # total brew time in seconds (4:00)
  local press_time=30            # suggested press time in seconds
  local max_capacity=250         # max water capacity in grams

  # ─────────────────────────────────────────────────────────────────────────
  # Calculated values (don't edit)
  # ─────────────────────────────────────────────────────────────────────────
  local coffee_g=${1:-$default_coffee}
  local ratio=${2:-$default_ratio}
  local bloom_water=$((coffee_g * bloom_multiplier))
  local total_water=$((coffee_g * ratio))
  local main_water=$((total_water - bloom_water))
  local steep_time=$((total_time - bloom_time - pour_time))
  local total_time_fmt=$(printf "%d:%02d" $((total_time/60)) $((total_time%60)))

  # ─────────────────────────────────────────────────────────────────────────
  # Validation
  # ─────────────────────────────────────────────────────────────────────────
  if (( total_water > max_capacity )); then
    echo "⚠️  Warning: ${total_water}g water may overflow standard Aeropress (max ~${max_capacity}g)"
    echo "   Consider using less coffee or a higher ratio"
    echo ""
    read "?Press ENTER to continue anyway, or Ctrl+C to cancel..."
    echo ""
  fi

  # ─────────────────────────────────────────────────────────────────────────
  # Helper function
  # ─────────────────────────────────────────────────────────────────────────
  _coffee_countdown() {
    local secs=$1
    local msg=$2
    while (( secs > 0 )); do
      printf "\r  ⏱  %02d:%02d  %s" $((secs/60)) $((secs%60)) "$msg"
      sleep 1
      ((secs--))
    done
    printf "\r  ✓  00:00  %s\n" "$msg"
    echo -e "\a"
  }

  # ─────────────────────────────────────────────────────────────────────────
  # Brew guide
  # ─────────────────────────────────────────────────────────────────────────
  clear
  echo "╔═══════════════════════════════════════════════════════════════╗"
  echo "║               ☕ AEROPRESS BREWING GUIDE ☕                   ║"
  echo "╠═══════════════════════════════════════════════════════════════╣"
  printf "║  Coffee: %2dg  │  Bloom: %3dg  │  Main: %3dg  │  Ratio: 1:%-2d   ║\n" \
    $coffee_g $bloom_water $main_water $ratio
  echo "╠═══════════════════════════════════════════════════════════════╣"
  printf "║  Total water: %3dg                     Total time: %-5s      ║\n" \
    $total_water $total_time_fmt
  echo "╚═══════════════════════════════════════════════════════════════╝"

  # Step 1: Setup
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📋 STEP 1: SETUP"
  echo "   Add ${coffee_g}g of ground coffee to the Aeropress"
  echo ""
  read "?Press ENTER when ready to start brewing..."

  # Step 2: Bloom
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "💧 STEP 2: BLOOM"
  echo "   Pour ${bloom_water}g of boiling water, then stir gently"
  echo ""
  osascript -e 'display notification "Pour '${bloom_water}'g water and stir!" with title "Aeropress: Bloom" sound name "Ping"' 2>/dev/null
  _coffee_countdown $bloom_time "Blooming..."

  # Step 3: Main pour
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🫖 STEP 3: MAIN POUR"
  echo "   Pour ${main_water}g of water"
  echo ""
  osascript -e 'display notification "Pour '${main_water}'g water!" with title "Aeropress: Main Pour" sound name "Ping"' 2>/dev/null
  _coffee_countdown $pour_time "Steeping after pour..."

  # Step 4: Steep
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⏳ STEP 4: STEEP"
  echo "   Let it steep until ${total_time_fmt} total"
  echo ""
  _coffee_countdown $steep_time "Steeping..."

  # Step 5: Press
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⬇️  STEP 5: PRESS"
  echo "   Flip and press slowly (~${press_time} seconds)"
  echo ""
  osascript -e 'display notification "Time to press!" with title "Aeropress: Press Now!" sound name "Glass"' 2>/dev/null

  # Final message
  echo ""
  echo "╔═══════════════════════════════════════════════════════════════╗"
  echo "║                    ☕ ENJOY YOUR COFFEE! ☕                   ║"
  echo "╚═══════════════════════════════════════════════════════════════╝"
}
