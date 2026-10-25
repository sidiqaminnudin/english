# INSTRUKSI UNTUK AGENT VS CODE — ENGLISHLAB DUA UJIAN + RINGKASAN TENSES

Konteks: Proyek EnglishLab LMS menggunakan Node.js ESM, Express, EJS, Bootstrap, PostgreSQL. Materi publik; login siswa diperlukan untuk latihan dan exam. Baseline v1.2 telah memiliki ujian per modul (MCQ), `translation_prompts` dan `listening_tracks` dalam migrasi `db/004_v12_skills.sql`. Mungkin ada patch ekspansi Writing/Listening dan audio real-human; **audit repository aktual terlebih dahulu**.

File masukan: `tenses_quick_reference.md` dan `two_exam_blueprint.md` yang ada satu folder dengan instruksi ini. Baca keduanya penuh sebelum coding.

## Tugas

A. Buat halaman publik **Tenses Quick Reference** (boleh route `/tenses-summary`), gunakan konten Markdown yang disertakan tanpa menghapus materi setiap modul. Tampilkan tujuh tense, rumus +/-/?, contoh, time signals, dan tips. Implementasikan EJS + Bootstrap selaras tema yang sudah ada dan mobile-friendly.

B. Buat **Ujian 1 — English Fundamentals** lintas 13 modul dari Alphabet & Spelling sampai Giving Directions. Konfigurasi awal: 50 MCQ, 60 menit, lulus 75. Agar bank soal merata, pilih soal minimal dua dari tiap modul dan distribusikan sisanya menurut konfigurasi. Periksa kecukupan aktif pool sebelum memulai.

C. Buat **Ujian 2 — Tenses, Writing & Listening**. Konfigurasi awal: 15 soal pilihan tense + writing (60 poin) dan 10 pertanyaan listening real-human (40 poin), 90 menit, lulus 75. Tenses inti: simple present, simple past, simple future, present continuous, past continuous, future continuous, present perfect. Modal/passive optional. Writing: pilih tense, lalu ketik kalimat Inggris; keluaran AI adalah umpan balik dan skor provisional, admin dapat review. Jangan tetapkan lulus/gagal final saat ada review terbuka.

D. Buat route ujian baru; pertahankan route latihan dan exam per modul yang sudah berjalan. Terapkan migrasi **aditif**, backup dahulu dan jangan menghapus data soal/progres. Gunakan snapshot setiap soal dan opsi acak yang tidak berubah saat refresh. Pertahankan source attribution audio VOA dan pastikan pertanyaan benar-benar sesuai transkrip. Jika track audio real-human belum tersedia, jangan aktifkan exam 2 untuk publik sampai materi valid.

E. Pastikan panel admin dapat melihat dua exam series, mengatur parameter, menjalankan preview, dan meninjau hasil writing yang perlu verifikasi.

F. Bangun test: pemilihan soal lintas modul, distribusi, uniqueness, durasi timer server, authorized access, proteksi CSRF, exact scoring 100, AI unavailable, review workflow, pilihan tense ambigu, audio 404, mobile EJS, dan non-regresi exam per modul.

## Referensi nama tabel yang sudah ada (periksa ulang)

- `modules`, `lessons`, `questions`, `question_options`
- `attempts`, `attempt_items`, `exam_configs`
- `translation_prompts`, `translation_runs`, `translation_run_items`
- `listening_tracks`, `listening_questions`, `listening_runs`, `listening_run_items`

Catatan: `attempts.module_id` bersifat non-null, sehingga ujian lintas modul **memerlukan entitas exam series terpisah**. Jangan mengubah foreign key dengan cara destruktif. `translation_prompts.grammar_focus` mempunyai whitelist dengan 9 nilai, sudah mencakup tujuh tense + modal + passive. Verifikasi nama slug nyata dari seed sebelum mapping.

## Kriteria selesai

- Halaman ringkasan dapat dilihat tanpa login.
- Dua ujian tampak jelas dan tidak tercampur; ujian 1 13 modul, ujian 2 tenses-writing-listening.
- Siswa login wajib untuk ujian; jawaban dan kunci tidak bocor sebelum submit.
- Skor dan penjelasan tetap konsisten setelah reload.
- Feedback AI berbahasa Indonesia; alternatif jawaban benar tidak ditolak mentah-mentah; biaya API dibatasi.
- Tidak ada kehilangan data lama, seed/migrasi aman dijalankan ulang.
- Test dijalankan dan hasilnya didokumentasikan dengan bukti, tidak sekadar klaim.
