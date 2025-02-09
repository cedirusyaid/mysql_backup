# Monitoring Server

Script ini digunakan untuk memantau status server dan mengirimkan laporan melalui Telegram.

## Fitur

- Menampilkan uptime server
- Menampilkan penggunaan CPU dan jumlah core
- Menampilkan penggunaan RAM
- Menampilkan status koneksi internet
- Menampilkan status layanan tertentu (dikonfigurasi melalui `.env`)
- Menampilkan daftar user yang sedang login
- Menampilkan penggunaan disk hanya dari perangkat `/dev/`
- Menampilkan jumlah koneksi HTTP/HTTPS yang aktif (untuk server Apache2)

## Instalasi dan Penggunaan

1. **Clone Repository**

   ```bash
   git clone https://github.com/username/monitor_server.git
   cd monitor_server
   ```

2. **Buat dan atur file ****`.env`**
   Buat file `.env` di dalam `/opt/monitor_server/` dengan isi seperti berikut:

   ```ini
   TELEGRAM_BOT_TOKEN=your_bot_token
   TELEGRAM_CHAT_ID=your_chat_id
   SERVICE_LIST="apache2 mysql ssh"
   ```

3. **Berikan izin eksekusi pada script**

   ```bash
   chmod +x monitoring.sh
   ```

4. **Jalankan script secara manual**

   ```bash
   ./monitoring.sh
   ```

5. **Menjadwalkan eksekusi otomatis (Opsional)**
   Tambahkan ke crontab untuk menjalankan script secara berkala:

   ```bash
   crontab -e
   ```

   Tambahkan baris berikut untuk menjalankan setiap 5 menit:

   ```
   */5 * * * * root /opt/monitor_server/monitoring.sh
   ```

## Lisensi

Script ini dirilis dengan lisensi MIT. Silakan gunakan dan modifikasi sesuai kebutuhan.

