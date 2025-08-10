#!/system/bin/sh

STORE_PATH="/data/adb/tricky_store"
ZIP_PATH="$STORE_PATH/root.zip"
TMP_DIR="$STORE_PATH/tmp_keybox"
INDEX_FILE="/data/local/tmp/keybox_index.txt"

clear
echo ""
echo "🔐 Auto Keybox Update - Root Phantom FATEH"
echo "🔐 تحديث Keybox تلقائي - Root Phantom FATEH"
sleep 1

echo "🔧 Downloading VIP Keybox & Updating Play Integrity..."
echo "🔧 جاري تنزيل VIP Keybox وتحديث Play Integrity..."
sleep 1

# تنزيل أحدث root.zip
mkdir -p "$STORE_PATH"
wget -qO "$ZIP_PATH" "https://hishi7.fun/keybox/root.zip"
sleep 1

# فك الملفات
mkdir -p "$TMP_DIR"
unzip -o "$ZIP_PATH" -d "$TMP_DIR" >/dev/null 2>&1
sleep 1

# جلب جميع ملفات keybox.xml*
all_files=$(ls "$TMP_DIR" | grep -E '^keybox\.xml[0-9]*$' | sort)

# قراءة الفهرس الحالي
if [ ! -f "$INDEX_FILE" ]; then
    current_index=0
else
    current_index=$(cat "$INDEX_FILE")
fi

# حساب عدد الملفات
total_files=$(echo "$all_files" | wc -l)

# إذا المؤشر أكبر أو يساوي عدد الملفات، نرجعه للبداية
if [ "$current_index" -ge "$total_files" ]; then
    current_index=0
fi

# اختيار الملف حسب الفهرس
selected_file=$(echo "$all_files" | awk "NR==$((current_index+1))")

# نسخ الملف
if [ -n "$selected_file" ]; then
    cp "$TMP_DIR/$selected_file" "$STORE_PATH/keybox.xml"
    chmod 0644 "$STORE_PATH/keybox.xml"
fi

# تحديث الفهرس
next_index=$((current_index + 1))
echo "$next_index" > "$INDEX_FILE"

# تنظيف الملفات
rm -f "$ZIP_PATH"
rm -rf "$TMP_DIR"

# إشعار نجاح
su -lp 2000 -c "cmd notification post -S bigtext -t 'Root Phantom FATEH' 'id_keybox_update' 'Updated from $selected_file ✅'"
sleep 1
su -lp 2000 -c "cmd notification post -S bigtext -t 'Root Phantom FATEH' 'id_keybox_update' 'تم التحديث من $selected_file بنجاح ✅'"

echo ""
echo "🎉 Updated with: $selected_file"
echo "🎉 تم التحديث من: $selected_file"
echo "📢 Support channel: https://t.me/kernelsu1"
echo "📢 قناة الدعم: https://t.me/kernelsu1"
echo ""
# 📬 فتح قناة التليجرام بعد التثبيت
nohup am start -a android.intent.action.VIEW -d "https://t.me/kernelsu1" >/dev/null 2>&1 &
ui_print "📨 Opening Telegram Channel..."

echo "- Done!"