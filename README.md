# He3x LMS — Expanded Curriculum (v1.1)

Web belajar Bahasa Inggris self-hosted: **materi publik tanpa login**, **latihan dan exam harus login**. Dibangun dengan Node.js (ESM), Express, EJS, Bootstrap 5, PostgreSQL. Bahasa UI Indonesia dan konten bilingual. Kurikulum berdasarkan 42 foto materi pengguna. Paket v1.1 berisi **13 modul, 55 submateri** (7 Pronouns + 48 tambahan), **1.305 soal pilihan ganda** (105 Pronouns + 1.200 tambahan), dan pembahasan untuk setiap soal. Konten merupakan adaptasi dan penyusunan ulang pokok bahasan, bukan salinan atau OCR persis dari seluruh halaman.

## Isi paket
- `system_map.md` — peta sistem, semua modul dari foto, role, alur, aturan, nonfunctional requirements
- `docs/architecture.md` — arsitektur, flow, endpoints, keamanan, roadmap
- `docs/ui_pages.md` — rancangan responsif seluruh halaman + breakpoint + design tokens
- `db/001_schema.sql` — PostgreSQL tables, foreign keys, constraints, indexes
- `db/002_pronouns.sql` — SQL idempotent untuk 105 soal Pronouns
- `db/003_expanded_curriculum.sql` — SQL idempotent untuk 48 materi dan 1.200 soal lainnya
- `db/pronouns_bank.json` dan `db/expanded_bank.json` — kumpulan soal yang dapat direview
- `db/expanded_lessons.json` — seluruh materi tambahan dalam format terstruktur
- `src/data/curriculum.js` — 13 topik kurikulum dan 7 materi Pronouns
- `scripts/build-expanded.py` — sumber pembangkit konten kurikulum tambahan, berjalan offline
- `src/routes/` — route publik, siswa, admin
- `src/views/` — **25 template halaman/partials** untuk desktop/mobile
- `src/public/css/styles.css` — design system oranye-modern
- `src/public/js/attempt.js` — navigation, autosave jawaban, countdown
- `scripts/` — inisialisasi dan seed

## Prasyarat
- Debian 12/13 pada LXC Proxmox, atau Linux/VPS
- Node.js **20 atau lebih baru** + npm
- PostgreSQL **15+**
- Nginx (opsional untuk uji lokal, disarankan produksi)
- Domain + HTTPS untuk akses publik

## 1. Buat database PostgreSQL
```bash
# Jalankan sebagai root / pengguna dengan akses sudo.
apt update
apt install -y postgresql postgresql-contrib nginx git
systemctl enable --now postgresql

# Ganti PASSWORD_DATABASE_KUAT dengan password unik tanpa tanda petik tunggal.
su - postgres -c "psql -c \"CREATE ROLE english_lms LOGIN PASSWORD 'PASSWORD_DATABASE_KUAT';\""
su - postgres -c "createdb -O english_lms english_lms"
```

> Penggunaan `postgres` dibatasi untuk setup DB saja. Aplikasi login menggunakan role `english_lms` sendiri.

## 2. Instal proyek & konfigurasi
```bash
cd /opt
# Upload / clone folder english-lms ke /opt/english-lms
cd /opt/english-lms
cp .env.example .env
nano .env
```

Ubah nilai:
```dotenv
PORT=3000
BIND_HOST=0.0.0.0
NODE_ENV=development
DATABASE_URL=postgresql://english_lms:PASSWORD_DATABASE_KUAT@127.0.0.1:5432/english_lms
SESSION_SECRET=KUNCI_RANDOM_MINIMUM_32_KARAKTER_GANTI_DENGAN_STRING_ACAK_PANJANG
TRUST_PROXY=0
COOKIE_SECURE=false
ADMIN_USERNAME=admin
ADMIN_PASSWORD=GANTI_PASSWORD_ADMIN_MINIMAL_12_KARAKTER
ADMIN_NAME=Administrator
```

Untuk membuat session secret aman:
```bash
openssl rand -hex 32
```

Gunakan Node.js 20/22 dari repositori yang mendukungnya (cek `node --version` terlebih dahulu). Lanjutkan:
```bash
npm install
npm run db:init
npm run db:seed:all
npm start
```

**Hasil:** jika uji dari perangkat lain, set `BIND_HOST=0.0.0.0` hanya di jaringan tepercaya dan buka `http://IP-SERVER:3000`. Default `.env.example` adalah `127.0.0.1` sehingga hanya bisa diakses dari server; untuk menguji lokal gunakan `http://localhost:3000`. Admin login via `/login` menggunakan `ADMIN_USERNAME` dan `ADMIN_PASSWORD` yang diisi saat seed. DB seed bersifat idempotent; record soal dan materi yang telah diedit admin tidak ditimpa oleh seed berikutnya. Setiap modul baru berisi 4 materi dan 100 MCQ dengan aturan benar dan pembahasan.

### Upgrade dari He3x Pronouns MVP (database sudah berisi akun dan hasil exam)
**Backup dulu** (ganti nama database dan role sesuai konfigurasi):
```bash
pg_dump -Fc -U english_lms -h 127.0.0.1 english_lms > english_lms_before_expansion.dump
```
Setelah mengganti source code dengan versi 1.1 (jangan timpa `.env`), jalankan:
```bash
cd /opt/english-lms
npm install
npm run qa:all
npm run db:seed:extra
systemctl restart english-lms
```
**Tidak perlu menghapus database atau menjalankan ulang `db:init`** saat upgrade jika skema v1.0 sudah ada. Modul dengan konten admin sendiri tidak dipaksa publish ulang; atur visibilitas dari `/admin/modules` bila perlu.

