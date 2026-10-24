# Content map EnglishLab LMS v1.2

## Ringkasan

Pembaruan **additive** dari v1.1 yang semula memiliki 13 modul, 55 submateri, 1.305 MCQ.

| Komponen v1.2 | Tambahan | Total estimasi pada seed bersih |
|---|---:|---:|
| Modules | 8 | 21 |
| Lessons | 24 | 79 |
| Pilihan ganda | 198 | 1.503 |
| Translation prompts | 74 | 74 |
| Listening tracks | 8 | 8 |
| Listening questions | 32 | 32 |

## Modul baru

- `simple-past`: uses, nominal, verbal.
- `present-perfect`: form, time-markers, since-for.
- `present-continuous`: uses, spelling-ing, stative.
- `past-continuous`: form, when-while, practice.
- `simple-future`: will, going-to, contrast.
- `future-continuous`: form, uses, contrast.
- `modal-verbs`: ability, obligation, polite.
- `passive-voice`: basics, tense-forms, practice.

## Alur terjemahan

`GET /translation` → user pilih topik/jumlah → `POST /translation/start` → tiap soal di `GET /translation/run/:id`:

1. Tampilan Bahasa Indonesia + selector tense/struktur.
2. Setelah memilih kategori, tampil textarea penulisan Bahasa Inggris.
3. `POST /translation/run/:id/answer` simpan jawaban dan cek kedua aspek.
4. `GET /translation/run/:id/feedback/:ordinal` tampil referensi dan pembahasan.
5. Sesudah seluruh pertanyaan dijawab, `GET /translation/run/:id/result` memberi rekap serta daftar pending.
6. Admin dapat `GET/POST /admin/translation-review` untuk menerima/menolak variasi terjemahan.

Penting: `sentence_verdict='pending'` *bukan berarti salah*. Karena banyak terjemahan valid berbeda-beda, penilaian otomatis berbasis kecocokan jawaban tidak cukup untuk semua kasus.

## Alur listening

`GET /listening` (katalog) → `POST /listening/:slug/start` (login) → `GET /listening/run/:id` (player+soal) → `POST /listening/run/:id/submit` (grade server) → `GET /listening/run/:id/result` (hasil, transcript, pembahasan).

Audio 8 MP3 lokal dengan soal 4 per rekaman; urutan soal dan opsi acak saat memulai sesi. Jawaban benar tidak dikirim di halaman pengerjaan.

## Konten sumber foto dan koreksi

Konten berasal dari 20 foto terbaru untuk tenses dan modals, latihan terjemahan, serta Passive Voice. Materi dibangun ulang dari ide pembelajaran, bukan memfotokopi seluruh isi lembar secara verbatim. Perbaikan yang perlu dijaga:

- *find → found → found* (bukan *founded* jika berarti ditemukan).
- *I have been sad **for two days***, bukan *since two days ago*.
- *must not* (dilarang) ≠ *don't have to* (tidak wajib).
- *will be + V-ing* untuk Future Continuous.
- Makna stative verbs bergantung konteks (*have dinner*, *thinking* dapat menggunakan continuous).
- *be + V3* sebagai dasar passive; *must be cleaned* / *will be closed*.
- Soal berbahasa Indonesia dengan konteks tidak lengkap terkadang memiliki lebih dari satu tense benar; penandaan manual penting.
