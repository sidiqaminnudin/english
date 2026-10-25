# EnglishLab — Blueprint Dua Ujian

> Dokumen spesifikasi, **belum diimplementasikan** sebagai fitur aplikasi. Perubahan mengikuti EnglishLab LMS v1.2 serta patch Writing / Listening dan audio real-human yang telah didiskusikan.

## Tujuan

Memisahkan ujian kelas menjadi dua seri independen: (1) English Fundamentals, (2) Tenses — Writing & Listening. Praktik per modul tetap tersedia dan tidak dihapus.

## Ujian 1 — English Fundamentals (Alphabet sampai Giving Directions)

**Cakupan modul (13)**

1. Alphabet & Spelling (`alphabet-spelling`)
2. Family & Basic Vocabulary (`family-vocabulary`)
3. Cardinal & Ordinal Numbers (`cardinal-ordinal`)
4. Time, Days & Dates (`telling-time-dates`)
5. Countable & Uncountable Nouns (`countable-uncountable`)
6. Singular & Plural Nouns (`singular-plural`)
7. Pronouns (`pronouns`)
8. Simple Present Tense — dasar (`simple-present`)
9. Prepositions (`prepositions`)
10. Conjunctions (`conjunctions`)
11. Adjectives & Adverbs (`adjective-adverb`)
12. Degrees of Comparison (`degrees-comparison`)
13. Giving Directions (`giving-directions`)

**Contoh konfigurasi:** 50 soal pilihan ganda; 60 menit; batas lulus 75/100. Pertanyaan dipilih acak dengan cakupan seluruh modul, mengacak opsi dan menyimpan snapshot soal saat sesi dimulai. Harus dipastikan setiap modul terwakili (misalnya minimal 2 soal/modul); pembobotan akhir dikonfigurasi oleh admin.

## Ujian 2 — Tenses, Writing & Listening

**Cakupan inti (7 tenses):** Simple Present, Simple Past, Simple Future, Present Continuous, Past Continuous, Future Continuous, Present Perfect. Materi modal verbs dan passive voice bersifat pelengkap/opsional, bukan tense.

**Rancangan evaluasi:**

| Bagian | Jumlah | Poin per soal | Total | Catatan |
|---|---:|---:|---:|---|
| Writing tahap A: pilih tense | 15 | 1 | 15 | Penilaian deterministik berdasar metadata soal, dukung konteks ambigu |
| Writing tahap B: buat kalimat Inggris | 15 | 3 | 45 | Validasi AI + rule-based + review jika alternatif benar |
| Listening real human voice | 10 | 4 | 40 | Soal berdasar transkrip, audio tidak boleh ditranskripkan sebelum submit |
| **Total** | **25 unit** | | **100** | 15 prompt writing, 10 pertanyaan listening |

**Usulan durasi:** 90 menit (konfigurasi admin). **Passing score:** 75, final setelah hasil writing tervalidasi; hindari mengklaim lulus pada jawaban berstatus `pending_review`.

### Alur siswa

1. Login dan pilih Ujian 1 atau Ujian 2 pada halaman `/exams` (rute baru, tidak mengubah `/exam` per modul yang lama).
2. Ujian 1: ikuti MCQ lintas modul dan lihat hasil setelah submit.
3. Ujian 2: setiap prompt bahasa Indonesia memperlihatkan pilihan tense terlebih dahulu. Pilihan dikunci saat melanjutkan ke textarea (bisa direvisi sampai submit jika kebijakan mengizinkan).
4. Siswa menulis jawaban positif, negatif, atau pertanyaan sesuai perintah. Server menyimpan jawaban asli dan konteks soal.
5. Listening: pemutar audio di halaman ujian; pilihan ganda tanpa transkrip dan tanpa jawaban benar sebelum submit. Urutan soal dan opsi diacak **sekali** saat sesi dimulai.
6. Submit: nilai objektif dihitung server; nilai writing AI diberi status provisional jika perlu; admin dapat menyelesaikan review.
7. Lihat hasil per bagian, pembahasan, dan saran belajar **setelah** submit/finalisasi sesuai pengaturan admin.

### Bank soal

- Ujian 1 mengambil dari tabel `questions` melalui relasi `modules`, tidak membuat soal duplikat.
- Writing memakai `translation_prompts` (`indonesian`, `grammar_focus`, `model_answer`, `accepted_answers`, `difficulty`), termasuk bank soal ekspansi jika patch sudah terpasang.
- Listening memakai `listening_tracks` dan `listening_questions`, memilih hanya track real-human yang audio-nya tersedia dan teks/soalnya sudah lolos review.
- Pengacakan **disimpan sebagai snapshot**, sehingga refresh tidak mengubah soal, jawaban benar, atau audio.
- Catat metadata versi sumber audio, URL kredit, dan riwayat koreksi untuk reproduktibilitas.

### AI Writing — contoh rubric (maksimal 3 poin/soal)

- Kesetaraan makna dan elemen wajib: 0–1.
- Tata bahasa dan penggunaan tense pada kalimat: 0–1.
- Struktur kalimat, kata kerja, dan kelancaran dasar: 0–1.

Kesalahan ejaan minor dapat menurunkan komponen yang relevan tanpa memaksa nol seluruhnya. Tense tidak harus tunggal untuk pertanyaan yang memang mempunyai beberapa pilihan benar; soal ambigu harus diberi beberapa `accepted_focus` atau ditarik dari pool ujian. Simpan `AI score`, `model version`, `reason`, `confidence`, `review_status`, dan nilai final admin bila ada.

**Keamanan:** Kunci API AI hanya di server; cek otorisasi siswa ke sesi; CSRF; server-side timer; rate limiting; kuota biaya AI; fallback `pending_manual_review`; jangan memasukkan kunci jawaban, transkrip, atau penilaian ke HTML sebelum ujian selesai.

### Alur implementasi yang aman

1. Periksa skema database dan patch yang sudah terpasang di repo aktual (jangan asumsikan v1.2 identik dengan ZIP awal).
2. Backup PostgreSQL dan snapshot project.
3. Migrasi aditif dengan `CREATE TABLE IF NOT EXISTS`, constraints, FK, indeks, dan transaksi; **jangan DROP/TRUNCATE** tabel lama.
4. Definisikan `exam_series`, `exam_series_modules`, `exam_series_configs`, `exam_series_runs`, `exam_series_items` atau penamaan setara; jangan memaksakan `attempts.module_id` yang tidak nullable menjadi exam lintas modul.
5. Jadikan konfigurasi ujian bisa diubah admin (pertanyaan, bobot, passing, waktu, review rules, published status).
6. Tambahkan halaman `/exams`, `/exams/:slug`, `/exams/run/:id`, `/exams/run/:id/result`, admin `/admin/exam-series` dengan Bootstrap dan EJS.
7. Integrasikan public content `/tenses-summary` atau tautan ke Markdown ringkasan; tetap publik tanpa login.
8. Buat soal/ujian seeding idempotent dengan slug stabil; jangan menduplikasi bank soal yang sudah ada.
9. Jalankan pengujian unit + integration + browser untuk Ujian 1/Ujian 2, privacy, timeout, AI failure, option shuffle, refresh, keyboard/mobile; validasi semua penghitungan skor.
10. Publikasikan setelah guru/admin menyetujui blueprint dan kualitas soal.
