# Listening audio — sumber dan lisensi

## Yang benar-benar disertakan dalam v1.2

Delapan MP3 di `src/public/audio/` dibuat dari **naskah original EnglishLab** menggunakan aplikasi eSpeak secara offline dan dikonversi ke MP3 dengan FFmpeg. Script, transcript, dan pertanyaan berada di `db/v12_listening.json`.

| Sesi | Level | Fokus | Pertanyaan |
|---|---|---|---:|
| At the Library | A1 | Asking for books | 4 |
| Weekend Plans | A1 | Future plans | 4 |
| Missed the Bus | A2 | Simple Past | 4 |
| At the Café | A1 | Ordering food | 4 |
| A Rainy Afternoon | A2 | Past Continuous | 4 |
| Asking for Directions | A1 | Directions | 4 |
| A New Job | A2 | Present Perfect | 4 |
| At the Clinic | A2 | Modal verbs | 4 |

**Batasan:** rekaman eSpeak terdengar sintetis dan tidak optimal untuk melatih aksen, intonasi alami, atau listening tingkat lanjut. Jangan menyebutnya sebagai native-speaker recordings. Pertimbangkan rekaman voice actor atau TTS kualitas tinggi yang syarat penggunaannya memungkinkan redistribusi.

## Sumber tambahan yang DITEMUKAN, tidak otomatis dibundel

1. **VOA Learning English — Let's Learn English, Level 1**: https://learningenglish.voanews.com/p/5644.html
2. **VOA Lesson 1 Welcome** (percakapan 29 detik plus materi): https://learningenglish.voanews.com/a/lets-learn-english-lesson-one/3111026.html
3. **VOA Everyday Grammar**: https://learningenglish.voanews.com/p/9392.html
4. **LibriVox public-domain audio books**: https://librivox.org/pages/public-domain/

VOA menyatakan materi yang dibuat secara eksklusif oleh VOA (teks, audio, video) public domain dan meminta atribusi. Konten pihak ketiga yang ada di situs mereka **tidak termasuk**. Kebijakan resmi: https://learningenglish.voanews.com/p/6861.html dan https://learningenglish.voanews.com/p/6021.html. Hanya ambil rekaman yang jelas buatan VOA, simpan URL sumber, kredit, hak pakai, dan durasi yang diperiksa.

LibriVox menyebut rekaman mereka public domain di AS tetapi memperingatkan statusnya bisa berbeda menurut negara. Untuk hosting di Indonesia, verifikasi hak pakai rekaman dan naskah secara terpisah.

**Tidak** menyematkan audio dari situs berhak cipta secara diam-diam, tidak menganggap konten *gratis didengar* sama dengan *boleh di-host ulang*. Audio pihak ketiga belum diunduh atau dimasukkan paket ini.

## Cara mengganti rekaman sintetis

- Siapkan file MP3 legal dengan intonasi dan kejelasan yang sesuai transcript.
- Tempatkan di `src/public/audio/<slug>.mp3` (atau nama baru).
- Jika mengganti nama, perbarui `listening_tracks.audio_path` pada database untuk slug yang relevan. Seeder dengan `ON CONFLICT DO NOTHING` tidak mengganti file/path yang sudah ada.
- Uji akses HTML5 audio pada Chrome Android, Firefox, dan Safari.
- Periksa durasi/bitrate, normalization volume, hak redistribusi, dan berikan credit sesuai lisensi.
