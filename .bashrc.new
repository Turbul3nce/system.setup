#aliases
alias ls='ls -lah'

# Function to get memory usage
get_mem_usage() {
    free -h | awk '/^Mem/ {print $3}'
}

# Function to read CPU usage from cache
get_cpu_usage() {
    cat /tmp/cpu_usage 2>/dev/null || echo "N/A"
}

# Function to read network usage from cache
get_net_usage() {
    cat /tmp/net_usage 2>/dev/null || echo "N/A"
}

# Background script to update CPU and network usage
update_metrics() {
    while true; do
        # CPU usage calculation
        CPU_USAGE=$(awk -v CONVFMT='%.1f' '{u=$2; n=$4; s=$3+$5+$6+$7+$8+$9+$10+$11+$12; if(NR==1){tu=u; tn=n; ts=s} else {print 100*((u-tu)+(n-tn))/(s-ts)}}' <(grep 'cpu ' /proc/stat) <(sleep 1; grep 'cpu ' /proc/stat) | awk '{print $1 "%"}')
        echo "$CPU_USAGE" > /tmp/cpu_usage

        # Network usage calculation
        RX1=$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd+ | bc)
        TX1=$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd+ | bc)
        sleep 1
        RX2=$(cat /sys/class/net/*/statistics/rx_bytes | paste -sd+ | bc)
        TX2=$(cat /sys/class/net/*/statistics/tx_bytes | paste -sd+ | bc)
        NET_USAGE=$(( (RX2 - RX1 + TX2 - TX1) / 1024 )) # KB/s
        echo "${NET_USAGE} KB/s" > /tmp/net_usage

        sleep 5 # Update every 5 seconds
    done
}

# Start background metric updater (run only once per session)
if [ -z "$(pgrep -f update_metrics)" ]; then
    update_metrics &
fi

# Set a custom prompt
PS1="\[\e[0;36m\](\$(date '+%a %b-%d %l:%M:%S%P'))-\[\e[0;32m\](CPU \$(get_cpu_usage):Net \$(get_net_usage))-\[\e[0;34m\](\u:\w)-\[\e[0;33m\](\$(get_mem_usage))\n> \[\e[0m\]"
