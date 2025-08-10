#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [RESETPROPS] $1"
}

log_message "Start"

getprop | grep -E "pihook|pixelprops" | sed -E "s/^\[(.*)\]:.*/\1/" | while IFS= read -r prop; do
  resetprop -p -d "$prop"
done

log_message "Finish"