#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SECURITY_PATCH] $1"
}

STORE_PATH="/data/adb/tricky_store"
SECURITY_PATCH="$STORE_PATH/security_patch.txt"
mkdir -p "$STORE_PATH"

log_message "Start"

current_year=$(date +%Y)
current_month=$(date +%m)

if [ "$current_month" -eq 1 ]; then
  prev_month=12
  prev_year=$((current_year - 1))
else
  prev_month=$((10#$current_month - 1))
  prev_year=$current_year
fi

formatted_month=$(printf "%02d" $prev_month)
echo "all=${prev_year}-${formatted_month}-05" > "$SECURITY_PATCH"

log_message "Finish"