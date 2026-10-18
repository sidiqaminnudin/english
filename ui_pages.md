# UI/UX Pages — Desktop + Mobile (Bootstrap 5)

## Design system
- Identitas visual terinspirasi warna hangat GEKA: orange `#EF7D24`, orange pekat `#C65E0C`, charcoal `#222329`, canvas `#FCFAF7`, mint-hijau `#14866D` untuk sukses; font sistem aman offline (system-ui).
- Header: brand logomark EL + EnglishLab, navigasi Kurikulum, Dashboard (bila login), Login/Daftar. Container maks 1160px, card radius 16px, shadow lembut, akses kontras jelas.
- Breakpoints: mobile <576px, tablet 576–991px, desktop >=992px. Sidebar materi menjadi panel di atas konten pada mobile; tabel admin dapat horizontal-scroll; CTA memenuhi lebar mobile.
- Semua aksi utama memakai HTML `<form>` + keyboard focus style, label dan bantuan teks, feedback benar/salah tidak hanya dengan warna.

## Daftar halaman & alur yang diimplementasikan
| Halaman | Desktop | Mobile |
|---|---|---|
| `/` Homepage publik | hero dua kolom, fitur, modul cards | hero satu kolom, cards stack |
| `/courses` Katalog | modul dalam grid 3 kolom | cards satu kolom |
| `/courses/:slug` Detail course | statistik + daftar modul | susun vertikal |
| `/learn/:moduleSlug` Overview modul | daftar lesson dengan progress | list vertikal |
| `/learn/:moduleSlug/:lessonSlug` Materi | sidebar lesson + artikel Markdown | sidebar di atas artikel |
| `/register` / `/login` | centered auth form | single column, input lebar penuh |
| `/dashboard` | ringkasan progress + upaya terbaru | cards + riwayat stack |
| `/practice/:slug` Setup practice | pemilih topik + indikator pool | form stack |
| `/exam/:slug` Setup exam | kartu konfigurasi & peringatan | kartu penuh layar |
| `/attempts/:id/take` Quiz runner | soal + navigator & progress, countdown | opsi besar, navigasi sticky bottom |
| `/attempts/:id/result` Hasil | ringkasan skor + review setiap soal | review cards stack |
| `/history` Riwayat | responsive table | horizontal scroll |
| `/admin` Dashboard admin | stats + quick links | cards stack |
| `/admin/questions` Bank soal | daftar & filter modul | scroll table |
| `/admin/questions/new` / `:id/edit` | editor pertanyaan 4 opsi | input stack |
| `/admin/lessons/:id/edit` | editor Markdown tinggi | textarea adaptif |
| `/admin/exams` | tabel konfigurasi | cards tiap modul |
| `/404` | halaman error ringkas | sama, responsif |

## Komponen
Navbar, footer, breadcrumbs, section-header, badges level, lesson rows, progress pills, `question-card`, answer choices, practice feedback, timer, score banner, auth prompt, data table. CSS terpusat `src/public/css/styles.css` dan JavaScript progres quiz `src/public/js/attempt.js`.

## Access table
| Guest | Student | Admin |
|---|---|---|
| baca semua materi published | guest + latihan/ujian, riwayat | student + edit materi, soal, ujian |

Halaman untuk modul selain Pronouns aktif sebagai `coming soon`: disiapkan course/module database, tetapi belum memublikasikan materi yang belum didigitalisasi.
