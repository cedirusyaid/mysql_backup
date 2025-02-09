# Backup MySQL Database Script

## Deskripsi
Script ini digunakan untuk melakukan backup otomatis database MySQL setiap minggu. Backup akan dikompresi dalam format `.gz`, disimpan dalam folder berdasarkan minggu berjalan, dan otomatis menghapus backup yang lebih lama dari 2 bulan. Notifikasi akan dikirim ke grup Telegram setelah proses backup selesai.

## Fitur
- Backup otomatis database MySQL setiap minggu.
- Menyimpan backup dalam direktori berdasarkan format `YYYY_WW`.
- Mengompresi setiap file database backup ke format `.gz`.
- Menghapus backup yang lebih lama dari 2 bulan.
- Mengirimkan notifikasi ke Telegram berisi hostname server dan ukuran backup.

## Prasyarat
- MySQL sudah terinstal dan dikonfigurasi.
- Bot Telegram telah dibuat dan memiliki token.
- Server memiliki akses ke `curl` untuk mengirim notifikasi ke Telegram.

## Konfigurasi
1. Ubah nilai variabel berikut sesuai kebutuhan:
   ```bash
   MYSQL_USER="your_username"
   MYSQL_PASSWORD="your_password"
   BACKUP_ROOT="/path/to/backup"
   TELEGRAM_BOT_TOKEN="your_bot_token"
   TELEGRAM_CHAT_ID="your_chat_id"
   ```
2. Pastikan direktori backup ada atau buat secara manual:
   ```bash
   mkdir -p /path/to/backup
   ```

## Penggunaan
1. Simpan script sebagai `backup_mysql.sh`.
2. Berikan izin eksekusi:
   ```bash
   chmod +x backup_mysql.sh
   ```
3. Jalankan script secara manual:
   ```bash
   ./backup_mysql.sh
   ```
4. Tambahkan ke crontab agar berjalan otomatis setiap minggu:
   ```bash
   crontab -e
   ```
   Tambahkan baris berikut:
   ```bash
   0 2 * * 0 /path/to/backup_mysql.sh
   ```
   (Jalankan setiap Minggu pukul 02:00)

## Log Aktivitas
Semua aktivitas backup akan dicatat dalam file log yang berada di direktori backup.

## Notifikasi Telegram
- Setelah backup selesai, bot akan mengirim pesan berisi hostname dan daftar database yang di-backup beserta ukuran file masing-masing.
- Jika ada kegagalan, bot akan mengirimkan pesan error dengan detail database yang gagal dibackup.

## Lisensi
Script ini bebas digunakan dan dimodifikasi sesuai kebutuhan.

