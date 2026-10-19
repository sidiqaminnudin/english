# Upgrade Pronouns MVP → He3x v1.1 (All Modules)

**Tidak perlu menghapus database, akun siswa, atau riwayat exam.** Perluasan ini memakai skema PostgreSQL yang sama.

## 1. Backup sebelum upgrade
```bash
pg_dump -Fc -U english_lms -h 127.0.0.1 english_lms > english_lms_before_v11.dump
```

## 2. Perbarui source code
Ekstrak zip terbaru ke folder `/opt/english-lms`; simpan file `.env` yang lama (jangan ditimpa).

## 3. Jalankan di Debian
```bash
cd /opt/english-lms
npm install
npm run check
npm run qa:all
npm run db:seed:extra
sudo systemctl restart english-lms
```
Apabila menjalankan sebagai root dalam Debian LXC, abaikan `sudo` ketika tidak tersedia.

## 4. Verifikasi di PostgreSQL
```sql
SELECT COUNT(*) AS modules FROM modules;                 -- 13
SELECT COUNT(*) AS lessons FROM lessons;                 -- 55 (clean seed)
SELECT COUNT(*) AS questions FROM questions;             -- 1305 (clean seed)
SELECT COUNT(*) FROM modules WHERE is_published = true;  -- 13 (clean seed)
SELECT m.slug, COUNT(DISTINCT l.id) AS lesson_count,
       COUNT(DISTINCT q.id) AS question_count
FROM modules m
LEFT JOIN lessons l ON l.module_id=m.id
LEFT JOIN questions q ON q.module_id=m.id
GROUP BY m.id ORDER BY m.sort_order;
```

## 5. Cek website
- `/courses` : 13 modul (jika seluruhnya diterbitkan).
- `/learn/simple-present` : empat submateri.
- `/learn/prepositions` : empat submateri.
- `/practice/simple-present` : login wajib, latihan acak.
- `/exam/simple-present` : login wajib, konfigurasi ujian.
- `/admin/modules` : cek modul yang sengaja tetap disembunyikan oleh admin.

## Jika seed gagal
- Jangan hapus database. Baca pesan gagal di terminal.
- Pastikan `npm run db:seed` versi asli **sudah pernah dijalankan** sehingga tabel `modules` memiliki 13 modul.
- Jika ada konflik kode soal akibat import manual, ekspansi menggunakan `ON CONFLICT DO NOTHING` sehingga tidak menimpa record tersebut.
- Jika ada konten materi yang pernah dibuat admin dengan slug sama, konten admin tetap dipertahankan; periksa `/admin/lessons` secara manual.

**Batasan:** uji struktur dan JavaScript/EJS sudah tersedia, tetapi uji integrasi PostgreSQL, autentikasi, dan browser harus diselesaikan di server target sebelum digunakan publik.
