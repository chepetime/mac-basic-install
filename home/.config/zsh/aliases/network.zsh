# Network & IP
alias myip='curl -s ifconfig.me; echo'
localip() { ipconfig getifaddr "$(route get default 2>/dev/null | awk '/interface:/{print $2}')" 2>/dev/null || echo "Not connected"; }
alias ipinfo='curl -s ipinfo.io; echo'
alias whereami='curl -s ipinfo.io/loc'
alias ping5='ping -c 5'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias headers='curl -I'                        # show HTTP headers
alias netspeed='networkQuality'

# WiFi network info (SSID, protocol, signal, channel, speeds)
netinfo() {
  local wifi=$(system_profiler SPAirPortDataType 2>/dev/null)
  local ssid=$(echo "$wifi" | awk '/Current Network Information:/{getline; gsub(/^[ \t]+|:[ \t]*$/,""); print}')
  local phy=$(echo "$wifi" | grep "PHY Mode:" | head -1 | awk -F': ' '{print $2}')
  local channel=$(echo "$wifi" | grep "Channel:" | head -1 | awk -F': ' '{print $2}')
  local linkspeed=$(echo "$wifi" | grep "Transmit Rate:" | head -1 | awk -F': ' '{print $2}')
  local ip=$(route get default 2>/dev/null | awk '/interface:/{print $2}' | xargs -I{} ipconfig getifaddr {} 2>/dev/null || echo "Not connected")

  # Map PHY mode to WiFi generation
  local wifi_gen=""
  case "$phy" in
    *ax*) wifi_gen="WiFi 6/6E" ;;
    *ac*) wifi_gen="WiFi 5" ;;
    *n*)  wifi_gen="WiFi 4" ;;
    *g*)  wifi_gen="WiFi 3" ;;
    *)    wifi_gen="Unknown" ;;
  esac

  echo "Network: $ssid"
  echo "Protocol: $phy ($wifi_gen)"
  echo "Channel: $channel"
  echo "Link Speed: ${linkspeed} Mbps"

  echo "Testing internet speed..."
  local speedout=$(networkQuality 2>/dev/null)
  local dl=$(echo "$speedout" | awk '/Downlink capacity:/{print int($3)}')
  local ul=$(echo "$speedout" | awk '/Uplink capacity:/{print int($3)}')
  echo "Internet: ↓ ${dl} Mbps  ↑ ${ul} Mbps"

  echo "Local IP: $ip"
}
