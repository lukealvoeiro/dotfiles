# Shell functions.

# Kill processes on a specific port
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port> [tcp|udp|all]"
        echo "Example: killport 3000       # kills TCP processes on port 3000"
        echo "         killport 3000 all   # kills both TCP and UDP processes"
        return 1
    fi

    local port=$1
    local protocol=${2:-tcp}
    local found=false

    # Function to kill processes for a specific protocol
    kill_by_protocol() {
        local proto=$1
        local pids=$(lsof -ti :$port -s${proto}:LISTEN 2>/dev/null)

        if [ -n "$pids" ]; then
            # Show what's being killed
            echo "Killing ${proto} processes on port $port:"
            lsof -i ${proto}:$port 2>/dev/null | grep -v "^COMMAND" | while read line; do
                echo "  → $line" | awk '{printf "  → %s (PID: %s)\n", $1, $2}'
            done | sort -u

            # Kill the processes
            echo "$pids" | xargs kill -9 2>/dev/null
            found=true
        fi
    }

    # Handle different protocol options
    case $protocol in
        tcp|TCP)
            kill_by_protocol TCP
            ;;
        udp|UDP)
            kill_by_protocol UDP
            ;;
        all|ALL|both)
            kill_by_protocol TCP
            kill_by_protocol UDP
            ;;
        *)
            echo "Invalid protocol: $protocol (use tcp, udp, or all)"
            return 1
            ;;
    esac

    if [ "$found" = true ]; then
        echo "✅ Successfully killed process(es) on port $port"
    else
        echo "❌ No process found on port $port"
    fi
}

# Rewrite `git push -f` / `git push --force` to `git push --force-with-lease`
git() {
  if [[ "$1" == "push" ]]; then
    local args=("${@:2}")
    local new_args=()
    for arg in "${args[@]}"; do
      case "$arg" in
        -f|--force) new_args+=(--force-with-lease) ;;
        *) new_args+=("$arg") ;;
      esac
    done
    command git push "${new_args[@]}"
  else
    command git "$@"
  fi
}
