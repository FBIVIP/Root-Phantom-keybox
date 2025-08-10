#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [TWRP_DELETE] $1"
}

TWRP_FOLDER="/sdcard/TWRP"
log_message "Start"

if [ -d "$TWRP_FOLDER" ]; then
  rm -rf "$TWRP_FOLDER"
  log_message "Deleted"
else
  log_message "No folder found"
fi

log_message "Finish"