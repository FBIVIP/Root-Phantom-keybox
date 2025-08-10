#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [KILL_GOOGLE] $1"
}

log_message "Start"

am force-stop com.android.vending >/dev/null 2>&1
pm clear com.android.vending >/dev/null 2>&1
sleep 2

for pkg in com.henrikherzig.playintegritychecker gr.nikolasspyr.integritycheck \
           com.atominvention.rootchecker krypton.tbsafetychecker com.flinkapps.safteynet; do
    pm clear "$pkg" >/dev/null 2>&1
done

log_message "Finish"