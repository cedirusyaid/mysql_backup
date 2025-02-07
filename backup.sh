#!/bin/bash

# Konfigurasi MySQL
MYSQL_USER="[user_mysql]"
MYSQL_PASSWORD="[password_mysql]"
BACKUP_ROOT="/path/file/"
TELEGRAM_BOT_TOKEN="[bot_token]"
TELEGRAM_CHAT_ID="[chat_id]"

# Dapatkan hostname server
HOSTNAME=$(hostname)

# Dapatkan tanggal minggu ini (format: YYYY_WW → Tahun_MingguKe)
DATE=$(date +"%Y_%V")
BACKUP_DIR="$BACKUP_ROOT/$DATE"
LOG_FILE="$BACKUP_ROOT/backup.log"

# Daftar database yang akan di-backup
DATABASES=("mitra_db" "pasar_db")

# Pastikan direktori backup untuk minggu ini ada
mkdir -p "$BACKUP_DIR"

# Logging
echo "[$(date)] Mulai backup database..." | tee -a "$LOG_FILE"

# Inisialisasi pesan untuk Telegram
BACKUP_REPORT="🔹 *Backup Server: \`$HOSTNAME\`* 🔹%0A%0ABackup database selesai pada $(date).%0A%0ADaftar backup:"

# Loop untuk membackup setiap database
for DB in "${DATABASES[@]}"; do
    echo "Membackup database: $DB..." | tee -a "$LOG_FILE"
    mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$DB" > "$BACKUP_DIR/${DB}_backup.sql"
    
    # Periksa apakah backup berhasil
    if [[ $? -eq 0 ]]; then
        gzip "$BACKUP_DIR/${DB}_backup.sql"
        FILE_SIZE=$(du -sh "$BACKUP_DIR/${DB}_backup.sql.gz" | awk '{print $1}')
        echo "Backup $DB selesai. Ukuran: $FILE_SIZE" | tee -a "$LOG_FILE"
        BACKUP_REPORT+="%0A- $DB ($FILE_SIZE)"
    else
        echo "Gagal membackup $DB!" | tee -a "$LOG_FILE"
        ERROR_MESSAGE="Gagal membackup database: $DB di server 🔹 \`$HOSTNAME\` 🔹"
        curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID&text=$ERROR_MESSAGE&parse_mode=Markdown"
    fi
done

# Hapus backup yang lebih lama dari 2 bulan berdasarkan nama folder
echo "Menghapus backup yang lebih lama dari 2 bulan..." | tee -a "$LOG_FILE"
CURRENT_YEAR=$(date +"%Y")
CURRENT_WEEK=$(date +"%V")
TWO_MONTHS_AGO=$(date -d "-8 weeks" +"%Y_%V")

for DIR in "$BACKUP_ROOT"/*; do
    if [[ -d "$DIR" ]]; then
        FOLDER_NAME=$(basename "$DIR")
        if [[ "$FOLDER_NAME" < "$TWO_MONTHS_AGO" ]]; then
            echo "Menghapus folder lama: $DIR" | tee -a "$LOG_FILE"
            rm -rf "$DIR"
        fi
    fi
done

# Kirim notifikasi ke Telegram setelah backup selesai
curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID&text=$BACKUP_REPORT&parse_mode=Markdown"

echo "[$(date)] Backup selesai." | tee -a "$LOG_FILE"