## 3. Pengujian cepat (manual)
1. Buka `/`, `/courses`, `/learn/pronouns`, `/learn/simple-present` dan satu lesson di browser tanpa login.
2. Klik Latihan — diarahkan ke login. Daftar akun siswa, lalu mulai latihan.
3. Jawab beberapa soal; perhatikan indikator “jawaban tersimpan” dan pembahasan. Refresh: pilihan sebelumnya masih ada.
4. Selesaikan latihan dan buka hasil. Mulai exam lain, periksa timer dan bahwa pembahasan tidak muncul sebelum submit.
5. Login sebagai admin, cek `/admin/modules`, `/admin/lessons`, `/admin/questions`, `/admin/exams`.
6. Pada `/admin/questions?module_id=...`, cek soal dari modul tambahan, 4 opsi + tepat 1 benar + pembahasan.

Validasi data sebelum instalasi:
```bash
node --check src/server.js
node --check src/routes/site.js
node --check src/routes/admin.js
node --check src/services/assessment.js
python3 scripts/qa_bank.py
python3 scripts/qa_expanded.py
```

## 4. Jalankan dengan systemd (produksi)
Untuk produksi **jangan jalankan Node sebagai root**. Buat user layanan, lalu berikan akses baca ke `/opt/english-lms`:
```bash
adduser --system --group --home /opt/english-lms englishlms
chown -R englishlms:englishlms /opt/english-lms
chmod 600 /opt/english-lms/.env
```

Buat `/etc/systemd/system/english-lms.service`:
```ini
[Unit]
Description=He3x LMS
After=network-online.target postgresql.service
Wants=network-online.target

[Service]
Type=simple
User=englishlms
Group=englishlms
WorkingDirectory=/opt/english-lms
ExecStart=/usr/bin/node /opt/english-lms/src/server.js
Restart=always
RestartSec=5
Environment=NODE_ENV=production
NoNewPrivileges=true
ProtectSystem=full
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

**Periksa jalur binary terlebih dahulu** (`command -v node`), kemudian sesuaikan `ExecStart`.
```bash
systemctl daemon-reload
systemctl enable --now english-lms
systemctl status english-lms
journalctl -u english-lms -f
```

## 5. Reverse proxy Nginx
Contoh `/etc/nginx/sites-available/english-lms`:
```nginx
server {
    listen 80;
    server_name belajar.example.com;
    client_max_body_size 1m;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 60s;
    }
}
```
```bash
ln -s /etc/nginx/sites-available/english-lms /etc/nginx/sites-enabled/english-lms
nginx -t && systemctl reload nginx
```

Setelah sertifikat SSL berhasil dikonfigurasi (misalnya Certbot), ubah `.env` menjadi:
```dotenv
NODE_ENV=production
TRUST_PROXY=1
COOKIE_SECURE=true
```
Kemudian `systemctl restart english-lms`.

> **Keamanan penting:** jangan membuka port 3000 ke internet jika sudah menggunakan Nginx. Di produksi, gunakan `BIND_HOST=127.0.0.1` pada `.env` atau batasi port dengan firewall. Jika memakai Cloudflare Tunnel, route ke Nginx HTTPS atau service lokal yang sesuai, jangan jadikan halaman admin tanpa autentikasi tambahan.

## 6. PostgreSQL backup
```bash
PGPASSWORD='PASSWORD_DATABASE_KUAT' pg_dump -h 127.0.0.1 -U english_lms -Fc english_lms > english-lms-backup.dump
```
Lindungi file backup dan uji pemulihan ke DB staging sebelum mengandalkannya.

## 7. Mengembangkan materi berikutnya
1. Masuk admin → Modul → pilih draft materi (contoh: Simple Present).
2. Masuk admin → Materi → Tambah Materi → pilih modul + isi Markdown dan publikasi.
3. Masuk admin → Bank Soal → tambah soal dan atur submateri, level, 4 opsi, jawaban benar, pembahasan.
4. Masuk admin → Exam Config → atur soal/durasi/KKM.
5. Publikasikan modul setelah minimal satu materi terbit. Baru muncul pada katalog publik.

## Keterbatasan MVP & kelanjutan
- Jenis soal baru **MCQ (empat pilihan)**. Fill-blank/essay/drag-drop belum diimplementasikan.
- Tidak ada fitur lupa password/email/verifikasi, multi-kelas, import CSV, audio pronunciation, atau AI question generation. Semuanya ada dalam roadmap.
- Sistem belum diuji end-to-end dengan PostgreSQL/HTTP pada lingkungan penulisan paket; **jalankan test manual** di atas sebelum dipakai untuk exam resmi.
- Saat ini tampilan Bootstrap & icons dimuat dari CDN. Untuk server tanpa akses internet, simpan file CSS/JS Bootstrap secara lokal dan ubah referensi template.
- Admin pertama hanya dibuat saat seed jika `ADMIN_USERNAME` & `ADMIN_PASSWORD` disetel; seed tidak mengubah password admin yang sudah ada. Gunakan akun admin untuk pengelolaan konten; jangan gunakan role database postgres untuk app.
