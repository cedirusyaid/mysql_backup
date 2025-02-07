# Backup MySQL Database Script

## Deskripsi
Script ini digunakan untuk melakukan backup database MySQL secara otomatis setiap minggu. Selain itu, script juga memiliki fitur penghapusan backup lama dan notifikasi ke grup Telegram.

## Fitur
- Backup database MySQL secara otomatis.
- Penyimpanan backup dalam folder mingguan.
- Penghapusan backup yang lebih lama dari dua bulan.
- Notifikasi ke Telegram dengan informasi hostname, database yang dibackup, dan ukuran file backup.

## Persyaratan
- Sistem operasi berbasis Linux.
- MySQL server.
- Akses ke `mysqldump`.
- Bot Telegram dengan token API.
- `cron` untuk penjadwalan otomatis.

## Instalasi
1. Clone repository:
   ```bash
   git clone https://github.com/username/repo.git
   cd repo
   ```
2. Edit konfigurasi dalam script `backup.sh`:
   - **MYSQL_USER** → Nama pengguna MySQL.
   - **MYSQL_PASSWORD** → Kata sandi MySQL.
   - **BACKUP_ROOT** → Lokasi penyimpanan backup.
   - **TELEGRAM_BOT_TOKEN** → Token bot Telegram.
   - **TELEGRAM_CHAT_ID** → ID grup Telegram.
   - **DATABASES** → Daftar database yang akan di-backup.
3. Beri izin eksekusi pada script:
   ```bash
   chmod +x backup.sh
   ```

## Penggunaan
Jalankan script secara manual:
```bash
./backup.sh
```
Atau jadwalkan dengan cron job agar berjalan otomatis setiap minggu:
```bash
crontab -e
```
Tambahkan baris berikut untuk menjalankan backup setiap minggu:
```bash
0 2 * * 0 /path/to/backup.sh
```

## Notifikasi Telegram
Setelah backup selesai, bot Telegram akan mengirim pesan berisi:
- **Hostname server**
- **Daftar database yang dibackup**
- **Ukuran setiap backup**

## Penghapusan Backup Lama
Script akan menghapus backup yang lebih lama dari dua bulan untuk menghemat penyimpanan.

## Lisensi
Proyek ini menggunakan lisensi MIT. Silakan gunakan dan modifikasi sesuai kebutuhan.

---

Dikembangkan oleh: [Nama Anda]

