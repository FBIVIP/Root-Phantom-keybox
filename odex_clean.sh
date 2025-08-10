#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ODEX_CLEAN] $1"
}

log_message "Start"
find /data/app -type f -name base.odex -delete
log_message "Finish"