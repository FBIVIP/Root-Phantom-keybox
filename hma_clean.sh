#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [HMA_CLEAN] $1"
}

log_message "Start"

FOLDERS=$(find /data/system -maxdepth 1 -type d \( -iname "*hide*" -o -iname "*hma*" -o -iname "*applist*" \) 2>/dev/null)
for FOLDER in $FOLDERS; do
    rm -rf "$FOLDER"
    log_message "Deleted $FOLDER"
done

log_message "Finish"