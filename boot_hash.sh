#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [BOOT_HASH] $1"
}

BOOT_HASH_FILE="/data/adb/boot_hash"
mkdir -p "$(dirname "$BOOT_HASH_FILE")"

log_message "Start"

boot_hash=$(getprop ro.boot.vbmeta.digest)
if [ -n "$boot_hash" ]; then
    echo "$boot_hash" > "$BOOT_HASH_FILE"
    chmod 644 "$BOOT_HASH_FILE"
    resetprop -n ro.boot.vbmeta.digest "$boot_hash"
    log_message "Wrote: $boot_hash"
else
    log_message "Boot hash not found"
fi

log_message "Finish"