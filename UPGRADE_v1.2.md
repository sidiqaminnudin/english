# EnglishLab LMS v1.2 — Upgrade non-destruktif dari v1.1

## Isi pembaruan

- 8 modul baru: Simple Past, Present Perfect, Present Continuous, Past Continuous, Simple Future, Future Continuous, Modal Auxiliary, Passive Voice.
- 24 pelajaran berbentuk Markdown dan 198 soal MCQ baru; seluruh 13 modul v1.1 tetap dipertahankan.
- 74 latihan *Indonesia → English* bertahap: pilih tense/struktur → tulis kalimat.
- 8 file MP3 listening orisinal (dibuat offline), beserta 32 pertanyaan dengan 4 opsi, skor dan transkrip setelah submit.
- Review admin untuk jawaban terjemahan alternatif; tidak menghakimi kalimat bebas hanya dengan exact match.
- Halaman navigasi `/translation`, `/listening`, review admin `/admin/translation-review`.

Perkiraan pada instalasi v1.1 bersih: **21 modul, 79 pelajaran, 1.503 MCQ, 74 prompt terjemahan dan 32 pertanyaan listening** (jumlah yang sudah diedit admin dapat berbeda).

## Perlindungan data

**Jangan** `DROP TABLE`, `TRUNCATE`, menghapus database, atau menjalankan seed yang membersihkan riwayat. Semua migrasi v1.2 berupa `CREATE TABLE IF NOT EXISTS`, sedangkan seed memakai `ON CONFLICT DO NOTHING` untuk konten berkode. Eksisting `users`, `attempts`, dan semua soal lama tetap ada.

> Jika code di server telah banyak dimodifikasi agent VS Code, **jangan overwrite** seluruh folder ZIP. Gunakan petunjuk di `AGENT_VSCODE_PROMPT.md` untuk *diff* dan *merge* file perubahan.

### 1. Backup dan inspeksi

```bash
cd /opt/english-lms  # sesuaikan dengan lokasi aplikasi
cp .env /root/englishlab_env_backup
pg_dump -Fc -h 127.0.0.1 -U english_lms english_lms > /root/englishlab_before_v12.dump
# Verifikasi backup terbuat dan ukurannya tidak nol
ls -lh /root/englishlab_before_v12.dump
```

Nama user/database pada `pg_dump` harus disesuaikan `.env` (jangan menyimpan password di shell history).

### 2. Git, merge, QA

```bash
git status
# Commit perubahanmu sebelum integrasi, jika folder dikelola git.
# Merge hanya file v1.2 ke source project, jangan menimpa .env atau asset admin.
npm install
npm run check
npm run qa:all
npm run qa:v12
```

### 3. Migrasi database dan seed

```bash
npm run db:migrate:v12
npm run db:seed:v12
```

> Migrasi wajib **sebelum** seed. Seed dapat diulang tanpa menduplikasi kode soal, dan sengaja tidak menimpa materi/soal yang pernah diubah admin.

### 4. Verifikasi di PostgreSQL

```sql
SELECT COUNT(*) AS modules FROM modules;
SELECT COUNT(*) AS lessons FROM lessons;
SELECT COUNT(*) AS mcq_questions FROM questions;
SELECT COUNT(*) AS translation_prompts FROM translation_prompts;
SELECT COUNT(*) AS listening_tracks FROM listening_tracks;
SELECT COUNT(*) AS listening_questions FROM listening_questions;
SELECT m.slug, COUNT(DISTINCT l.id) AS lessons, COUNT(DISTINCT q.id) AS mcq
FROM modules m
LEFT JOIN lessons l ON l.module_id=m.id
LEFT JOIN questions q ON q.module_id=m.id
GROUP BY m.id ORDER BY m.slug;
```

### 5. Verifikasi HTTP (setelah review manual)

Restart nama service yang **benar** pada server; jika saat ini server pakai `english.service`, lakukan `systemctl restart english`, **bukan** `english-lms`.

```bash
systemctl restart english
systemctl status english --no-pager
curl -fI http://127.0.0.1/healthz
```

- `/courses` memuat materi lama dan modul baru yang dipublikasikan.
- `/learn/simple-past`, `/learn/modal-verbs`, `/learn/passive-voice` tampil publik.
- `/practice/simple-past`, `/exam/present-perfect` memakai engine MCQ v1.1.
- `/translation` pilih tense → ketik terjemahan → feedback → hasil → `/translation/history`.
- `/listening` memilih audio → dengar → jawab → skor + transkrip.
- `/admin/translation-review` khusus admin dan dapat menerima/menolak variasi jawaban.
- File audio harus merespons `Content-Type: audio/mpeg` pada `/audio/at-the-library.mp3`.

## Install bersih (untuk server baru, **bukan untuk upgrade**)

```bash
npm install
npm run db:setup:full
npm start
```

Buat role, database PostgreSQL, `.env`, dan Nginx sesuai `README.md` v1.1 sebelum menjalankan perintah tersebut.

## Batasan implementasi awal

- Penilaian terjemahan menghitung **kecocokan dengan daftar jawaban yang disetujui**, bukan penilaian semantik/grammar lengkap. Respons valid lain masuk antrean review admin; tidak otomatis salah.
- Terjemahan adalah **latihan**, belum ikut perhitungan Exam MCQ bersertifikat. Listening juga merupakan sesi practice dengan skor terpisah.
- Audio awal menggunakan synthesizer offline eSpeak. Kualitas suara sintetis; ganti dengan voice actor atau konten berlisensi sebelum ujian listening tingkat lanjut.
- PostgreSQL dan fitur web **belum diuji end-to-end** di lingkungan pengemasan. Jalankan QA integrasi pada server staging.
