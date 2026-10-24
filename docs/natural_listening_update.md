# EnglishLab v1.2 → Natural Listening Patch (v1.3)

## Aktivasi terbaru (24 Oktober 2026)

Atas instruksi terbaru pengguna untuk memakai natural-listening-staging (menggantikan rencana VOA), delapan MP3 neural sudah disalin ke `D:\He3x\english\src\public\audio` dan updater metadata berhasil memperbarui tepat delapan track. Source diidentifikasi sebagai Edge neural TTS, bukan rekaman manusia. URL menggunakan SHA-256 cache-busting.

Backup database sebelum aktivasi: `D:\He3x\english\backups\before-v12-1792830560804.dump`. Backup audio: `D:\He3x\english\backups\audio-before-neural-20261024-152921`. Baseline listening: `D:\He3x\english\backups\neural-activation-baseline.json`.

Verifikasi: hash kedelapan MP3 aktif cocok dengan report; semua field track selain audio_path/source_type/source_credit identik dengan baseline; 32 soal, 5 runs, dan 20 run items tetap identik. HTTP smoke test termasuk streaming MP3 range 206, npm run check, qa:v12, dan git diff --check lulus. Pengguna sebelumnya menyatakan audio staging terdengar natural; agent tidak melakukan pemeriksaan pendengaran atau browser interaktif. Belum deploy ke server eksternal, commit, atau push. Catatan staging di bawah merupakan riwayat sebelum aktivasi ini.

## Hasil integrasi lokal (24 Oktober 2026)

- Delapan MP3 Edge neural berhasil dihasilkan di `D:\He3x\english\backups\natural-listening-staging`, bukan folder publik. Setiap segmen dan track akhir lolos decode FFmpeg.
- Report hash: `D:\He3x\english\db\listening_audio_report.json` (diabaikan Git).
- Backup database: `D:\He3x\english\backups\before-v12-1792825480634.dump`; pg_restore --list berhasil, bukan uji restore penuh.
- Backup audio awal: `D:\He3x\english\backups\natural-listening-20261024-140441\audio`.
- Backup otomatis generator: `D:\He3x\english\backup\listening-legacy-20261024T070732Z`.
- Generator diperbaiki untuk menggunakan resolver sistem dan memvalidasi segmen dialog pendek melalui decode, bukan batas ukuran track penuh.
- Tes struktur, dry-run, npm run check, qa:all, qa:v12, dan regresi autosave lulus.
- Audio publik masih lama; metadata database TIDAK diperbarui. Kualitas melalui mendengarkan, kesesuaian narasi, browser desktop/mobile, dan hak distribusi layanan Edge belum diverifikasi. Jangan menganggap hasil sudah dipublikasikan.

### Langkah berikutnya
Dengarkan delapan file staging, periksa dialog, tempo, dan kecocokan transkrip. Setelah diterima, deploy kedelapan MP3 bersama report, verifikasi SHA-256, lalu jalankan updater metadata. Jangan jalankan updater ketika folder publik masih berisi file lama: pemeriksaan hash sengaja menolaknya. Pastikan backup tersedia dan pulihkan seluruh batch jika publikasi gagal. Periksa ketentuan Edge sebelum hosting publik; Azure adalah alternatif layanan resmi.

## Scope
Delapan sesi listening lama saja. Jangan ubah stem/options/correct_index, transkrip, exam results, user account atau route lain.

## Validasi pascaproses

- [ ] 8 MP3 lama dicadangkan di `backup/listening-legacy-...`
- [ ] 8 MP3 hasil natural neural TTS ada di `src/public/audio/`
- [ ] Dialogue voices berbeda pada pembicara bergantian
- [ ] Tidak ada speaker label (misalnya "Anna colon") yang dibacakan
- [ ] Format MP3 valid dan tidak terpotong
- [ ] Transcript masih 100% konsisten dengan audio
- [ ] Sesi listening tetap 8, pertanyaan tetap 32
- [ ] Jawaban benar dan pembahasan tidak berubah
- [ ] Setelah generate, `node scripts/update_listening_audio_metadata.js` sukses
- [ ] `audio_path` baru mengandung `?v=<hash>` untuk meminimalkan cache basi
- [ ] Manual browser testing: putar 1.0×, 0.8×, 1.2× dan submit salah satu sesi
- [ ] Tidak ada MP3 robotik lama yang disajikan dari Cloudflare/CDN cache

## Kualitas
Untuk A1: target 115–145 kata/menit; A2: 125–155 kata/menit. Kecepatan sebenarnya perlu diukur dan didengarkan; rate TTS `-6%` adalah titik awal, bukan jaminan nilai WPM. Pilih aksen yang konsisten tiap track dan hindari efek suara keras/musik background.

## Catatan lisensi
Suara neural merupakan sintesis layanan pihak ketiga. Periksa Terms of Service dan hak distribusi/hosting dari provider yang dipilih. Azure Speech merupakan opsi resmi; `edge-tts` merupakan wrapper layanan Edge tidak resmi dan bisa berubah. Jangan menyatakan MP3 sebagai suara manusia rekaman asli.
