#!/system/bin/sh
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [TARGET] $1"
}

STORE_PATH="/data/adb/tricky_store"
TARGET_LIST="$STORE_PATH/target.txt"
TEE_STATUS="$STORE_PATH/tee_status"
mkdir -p "$STORE_PATH"

log_message "Start"

teeBroken="false"
if [ -f "$TEE_STATUS" ]; then
    teeBroken=$(grep -E '^teeBroken=' "$TEE_STATUS" | cut -d '=' -f2 2>/dev/null || echo "false")
fi

# Special list
echo "android" > "$TARGET_LIST"
for pkg in com.android.vending com.google.android.gsf com.google.android.gms \
           com.google.android.apps.walletnfcrel com.openai.chatgpt com.reveny.nativecheck \
           io.github.vvb2060.keyattestation io.github.vvb2060.mahoshojo icu.nullptr.nativetest \
           com.android.nativetest io.liankong.riskdetector me.garfieldhan.holmes luna.safe.luna \
           com.zhenxi.hunter gr.nikolasspyr.integritycheck com.youhu.laifu \
           com.google.android.contactkeys com.google.android.ims com.google.android.safetycore \
           com.whatsapp com.whatsapp.w4b; do
    echo "$pkg!" >> "$TARGET_LIST"
done

# Add function
add_packages() {
    pm list packages "$1" | cut -d ":" -f 2 | while read -r pkg; do
        if [ -n "$pkg" ] && ! grep -q "^$pkg" "$TARGET_LIST"; then
            if [ "$teeBroken" = "true" ]; then
                echo "$pkg!" >> "$TARGET_LIST"
            else
                echo "$pkg" >> "$TARGET_LIST"
            fi
        fi
    done
}

add_packages "-3"
add_packages "-s"

log_message "Finish"