# Network

localip() { ipconfig getifaddr "$(route get default 2>/dev/null | awk '/interface:/{print $2}')" 2>/dev/null || echo "Not connected"; }

alias ipinfo='curl -s ipinfo.io; echo'
