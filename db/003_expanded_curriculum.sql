-- EnglishLab LMS extension: 12 modules, 48 lessons, 1,200 reviewed template-based MCQs.
-- IMPORTANT: run AFTER db:init AND db:seed (Pronouns).
-- Idempotent: existing lessons/questions are NOT overwritten; previously unpublished modules with lessons are NOT forcibly republished.
BEGIN;
UPDATE modules SET is_published=TRUE WHERE slug='alphabet-spelling' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'letter-names','English Alphabet A–Z','Pelafalan nama huruf, bukan bunyi huruf di dalam kata.','# English Alphabet: A–Z
Ada **26 huruf** bahasa Inggris. Nama huruf berbeda dari cara huruf berbunyi dalam sebuah kata. Pada latihan *spelling*, sebutkan **nama huruf satu per satu**.

| Huruf | Pelafalan (IPA, American) | Panduan sederhana |
|---|---|---|
| A / E / I | /eɪ/ · /iː/ · /aɪ/ | ei · ii · ai |
| B / C / D / G / P / T / V | /biː/ · /siː/ · /diː/ · /dʒiː/ · /piː/ · /tiː/ · /viː/ | bii · sii · dii · jii · pii · tii · vii |
| F / L / M / N / S / X | /ɛf/ · /ɛl/ · /ɛm/ · /ɛn/ · /ɛs/ · /ɛks/ | ef · el · em · en · es · eks |
| H / J / K | /eɪtʃ/ · /dʒeɪ/ · /keɪ/ | eich · jei · kei |
| O / Q / U / W / Y | /oʊ/ · /kjuː/ · /juː/ · /ˈdʌbəl.juː/ · /waɪ/ | ou · kiu · yu · dabel-yu · wai |
| R / Z | /ɑɹ/ · /ziː/ | ar · zii (AS) |

**Catatan:** Z biasanya **zed** /zɛd/ dalam British English, **zee** /ziː/ dalam American English. Nama huruf **A** /eɪ/ bukan /a/ bahasa Indonesia.

**Latihan:** SPELL: **B-A-G**, **C-A-T**, **E-X-A-M**. Ucapkan perlahan dulu, lalu naikkan kecepatan.',1,TRUE FROM modules m WHERE m.slug='alphabet-spelling'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'spelling-words','Spelling Words','Mengeja kata dari huruf menggunakan pelafalan alfabet Inggris.','# Spelling Words
**Spell** berarti menyebutkan huruf-huruf dalam sebuah kata secara berurutan. Jika seseorang bertanya *How do you spell your name?*, jawab dengan nama huruf bahasa Inggris.

## Contoh
- **book** → B–O–O–K (bee, oh, oh, kay)
- **weather** → W–E–A–T–H–E–R
- **vessel** → V–E–S–S–E–L
- **compass** → C–O–M–P–A–S–S
- **voyages** → V–O–Y–A–G–E–S

## Dua keterampilan yang berbeda
**Spelling** menyebutkan huruf; **pronunciation** menyebutkan bunyi sebuah kata. Misalnya *knife* dieja K–N–I–F–E, tetapi huruf **k** tidak terdengar ketika katanya diucapkan.

## Percakapan
A: *How do you spell “bridge”?*  
B: *B–R–I–D–G–E.*

Coba eja nama kota, nama keluarga, dan kata benda di sekitarmu. Gunakan alfabet Inggris, bukan nama huruf Indonesia.',2,TRUE FROM modules m WHERE m.slug='alphabet-spelling'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'decode-spelling','Decode Letter Names','Mengubah rangkaian nama huruf menjadi kata yang benar.','# Decode Letter Names
Pada latihan ini, baca **nama huruf Inggris** dan susun kembali kata aslinya.

## Contoh dari materi
- **si–yu–pi–bi–ou–ei–ar–di** → **cupboard** (lemari)
- **em–ei–ji–ei–zed–ai–en** → **magazine** (majalah; ejaan Z bisa *zee/zed*)
- **bi–ai–ou–el–ou–ji–wai** → **biology** (biologi)
- **di–ar–ei–es–es** → **dress** (gaun)

Perhatikan nama huruf seperti **G** (*jee*), **J** (*jay*), dan **Y** (*why*). Nama huruf **I** (*eye*) juga berbeda dengan **E** (*ee*).

## Tips latihan
1. Dengarkan/simak satu nama huruf.
2. Ubah menjadi simbol alfabet besar (contoh *kay* → K).
3. Gabungkan tanpa spasi.
4. Periksa ejaan dan makna.

**Penting:** ejaan adalah bentuk tertulis. Jangan mengira bunyi kata selalu sama dengan nama setiap hurufnya.',3,TRUE FROM modules m WHERE m.slug='alphabet-spelling'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'spelling-context','Spelling in Daily Conversations','Bertanya dan menjawab ejaan pada situasi sehari-hari.','# Spelling in Daily Conversations
Kamu mungkin harus mengeja nama, email, alamat, atau nama tempat saat mendaftar kelas dan menelepon layanan pelanggan.

## Ungkapan penting
- **How do you spell that?** = Bagaimana mengejanya?
- **Could you spell your surname, please?** = Bisa eja nama belakang Anda?
- **Is that B or D?** = Itu huruf B atau D?
- **Could you repeat the last letter?** = Tolong ulangi huruf terakhir.

## Dialog
A: *Could you spell “Wilson” for me?*  
B: *Sure. W–I–L–S–O–N.*  
A: *Was the second letter I?*  
B: *Yes, that''s right.*

## Latihan mandiri
Tulis lima nama benda yang sering kamu pakai. Eja dengan lantang, lalu minta teman mengecek urutan huruf. Untuk email, **at** dibaca untuk @, dan **dot** untuk titik.',4,TRUE FROM modules m WHERE m.slug='alphabet-spelling'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='alphabet-spelling' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='family-vocabulary' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'family-members','Family Members','Hubungan keluarga inti, keluarga besar, dan kata ganti relasi.','# Family Members
Kosakata tentang hubungan keluarga membantu saat memperkenalkan diri, menceritakan keluarga, dan membuat deskripsi sederhana.

| Indonesia | English | Indonesia | English |
|---|---|---|---|
| ayah / ibu | father / mother | anak laki-laki / perempuan | son / daughter |
| kakek / nenek | grandfather / grandmother | saudara laki-laki / perempuan | brother / sister |
| paman / bibi | uncle / aunt | sepupu | cousin |
| keponakan laki-laki / perempuan | nephew / niece | cucu laki-laki / perempuan | grandson / granddaughter |
| suami / istri | husband / wife | orang tua | parents |
| anak-anak | children | cucu (umum) | grandchild |

**Parents** artinya *orang tua* (ayah dan ibu), sedangkan **relatives** artinya kerabat. **Cousin** bisa laki-laki maupun perempuan.

**Contoh:** *My uncle is my mother''s brother.* (Pamanku adalah saudara laki-laki ibuku.)

**Latihan:** Jelaskan hubungan 4 anggota keluarga tanpa menyebut namanya terlebih dahulu.',1,TRUE FROM modules m WHERE m.slug='family-vocabulary'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'extended-family','Extended Family & Life Events','Istilah keluarga besar, mertua, dan status keluarga.','# Extended Family & Life Events
Setiap hubungan perlu ditentukan dari sudut pandang orang yang berbicara.

- **father-in-law / mother-in-law** = ayah mertua / ibu mertua.
- **brother-in-law / sister-in-law** = ipar laki-laki / perempuan.
- **grandchild** = cucu; **grandson** dan **granddaughter** lebih spesifik.
- **widow** = janda karena pasangan meninggal; **widower** = duda karena pasangan meninggal.
- **orphan** = anak yatim/piatu (pengertian dapat berbeda menurut konteks).

## Contoh hubungan
*My wife''s father is my father-in-law.*  
*My sister''s son is my nephew.*  
*My aunt''s daughter is my cousin.*

**Perhatikan:** *single* berarti belum menikah/tidak berpasangan; berbeda dengan *widow/widower* yang berkaitan dengan kematian pasangan.

**Latihan:** Tulis 3 kalimat menggunakan *in-law*, *cousin*, atau *grandchild*.',2,TRUE FROM modules m WHERE m.slug='family-vocabulary'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'greetings','Greetings and Leave-taking','Sapaan, perkenalan, menanyakan kabar, dan berpamitan.','# Greetings
Ucapan sapaan dipilih berdasarkan situasi dan waktu, bukan diterjemahkan kata demi kata.

| English | Arti |
|---|---|
| Good morning. | Selamat pagi. |
| Good afternoon. | Selamat siang/sore awal. |
| Good evening. | Selamat sore/malam ketika bertemu. |
| Good night. | Selamat malam saat berpamitan/tidur. |
| Nice to meet you. | Senang bertemu denganmu. |
| How are you? | Apa kabar? |
| See you later. | Sampai jumpa. |

## Dialog
A: *Good afternoon. How are you?*  
B: *I''m fine, thank you. And you?*  
A: *I''m doing well. Nice to meet you.*  
B: *Nice to meet you, too.*

**Perhatikan:** *Good evening* dipakai ketika bertemu, sedangkan *Good night* lazim dipakai saat berpisah. *How do you do?* adalah sapaan formal tradisional, bukan pertanyaan tentang cara melakukan sesuatu.',3,TRUE FROM modules m WHERE m.slug='family-vocabulary'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'seasons-periods','Seasons & Parts of the Day','Musim dan penamaan bagian hari.','# Seasons & Parts of the Day
Dalam bahasa Inggris, terdapat empat istilah musim utama pada daerah beriklim sedang: **spring**, **summer**, **autumn/fall**, dan **winter**. Untuk Indonesia, lebih lazim membahas **rainy season** dan **dry season**.

## Waktu dalam sehari
- **morning** = pagi
- **noon / midday** = tengah hari
- **afternoon** = siang sampai sore
- **evening** = sore/malam awal
- **night** = malam
- **midnight** = tengah malam

## Contoh
- *It often rains during the rainy season.*
- *We usually have lunch at noon.*
- *My English class starts in the morning.*
- *Good evening, everyone!* (ketika menyapa pada malam hari)

**Catatan:** kata *season* bisa mengikuti *in* (*in winter*) atau *during* (*during the dry season*). Tidak semua negara memiliki empat musim.',4,TRUE FROM modules m WHERE m.slug='family-vocabulary'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='family-vocabulary' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='cardinal-ordinal' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'cardinal-numbers','Cardinal Numbers','Bilangan pokok untuk menyatakan jumlah.','# Cardinal Numbers
**Cardinal numbers** menyebutkan jumlah: *one, two, three, ten, twenty, one hundred, one thousand*, dan seterusnya.

## Pola penting
- 11–19: **eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen**.
- Puluhan: **twenty, thirty, forty, fifty, sixty, seventy, eighty, ninety**.
- 21–99 (bukan kelipatan 10) memakai tanda hubung: *twenty-one, thirty-four*.
- 100 = **one hundred**, 1,000 = **one thousand**, 1,000,000 = **one million**.

## Contoh
- 85 → **eighty-five**.
- 175 → **one hundred and seventy-five** (umum dalam British English); American English juga memakai *one hundred seventy-five*.
- 2,803 → **two thousand eight hundred and three**.

**Ingat:** *forty* bukan *fourty*, *fifteen* berbeda dari *fifty*, dan *thirteen* berbeda dari *thirty*.',1,TRUE FROM modules m WHERE m.slug='cardinal-ordinal'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'ordinal-numbers','Ordinal Numbers','Bilangan bertingkat untuk urutan dan tanggal.','# Ordinal Numbers
**Ordinal numbers** menunjukkan urutan: pertama, kedua, ketiga, dan seterusnya.

| Angka | Kata | Angka | Kata |
|---|---|---|---|
| 1st | first | 2nd | second |
| 3rd | third | 4th | fourth |
| 5th | fifth | 8th | eighth |
| 9th | ninth | 12th | twelfth |
| 20th | twentieth | 21st | twenty-first |
| 30th | thirtieth | 31st | thirty-first |

## Penggunaan
- *She finished in second place.* (peringkat kedua)
- *My birthday is on March twentieth.*
- *Our office is on the third floor.*

**Aturan akhiran:** 1st, 2nd, 3rd, angka lain umumnya *-th*, **kecuali** 11th, 12th, 13th. Angka gabungan mengikuti dua digit terakhir: 21st, 22nd, 23rd, 24th.',2,TRUE FROM modules m WHERE m.slug='cardinal-ordinal'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'decimals-years','Decimals, Big Numbers & Years','Pemisah ribuan, desimal, nomor dan penyebutan tahun.','# Decimals, Big Numbers & Years
Dalam notasi bahasa Inggris, **koma** (,) lazim digunakan untuk pengelompokan ribuan dan **titik** (.) untuk desimal; kebalikan dari kebiasaan penulisan Indonesia.

## Contoh
- 1,250 = **one thousand two hundred and fifty**.
- 7.25 = **seven point two five**.
- 0.045 = **zero point zero four five**.
- 1985 = **nineteen eighty-five** (sebagai tahun).
- 2005 = **two thousand and five**; juga *two thousand five* dalam American English.
- 2026 = **twenty twenty-six**, atau *two thousand and twenty-six*.

## Telepon dan kode
Nomor telepon biasanya dibaca angka demi angka: 91395 → *nine one three nine five*. Angka **0** bisa dibaca *zero* atau *oh* dalam berbagai konteks.

**Catatan:** jangan menghilangkan nol di belakang desimal jika sedang mengeja angka sesuai yang tertulis (mis. 1.20).',3,TRUE FROM modules m WHERE m.slug='cardinal-ordinal'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'fractions-math','Fractions & Basic Math','Pecahan dan operasi hitung dalam bahasa Inggris.','# Fractions & Basic Math
Untuk pecahan, pembilang biasanya dibaca sebagai bilangan pokok dan penyebut sebagai bilangan bertingkat.

- 1/2 = **one half** atau **a half**.
- 1/3 = **one third**.
- 2/3 = **two thirds**.
- 3/4 = **three quarters** atau **three fourths**.
- 5/8 = **five eighths**.

## Operasi hitung
- 7 + 10 = 17 → *Seven plus ten equals seventeen.*
- 25 ÷ 5 = 5 → *Twenty-five divided by five equals five.*
- 8 × 3 = 24 → *Eight times three equals twenty-four.*
- x² = *x squared*; x³ = *x cubed*.

**Ingat:** ketika pembilang lebih dari satu, penyebut biasanya berbentuk plural: *two thirds*, bukan *two third*. Gunakan kata **equals** atau **is equal to** untuk tanda =.',4,TRUE FROM modules m WHERE m.slug='cardinal-ordinal'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='cardinal-ordinal' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='telling-time-dates' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'telling-time','Telling the Time','Membaca jam dengan past, to, quarter, half, dan o’clock.','# Telling the Time
Ada dua gaya populer: gaya digital (*seven ten*) dan gaya percakapan (*ten past seven*).

## Pola
- **07:00** = seven o''clock.
- **07:10** = ten past seven.
- **11:15** = a quarter past eleven.
- **06:30** = half past six.
- **10:45** = a quarter to eleven.
- **08:55** = five to nine.

**Past** digunakan untuk menit 1–30, **to** untuk menit 31–59 dan menyebut jam berikutnya. *Quarter* = 15 menit; *half* = 30 menit.

**AM/PM:** 8:00 a.m. = jam delapan pagi; 8:00 p.m. = jam delapan malam. Pukul 12:00 tengah hari = **noon**, sedangkan 00:00 = **midnight**.

**Pertanyaan:** *What time is it?* → *It''s half past eight.*',1,TRUE FROM modules m WHERE m.slug='telling-time-dates'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'days-months','Days, Months & Time Expressions','Nama hari, bulan, dan pemakaian preposisi on/in/at.','# Days & Months
## Days of the week
**Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday**.

## Months
**January, February, March, April, May, June, July, August, September, October, November, December**.

Nama hari dan bulan selalu menggunakan huruf kapital.

## Prepositions
- **on** Monday, **on** Friday morning, **on** March 20th.
- **in** March, **in** 2026, **in** summer.
- **at** 7 p.m., **at** noon, **at** midnight.

## Contoh
*We study English on Wednesdays.* (setiap Rabu)
*My birthday is in March.* (bulan Maret)
*The exam starts at nine.* (pukul sembilan)

**Jangan tertukar:** *on March 20th* untuk tanggal lengkap, tetapi *in March* untuk bulan saja.',2,TRUE FROM modules m WHERE m.slug='telling-time-dates'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'british-american-dates','British & American Dates','Perbedaan format penulisan dan pembacaan tanggal.','# Dates: British vs American English
Urutan informasi berbeda dan dapat menimbulkan kebingungan saat menulis angka.

| Gaya | Format | Contoh |
|---|---|---|
| British | day–month–year | **20 March 2026** / **20/03/2026** |
| American | month–day–year | **March 20, 2026** / **03/20/2026** |

## Cara membaca
- British: **the twentieth of March, twenty twenty-six**.
- American: **March twentieth, twenty twenty-six**.

## Menggunakan ordinal
1 → *first*, 2 → *second*, 3 → *third*, 5 → *fifth*, 12 → *twelfth*, 20 → *twentieth*, 31 → *thirty-first*.

**Contoh kalimat:** *The concert is on May nineteenth.*

**Tips:** Untuk dokumen internasional, bentuk ISO **2026-03-20** dapat mengurangi salah tafsir angka tanggal.',3,TRUE FROM modules m WHERE m.slug='telling-time-dates'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'time-practice','Telling Time in Context','Membicarakan jadwal, durasi, dan kebiasaan.','# Time in Context
Setelah mampu membaca jam dan tanggal, gunakan keduanya dalam kalimat yang alami.

## Menanyakan jadwal
- *What time does the class begin?* → *It begins at ten a.m.*
- *What day is the exam?* → *It is on Friday.*
- *When is your birthday?* → *It is on March twentieth.*
- *How long does the class last?* → *It lasts two hours.*

## Istilah penting
- **early** = lebih awal
- **late** = terlambat / larut
- **on time** = tepat waktu
- **before** = sebelum
- **after** = setelah
- **every day** = setiap hari

## Contoh
*I usually get up at six in the morning.*
*The bus leaves at a quarter past seven.*
*She arrives ten minutes before class.*

**Perhatikan:** *every day* (dua kata) berarti setiap hari; *everyday* (satu kata) adalah adjective seperti *everyday activities*.',4,TRUE FROM modules m WHERE m.slug='telling-time-dates'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='telling-time-dates' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='countable-uncountable' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'countable-vs-uncountable','Countable vs Uncountable','Membedakan benda yang dapat dihitung dan yang diukur.','# Countable vs Uncountable Nouns
**Countable nouns** memiliki satuan individual: *a book, two books, three chairs*. **Uncountable nouns** biasanya diperlakukan sebagai zat, gagasan, atau keseluruhan: *water, rice, information, furniture*.

## Contoh
| Countable | Uncountable |
|---|---|
| book, apple, student, chair | milk, sugar, advice, music |
| tomato, bag, picture, egg | water, furniture, information, homework |

Countable tunggal memakai **a/an** atau penentu lain. Uncountable umumnya tidak memakai **a/an** secara langsung.

❌ *an information* → ✅ *some information* / *a piece of information*.

**Pengecualian konteks:** *coffee* dapat berarti minuman secara umum (uncountable) atau *a coffee* = satu cangkir kopi saat memesan. **Chicken** dapat berarti ayam sebagai hewan (countable) atau daging ayam (uncountable).',1,TRUE FROM modules m WHERE m.slug='countable-uncountable'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'a-an','Indefinite Articles A / An','Artikel tunggal berdasarkan bunyi awal kata, bukan sekadar huruf.','# A / An
Gunakan **a** atau **an** sebelum **kata benda dapat dihitung tunggal** dalam banyak situasi ketika pembaca belum mengetahui benda yang dimaksud.

- **a** sebelum **bunyi konsonan**: *a cat, a university, a European country*.
- **an** sebelum **bunyi vokal**: *an apple, an egg, an hour, an honest person*.

## Bunyi menentukan pilihan
**University** diawali bunyi /juː/ (seperti y) → **a university**. **Hour** memiliki h tidak terdengar → **an hour**.

## Dalam kalimat
- *She is a teacher.*
- *He bought an umbrella.*
- *I need a pen.*

❌ *She is engineer.* → ✅ *She is an engineer.*

**Ingat:** hindari menggunakan *a/an* langsung dengan *water* atau *furniture* dalam arti umum, tetapi *a bottle of water* benar karena yang dihitung adalah *bottle*.',2,TRUE FROM modules m WHERE m.slug='countable-uncountable'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'some-any','Some / Any / Much / Many','Kuantitas dalam kalimat positif, negatif, dan pertanyaan.','# Some, Any, Much, Many
## Ringkasan
- **some**: sejumlah; umum di kalimat positif, juga tawaran dan permintaan.
- **any**: sejumlah/apa pun; sering pada kalimat negatif dan pertanyaan.
- **many**: banyak + kata benda jamak yang dapat dihitung.
- **much**: banyak + kata benda tidak dapat dihitung.

## Contoh
- *We bought some apples.*
- *There isn''t any milk.*
- *Are there any chairs?*
- *How many books do you have?*
- *How much water do you drink?*

## Nuansa penting
*Would you like some tea?* benar sebagai tawaran. *Do you have any questions?* benar sebagai pertanyaan umum. Dalam kalimat positif sehari-hari **a lot of** sering terasa lebih alami daripada **much**: *I have a lot of homework*.

**Hindari:** ❌ *many furniture* → ✅ *much furniture* / *a lot of furniture*.',3,TRUE FROM modules m WHERE m.slug='countable-uncountable'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'how-much-many','How Much / How Many','Mengajukan pertanyaan tentang jumlah dan ukuran.','# How Much vs How Many
**How many** bertanya jumlah **countable plural**. **How much** bertanya jumlah atau besaran **uncountable**, dan juga bertanya **harga**.

| Questions | Explanation |
|---|---|
| How many students are there? | *students*: countable plural |
| How much rice do you need? | *rice*: uncountable |
| How many bottles of water? | *bottles*: satuan dapat dihitung |
| How much does this book cost? | *how much*: menanyakan harga |

## Quantifiers tambahan
- **a few** + plural countable: *a few friends*.
- **a little** + uncountable: *a little milk*.
- **several** + plural countable: *several chairs*.

**Perhatikan:** *time* dapat berarti waktu secara umum (uncountable, *how much time*), sedangkan *times* bisa berarti kejadian yang dapat dihitung (*how many times?*).',4,TRUE FROM modules m WHERE m.slug='countable-uncountable'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='countable-uncountable' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='singular-plural' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'regular-plurals','Regular Plurals (-s/-es)','Aturan perubahan kata benda menjadi jamak.','# Regular Plurals
Singular berarti satu; plural berarti lebih dari satu. Sebagian besar kata benda membentuk plural dengan **-s**.

- **book → books**, **pen → pens**, **flower → flowers**.
- Kata yang berakhir dengan bunyi sibilan (sering -s, -ss, -sh, -ch, -x, -z) biasanya mendapat **-es**: *bus → buses, box → boxes, watch → watches*.
- Beberapa kata berakhiran **-o** memakai **-es**: *tomato → tomatoes, potato → potatoes*, tetapi *photo → photos, piano → pianos, radio → radios*.

## Contoh
- *This car is expensive.* → *These cars are expensive.*
- *There is one box.* → *There are two boxes.*

**Penting:** plural memengaruhi kata kerja (misal *is → are*) serta determiner (*this → these*). Jangan menganggap semua kata berakhiran -o mendapat -es.',1,TRUE FROM modules m WHERE m.slug='singular-plural'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'y-f-fe-plurals','Plural -y, -f, and -fe','Perubahan ejaan dengan -ies dan -ves serta pengecualiannya.','# Plural Nouns: -y, -f, -fe
## Akhiran -y
Jika ada **konsonan + y**, ganti y menjadi **-ies**:
- *baby → babies*, *city → cities*, *lady → ladies*, *cherry → cherries*.

Jika ada **vokal + y**, umumnya tambah **-s**:
- *boy → boys*, *key → keys*, *day → days*.

## Akhiran -f/-fe
Beberapa kata berubah menjadi **-ves**:
- *knife → knives*, *wolf → wolves*, *leaf → leaves*, *wife → wives*, *shelf → shelves*.

Tetapi **tidak semua**:
- *roof → roofs*, *chief → chiefs*, *belief → beliefs*, *proof → proofs*.

**Latihan:** lihat akhir sebuah kata dahulu, kemudian cek apakah termasuk pengecualian sebelum membentuk pluralnya.',2,TRUE FROM modules m WHERE m.slug='singular-plural'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'irregular-plurals','Irregular & Unchanged Plurals','Bentuk jamak tidak beraturan dan bentuk tanpa perubahan.','# Irregular Plural Nouns
Tidak semua kata benda memakai akhiran -s atau -es. Sebagian mengalami perubahan vokal dan sebagian tidak berubah sama sekali.

| Singular | Plural |
|---|---|
| man | men |
| woman | women |
| child | children |
| foot | feet |
| tooth | teeth |
| mouse | mice |
| goose | geese |
| person | people |
| ox | oxen |
| sheep | sheep |
| deer | deer |

**Fish** sering tidak berubah pada bentuk jamak ketika membahas ikan secara umum (*three fish*). **Fishes** dapat digunakan khususnya untuk spesies ikan yang berbeda.

## Contoh
- *One child is reading.* → *Two children are reading.*
- *This mouse is small.* → *These mice are small.*

Hafalkan bentuk tidak beraturan karena tidak selalu dapat diprediksi dari ejaan.',3,TRUE FROM modules m WHERE m.slug='singular-plural'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'plural-agreement','Plural in Sentences','Menyesuaikan kata kerja, artikel, dan penunjuk untuk bentuk jamak.','# Plural Agreement in Sentences
Saat kata benda menjadi plural, bagian kalimat lain dapat ikut berubah.

## Contoh transformasi
- *The girl **is** reading a story.* → *The girls **are** reading stories.*
- *This child **is** happy.* → *These children **are** happy.*
- *There **is** a chair.* → *There **are** chairs.*
- *She **has** a book.* → *They **have** books.*

## Penunjuk
- **this / that** + singular, contoh: *this apple is...*
- **these / those** + plural, contoh: *these apples are...*

## Kesalahan umum
❌ *The childrens are happy.* → ✅ *The children are happy.*
❌ *Those box is heavy.* → ✅ *Those boxes are heavy.*

**Catatan:** *information* tidak menjadi *informations* dan biasanya menggunakan kata kerja tunggal: *The information is useful*.',4,TRUE FROM modules m WHERE m.slug='singular-plural'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='singular-plural' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='simple-present' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'nominal-simple-present','Nominal Simple Present (am/is/are)','Kalimat nominal menggunakan to be.','# Nominal Simple Present
Kalimat nominal menjelaskan identitas, keadaan, atau lokasi dengan **am / is / are**, tanpa kata kerja tindakan utama.

| Subject | To be | Contoh |
|---|---|---|
| I | am | I am a student. |
| he/she/it | is | She is happy. |
| you/we/they | are | They are ready. |

## Bentuk
**(+)** Subject + am/is/are + complement: *He is a teacher.*  
**(-)** Subject + am/is/are + not + complement: *He is not a teacher.*  
**(?)** Am/Is/Are + subject + complement?: *Is he a teacher?*

## Kesalahan umum
❌ *She are a doctor.* → ✅ *She is a doctor.*
❌ *He does not is tired.* → ✅ *He is not tired.*

Untuk membicarakan status atau sifat, **jangan** menambahkan *do/does* sebelum *am/is/are* dalam kalimat negatif biasa.',1,TRUE FROM modules m WHERE m.slug='simple-present'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'verbal-simple-present','Verbal Simple Present','Kegiatan rutin dan perubahan kata kerja -s/-es.','# Verbal Simple Present
Digunakan untuk **kebiasaan**, **fakta umum**, jadwal yang tetap, dan keadaan berulang.

## Rumus positif
- **I / you / we / they + V1** → *They work every day.*
- **he / she / it + V1-s/-es** → *She works every day.*

Contoh perubahan: *study → studies*, *watch → watches*, *go → goes*, *have → has*, *play → plays*.

## Kesalahan umum
❌ *He go to school.* → ✅ *He goes to school.*
❌ *She studys English.* → ✅ *She studies English.*

## Kata petunjuk
*always, usually, often, sometimes, never, every day, on Mondays*.

**Perhatikan:** kata kerja diberi -s/-es pada **he/she/it**, tetapi setelah *does/doesn''t*, kata kerja kembali ke bentuk dasar: *She doesn''t go*.',2,TRUE FROM modules m WHERE m.slug='simple-present'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'do-does','Do / Does / Don''t / Doesn''t','Membuat kalimat tanya dan negatif verbal.','# Do / Does
Gunakan **do/does** untuk membuat pertanyaan dan negatif **verbal** dalam Simple Present.

| Subject | Auxiliary |
|---|---|
| I, you, we, they | do / don''t |
| he, she, it | does / doesn''t |

## Pola
- **(?)** *Does she work here?* → *Yes, she does.* / *No, she doesn''t.*
- **(-)** *He does not play football.*
- **(?)** *Do they speak English?* → *Yes, they do.*
- **(-)** *We don''t eat meat.*

**Penting:** setelah *do/does/don''t/doesn''t*, gunakan kata kerja dasar (V1).  
❌ *Does she works?* → ✅ *Does she work?*

**Bedakan dengan to be:** *Is she happy?* (bukan *Does she happy?*) karena *happy* adalah adjective, bukan kata kerja tindakan.',3,TRUE FROM modules m WHERE m.slug='simple-present'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'frequency-adverbs','Adverbs of Frequency','Posisi always, usually, often, sometimes, rarely, never.','# Adverbs of Frequency
Kata keterangan frekuensi menunjukkan seberapa sering sesuatu terjadi: **always, usually, often, sometimes, rarely, never**.

## Posisi dalam kalimat
- **Sebelum kata kerja utama:** *She usually goes to school by bus.*
- **Setelah to be:** *He is always on time.*
- **Setelah auxiliary pertama:** *They have never visited Bali.* (contoh Perfect; prinsip posisi tetap berguna)

## Contoh
*I often study at night.*  
*She rarely eats fast food.*  
*We sometimes play football.*  
*They are usually friendly.*

## Keterangan yang lebih spesifik
*every day*, *twice a week*, *on Sundays*, *once a month*.

**Ingat:** *never* sudah bermakna negatif; hindari *I don''t never ...* dalam English standar, gunakan *I never ...*.',4,TRUE FROM modules m WHERE m.slug='simple-present'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='simple-present' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='prepositions' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'place-prepositions','Prepositions of Place','Letak benda dan orang: in, on, at, between, among.','# Prepositions of Place
Prepositions menerangkan hubungan suatu benda atau orang dengan lokasi lain.

- **in**: di dalam *The keys are in the bag.*
- **on**: di atas/menempel permukaan *The book is on the table.*
- **under / beneath**: di bawah *The cat is under the chair.*
- **behind**: di belakang *The shop is behind the school.*
- **between**: di antara dua (atau beberapa yang dipandang satu per satu) *The bank is between the café and the school.*
- **among**: di antara sebuah kelompok *She stood among the students.*
- **next to / beside**: di samping *Sit next to me.*
- **opposite**: berhadapan *The hospital is opposite the post office.*

**Catatan:** *above* menyatakan lebih tinggi tanpa harus bersentuhan; *over* punya banyak makna termasuk di atas dan menutupi/melintasi. Jangan selalu menerjemahkan keduanya menjadi *on*.',1,TRUE FROM modules m WHERE m.slug='prepositions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'time-prepositions','Prepositions of Time (in/on/at)','At untuk jam, on untuk hari/tanggal, in untuk bulan/tahun/periode.','# Prepositions of Time
## At
*at 7 a.m.*, *at noon*, *at midnight*, *at night*.

## On
*on Monday*, *on March 20th*, *on Friday morning*, *on my birthday*.

## In
*in March*, *in 2026*, *in summer*, *in the morning*, *in the afternoon*, *in the evening*.

## Contoh
- *My birthday is on March 20th.*
- *The course begins at ten o''clock.*
- *She was born in 1997.*
- *We usually exercise in the morning.*

**Perhatikan:** *at night* berbeda dengan *in the morning*. Gunakan **on** ketika terdapat hari atau tanggal yang spesifik, walaupun disertai nama bulan.',2,TRUE FROM modules m WHERE m.slug='prepositions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'movement-prepositions','Prepositions of Movement','Dari, menuju, masuk, melewati, dan sepanjang.','# Prepositions of Movement
Prepositions dapat menjelaskan **arah/perpindahan**, bukan hanya lokasi tetap.

| Preposition | Meaning | Example |
|---|---|---|
| to | ke | Go to school. |
| from | dari | Come from Jakarta. |
| into | ke dalam | Walk into the room. |
| out of | keluar dari | Step out of the car. |
| across | menyeberangi | Walk across the road. |
| through | melewati bagian dalam | Drive through the tunnel. |
| along | sepanjang | Walk along the river. |
| toward(s) | menuju arah | Walk towards the station. |

**Bandingkan:** *The child is in the room* (lokasi) dan *The child walks into the room* (perpindahan masuk).

❌ *I go to home.* → ✅ *I go home.* (*home* sering berfungsi sebagai adverb arah tanpa *to*).',3,TRUE FROM modules m WHERE m.slug='prepositions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'duration-prepositions','For / Since / During / Until','Kapan dimulai, berapa lama, dan sampai kapan.','# For, Since, During, Until
- **for + durasi**: *for two hours*, *for three weeks*.
- **since + titik awal waktu**: *since 2020*, *since Monday* (biasanya dalam Perfect tense untuk keadaan yang masih berlangsung).
- **during + peristiwa/periode**: *during the meeting*, *during the holiday*.
- **until / till + akhir waktu**: *until six o''clock*, *until Friday*.

## Contoh
- *I studied for two hours yesterday.*
- *I have lived here since 2020.*
- *Nobody spoke during the exam.*
- *The store is open until nine p.m.*

**Jangan tertukar:** *for 2020* tidak cocok jika yang dimaksud adalah titik awal. *Since two hours* juga tidak tepat untuk durasi (*for two hours*).

**Catatan:** kata **by** sering berarti paling lambat: *Please finish by Friday.* Berbeda dari *until Friday* yang menunjukkan kelanjutan sampai Jumat.',4,TRUE FROM modules m WHERE m.slug='prepositions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='prepositions' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='conjunctions' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'addition-reason','Addition, Reason & Result','And, because, so, so that dan in order to.','# Conjunctions: Addition, Reason, Result
Kata sambung menghubungkan ide dan menunjukkan hubungan logis.

- **and** = dan: *She reads and writes well.*
- **because** + klausa = karena: *I stayed home because I was sick.*
- **so** = sehingga/jadi: *It was raining, so we stayed home.*
- **so that** + klausa = supaya: *Speak clearly so that everyone can hear.*
- **in order to** + V1 = untuk: *She studies in order to pass the exam.*

## Bandingkan
*I was tired **because** I worked late.* (alasan)  
*I worked late, **so** I was tired.* (akibat)

**Perhatikan:** *because* biasanya diikuti sebuah klausa (subjek + verba); *because of* diikuti noun/frasa benda: *because of the rain*.',1,TRUE FROM modules m WHERE m.slug='conjunctions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'contrast-conjunctions','But / Although / Whereas / However','Menunjukkan pertentangan atau kontras.','# Contrast Conjunctions
- **but**: *The exam was hard, but I passed.*
- **although / though**: *Although the exam was hard, I passed.*
- **whereas**: *I like tea, whereas my sister likes coffee.*
- **even though**: *Even though it was raining, we played.*
- **however**: penghubung wacana, biasanya setelah tanda titik atau titik koma: *It was raining. However, we went out.*

## Penempatan
Klausa yang diawali *although* bisa muncul di awal atau akhir kalimat: *Although he was tired, he studied.* / *He studied although he was tired.*

**Kesalahan umum:** ❌ *Although it was raining, but we went out.* → ✅ *Although it was raining, we went out.*

**Tips:** pilih *whereas* untuk dua fakta yang berbeda; *although* untuk hal yang mengejutkan/kontras dengan hasilnya.',2,TRUE FROM modules m WHERE m.slug='conjunctions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'condition-conjunctions','If / Unless / As If','Kondisi, pengecualian, dan seolah-olah.','# Condition Conjunctions
## If
Menunjukkan syarat: *If it rains, we will stay at home.* (jika hujan, kami akan di rumah).

## Unless
Artinya **if ... not** dalam banyak konteks: *You won''t pass unless you study.* (= if you do not study).

## As if
Berarti **seolah-olah**: *He talks as if he knows everything.*

## Conditional sederhana
- *If you heat ice, it melts.* (fakta umum: zero conditional)
- *If she comes tomorrow, I will call you.* (kemungkinan masa depan)

**Perhatikan:** untuk kondisi masa depan yang realistis, setelah *if* biasanya gunakan Simple Present, bukan *will*:  
❌ *If she will come, ...* → ✅ *If she comes, ...*

**Jangan menggandakan negasi:** *unless* sendiri sudah memiliki unsur “jika tidak”.',3,TRUE FROM modules m WHERE m.slug='conjunctions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'time-conjunctions','When / While / Before / After / Until','Mengurutkan kejadian dan waktu kegiatan.','# Time Conjunctions
- **when**: ketika *Call me when you arrive.*
- **while**: sementara/ketika dua peristiwa berlangsung *I listened while she spoke.*
- **before**: sebelum *Wash your hands before you eat.*
- **after**: setelah *We left after the show ended.*
- **until**: sampai *Wait here until I return.*
- **as soon as**: segera setelah *I will call as soon as I get home.*

## Kata sambung vs preposition
**After** dapat diikuti klausa (*after he arrived*) atau noun/gerund (*after lunch*, *after eating*).

**Kesalahan umum:** dalam time clause yang merujuk masa depan, biasanya gunakan Simple Present:  
❌ *I''ll call you when I will arrive.*  
✅ *I''ll call you when I arrive.*

**Latihan:** buat kalimat dengan kejadian utama + *before/after/when* untuk mengurutkan aktivitas harian.',4,TRUE FROM modules m WHERE m.slug='conjunctions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='conjunctions' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='adjective-adverb' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'adjective-basics','Adjectives in Sentences','Kata sifat menjelaskan benda/orang setelah to be atau sebelum noun.','# Adjectives
**Adjective** menjelaskan sifat/keadaan orang, benda, atau situasi. Contohnya: *gentle, strong, happy, careful, beautiful, expensive*.

## Posisi utama
- **sebelum noun**: *a beautiful room*, *a careful driver*.
- **setelah linking verb**: *The room is beautiful*, *He feels tired*, *She looks happy*.

## Contoh
- *The test is easy.*
- *He is a good teacher.*
- *The students are quiet.*

**Kesalahan umum:** ❌ *She is beautifully.* → ✅ *She is beautiful.* Karena setelah **is** di sini menjelaskan subject, kita memakai **adjective**.

**Catatan:** adjective bahasa Inggris umumnya tidak berubah bentuk untuk plural: *one beautiful house / two beautiful houses*.',1,TRUE FROM modules m WHERE m.slug='adjective-adverb'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'adverbs-ly','Adverbs of Manner (-ly)','Menggambarkan cara tindakan dilakukan.','# Adverbs of Manner
**Adverb of manner** menjawab pertanyaan **how?** (bagaimana suatu tindakan dilakukan).

## Pembentukan
- *careful → carefully*: *She drives carefully.*
- *quick → quickly*: *He answered quickly.*
- *beautiful → beautifully*: *She sings beautifully.*
- *happy → happily*: ganti konsonan + y → -ily.
- *gentle → gently*: sebagian -le → -ly.

## Perbedaan dengan adjective
*He is **careful*** (sifat orang).  
*He drives **carefully*** (cara mengemudi).

**Catatan:** adverb tidak selalu diakhiri -ly. Lihat submateri irregular adverbs. Hindari mengubah adjective yang menerangkan *be/look/feel* menjadi adverb tanpa alasan.',2,TRUE FROM modules m WHERE m.slug='adjective-adverb'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'irregular-adverbs','Irregular Adverbs','Good/well, fast/fast, hard/hard, late/late.','# Irregular / Flat Adverbs
Tidak semua adverb menambahkan **-ly**. Sebagian mempunyai bentuk yang sama dengan adjective.

| Adjective | Adverb | Example |
|---|---|---|
| good | well | She sings well. |
| fast | fast | He runs fast. |
| hard | hard | They work hard. |
| late | late | We arrived late. |
| early | early | I woke up early. |

## Perbedaan penting
- **hard** = keras/giat; **hardly** = hampir tidak (*I hardly know him*).
- **late** = terlambat; **lately** = akhir-akhir ini (*I''ve been busy lately*).
- **good** menjelaskan noun; **well** sering menjelaskan verb dan juga bisa berarti sehat dalam konteks tertentu.

❌ *He speaks English good.* → ✅ *He speaks English well.*

**Ingat:** *bad → badly* untuk adverb cara yang biasa; **worse** umumnya bentuk komparatif dari *bad/badly*, bukan padanan adverb dasarnya.',3,TRUE FROM modules m WHERE m.slug='adjective-adverb'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'adjective-adverb-context','Choose Adjective or Adverb','Memilih jenis kata sesuai fungsi dalam kalimat.','# Adjective vs Adverb
Lihat **kata apa yang diterangkan**.

- Menjelaskan **noun** → adjective: *a slow bus*.
- Menjelaskan **verb** → adverb: *The bus moves slowly*.
- Menjelaskan keadaan subject setelah **be/seem/feel/look** → sering adjective: *The food smells delicious*.

## Contoh pasangan
- *The child is quiet.* / *The child speaks quietly.*
- *The answer is correct.* / *You answered correctly.*
- *She is a fluent speaker.* / *She speaks fluently.*

## Kesalahan umum
❌ *The music sounds beautifully.* → ✅ *The music sounds beautiful.*
❌ *He finished the test easy.* → ✅ *He finished the test easily.*

**Latihan:** identifikasi kata yang dideskripsikan sebelum memilih *quick/quickly*, *patient/patiently*, atau *sad/sadly*.',4,TRUE FROM modules m WHERE m.slug='adjective-adverb'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='adjective-adverb' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='degrees-comparison' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'positive-comparison','Positive Degree (as…as)','Menyatakan kualitas yang sama atau tidak sama.','# Positive Degree: as ... as
Untuk menyatakan sifat setara, gunakan **as + adjective + as**.

- *This bag is as heavy as that bag.*
- *Rina is as tall as Maya.*
- *The blue car is not as expensive as the red car.*

Bisa juga menggunakan **the same + noun + as**:
- *This watch is the same price as that watch.*
- *We are the same age.*

## Bentuk noun terkait
**old → age**, **high → height**, **long → length**, **wide → width**, **fast → speed**.

**Kesalahan umum:** ❌ *as taller as* → ✅ *as tall as*. Bentuk di tengah harus adjective dasar, bukan comparative.

**Latihan:** bandingkan dua benda yang ada di meja atau dua aktivitas yang menurutmu sama sulitnya.',1,TRUE FROM modules m WHERE m.slug='degrees-comparison'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'comparative-forms','Comparative Degree','Lebih ... daripada: -er than dan more ... than.','# Comparative Degree
Bandingkan **dua** benda/orang/keadaan menggunakan bentuk comparative.

## Pola
- **short adjectives + -er + than**: *tall → taller than*, *small → smaller than*, *big → bigger than*.
- **long adjectives → more + adjective + than**: *more interesting than*, *more expensive than*.
- **konsonan + y → -ier**: *happy → happier than*, *heavy → heavier than*.

## Contoh
- *My bag is heavier than yours.*
- *This lesson is more interesting than the previous one.*
- *A train is usually faster than a bicycle.*

**Pengecualian:** *good → better*, *bad → worse*, *little → less*, *many/much → more*.

❌ *more taller* → ✅ *taller*; ❌ *expensiver* → ✅ *more expensive*.',2,TRUE FROM modules m WHERE m.slug='degrees-comparison'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'superlative-forms','Superlative Degree','Paling ... di antara sekelompok: the -est dan the most.','# Superlative Degree
Untuk mengatakan **yang paling ...** dalam sebuah kelompok, gunakan superlative.

## Pola
- **the + adjective-est**: *the tallest, the biggest, the easiest*.
- **the most + adjective**: *the most beautiful, the most expensive*.

## Contoh
- *Rina is the tallest student in the class.*
- *This is the most comfortable room in the hotel.*
- *That was the easiest exam this semester.*

**Perhatikan:** superlative sering memakai **the**, dan frasa pembanding seperti *in the class* atau *of all*. Bentuk ejaan: *big → biggest*, *busy → busiest*.

**Kesalahan umum:** ❌ *the most tallest* → ✅ *the tallest*; ❌ *the beautifulest* → ✅ *the most beautiful*.',3,TRUE FROM modules m WHERE m.slug='degrees-comparison'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'irregular-comparison','Irregular Comparatives & Superlatives','Good/better/best, bad/worse/worst, dan perubahan tidak beraturan.','# Irregular Degrees of Comparison
Tidak semua adjective bisa dibentuk hanya dengan menambahkan -er/-est.

| Positive | Comparative | Superlative |
|---|---|---|
| good | better | best |
| bad | worse | worst |
| many/much | more | most |
| little (jumlah) | less | least |
| far | farther/further | farthest/furthest |

## Contoh
- *This restaurant is better than that one.*
- *She is the best player on the team.*
- *My score is worse than yesterday.*
- *This is the least expensive option.*

**Catatan:** *farther* sering untuk jarak fisik; *further* juga sering untuk jarak serta konsep tambahan. Keduanya bisa tumpang tindih menurut ragam bahasa.

❌ *gooder* → ✅ *better*.  
❌ *the worstest* → ✅ *the worst*.',4,TRUE FROM modules m WHERE m.slug='degrees-comparison'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='degrees-comparison' ON CONFLICT(module_id) DO NOTHING;
UPDATE modules SET is_published=TRUE WHERE slug='giving-directions' AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'direction-vocabulary','Vocabulary for Directions','Kosakata jalan, simpang, lampu lalu lintas, dan posisi.','# Giving Directions: Vocabulary
Untuk membantu orang menemukan lokasi, kenali istilah dasar berikut.

| English | Indonesia |
|---|---|
| intersection / crossroads | persimpangan / perempatan |
| T-junction | pertigaan |
| roundabout | bundaran |
| traffic lights | lampu lalu lintas |
| pedestrian crossing | penyeberangan pejalan kaki |
| straight ahead | lurus ke depan |
| on the left / right | di sisi kiri / kanan |
| opposite | di seberang/berhadapan |

**Catatan:** *crossroads* tidak selalu sama dengan *crossroad* dalam penggunaan alami; kata yang umum untuk perempatan adalah **intersection** atau **crossroads**.

**Latihan:** cari persimpangan, bundaran, dan lampu lalu lintas di peta sekitar rumahmu, lalu sebutkan istilah Inggrisnya.',1,TRUE FROM modules m WHERE m.slug='giving-directions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'giving-instructions','Giving Directions: Commands','Kalimat perintah untuk menjelaskan jalur.','# Giving Directions: Commands
Gunakan kalimat perintah (**imperative**) dengan kata kerja bentuk dasar.

- **Go straight ahead.** = Jalan terus/lurus.
- **Turn left at the traffic lights.** = Belok kiri di lampu lalu lintas.
- **Turn right at the T-junction.** = Belok kanan di pertigaan.
- **Walk past the bank.** = Lewati bank.
- **Cross the road carefully.** = Seberangi jalan dengan hati-hati.
- **Take the second exit at the roundabout.** = Ambil pintu keluar kedua di bundaran.
- **Make a U-turn where permitted.** = Putar balik di tempat yang diizinkan.

**Tips:** gunakan urutan *First ... Then ... After that ... Finally ...* agar instruksi mudah diikuti. Jangan memberi instruksi berbahaya atau melanggar rambu.',2,TRUE FROM modules m WHERE m.slug='giving-directions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'asking-directions','Asking for Directions Politely','Ungkapan meminta petunjuk jalan dengan sopan.','# Asking for Directions
Cara meminta arah bisa terdengar lebih sopan menggunakan **Excuse me**, **Could you**, dan **please**.

## Contoh pertanyaan
- *Excuse me, where is the nearest hospital?*
- *Could you tell me how to get to the station, please?*
- *Is there a bank near here?*
- *How far is the bus stop from here?*
- *Is it within walking distance?*

## Menjawab
*Go straight for two blocks, then turn left. The station is on your right.*

## Meminta pengulangan
- *Could you repeat that, please?*
- *Do you mean the first or second street?*
- *Thank you for your help.*

**Ingat:** *Where is the station?* merupakan pertanyaan langsung; setelah *Could you tell me ...* gunakan urutan klausa tak langsung: *... where the station is* (bukan *where is the station*).',3,TRUE FROM modules m WHERE m.slug='giving-directions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,'directions-dialogues','Directions in Dialogues','Menggabungkan arah, lokasi, dan pertanyaan.','# Giving Directions in Conversation
Gabungkan kosakata tempat dengan urutan instruksi yang singkat.

## Dialog
A: *Excuse me, could you show me the way to the library?*  
B: *Of course. Go straight ahead until you reach the traffic lights.*  
A: *What should I do at the lights?*  
B: *Turn right, then walk past the bank. The library is on your left.*  
A: *Thank you very much!*  
B: *You''re welcome.*

## Menjelaskan lokasi
- *The café is between the bank and the bookstore.*
- *The pharmacy is opposite the hospital.*
- *The station is next to the park.*

## Cara berlatih
Buat peta sederhana berisi 5 tempat, kemudian tulis dua rute berbeda. Gunakan **straight**, **left**, **right**, **past**, **opposite**, dan **between** secara konsisten.',4,TRUE FROM modules m WHERE m.slug='giving-directions'
ON CONFLICT (module_id,slug) DO NOTHING;
INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug='giving-directions' ON CONFLICT(module_id) DO NOTHING;
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5E08BDBBE2760B008E49',m.id,l.id,'What is the name of the letter ''A'' in English?','medium','Huruf A dieja ''ay'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dee',FALSE,0),('eye',FALSE,1),('pee',FALSE,2),('ay',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-41A97CD90E349FDED894',m.id,l.id,'What is the name of the letter ''B'' in English?','easy','Huruf B dieja ''bee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cue',FALSE,0),('bee',TRUE,1),('ee',FALSE,2),('jay',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C663E029B1D430BFA3FA',m.id,l.id,'What is the name of the letter ''C'' in English?','medium','Huruf C dieja ''see'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ar',FALSE,0),('see',TRUE,1),('ef',FALSE,2),('kay',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-628AF4EDB54720C28ABF',m.id,l.id,'What is the name of the letter ''D'' in English?','medium','Huruf D dieja ''dee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ess',FALSE,0),('dee',TRUE,1),('jee',FALSE,2),('el',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-80AB9E61E90CF0523C1B',m.id,l.id,'What is the name of the letter ''E'' in English?','easy','Huruf E dieja ''ee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tee',FALSE,0),('ee',TRUE,1),('aitch',FALSE,2),('em',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BD678739E8FE7B46F43E',m.id,l.id,'What is the name of the letter ''F'' in English?','medium','Huruf F dieja ''ef'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('you',FALSE,0),('ef',TRUE,1),('eye',FALSE,2),('en',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-88D2390BF04E8054F255',m.id,l.id,'What is the name of the letter ''G'' in English?','hard','Huruf G dieja ''jee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('jay',FALSE,0),('oh',FALSE,1),('vee',FALSE,2),('jee',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C1ED0D569FE18E488F24',m.id,l.id,'What is the name of the letter ''H'' in English?','medium','Huruf H dieja ''aitch'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('pee',FALSE,0),('double-u',FALSE,1),('aitch',TRUE,2),('kay',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F8112A820AD40D8BEB0',m.id,l.id,'What is the name of the letter ''I'' in English?','hard','Huruf I dieja ''eye'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eye',TRUE,0),('el',FALSE,1),('cue',FALSE,2),('ex',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DD11BE5C7336C1539868',m.id,l.id,'What is the name of the letter ''J'' in English?','medium','Huruf J dieja ''jay'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('jay',TRUE,0),('em',FALSE,1),('ar',FALSE,2),('why',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-348D5BAA4F97B2F7C3CF',m.id,l.id,'What is the name of the letter ''K'' in English?','medium','Huruf K dieja ''kay'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ess',FALSE,0),('zee (US)',FALSE,1),('kay',TRUE,2),('en',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91118912DDBFD098E18F',m.id,l.id,'What is the name of the letter ''L'' in English?','medium','Huruf L dieja ''el'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tee',FALSE,0),('ay',FALSE,1),('el',TRUE,2),('oh',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B7FCCBCDE8772FC3622',m.id,l.id,'What is the name of the letter ''M'' in English?','easy','Huruf M dieja ''em'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('em',TRUE,0),('pee',FALSE,1),('you',FALSE,2),('bee',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CA8690BBD8BF896CA10A',m.id,l.id,'What is the name of the letter ''N'' in English?','medium','Huruf N dieja ''en'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cue',FALSE,0),('vee',FALSE,1),('see',FALSE,2),('en',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-23E60F7950EA42FF7D98',m.id,l.id,'What is the name of the letter ''O'' in English?','hard','Huruf O dieja ''oh'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dee',FALSE,0),('oh',TRUE,1),('ar',FALSE,2),('double-u',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8CAB6B9D8FF4C27DCEA3',m.id,l.id,'What is the name of the letter ''P'' in English?','medium','Huruf P dieja ''pee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ee',FALSE,0),('pee',TRUE,1),('ess',FALSE,2),('ex',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D0B0EA477C065FD97C79',m.id,l.id,'What is the name of the letter ''Q'' in English?','medium','Huruf Q dieja ''cue'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tee',FALSE,0),('why',FALSE,1),('ef',FALSE,2),('cue',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AA84123C16217AFF3A7C',m.id,l.id,'What is the name of the letter ''R'' in English?','easy','Huruf R dieja ''ar'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ar',TRUE,0),('you',FALSE,1),('zee (US)',FALSE,2),('jee',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DAA4BD3D4A4F6A8B6586',m.id,l.id,'What is the name of the letter ''S'' in English?','hard','Huruf S dieja ''ess'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('aitch',FALSE,0),('ess',TRUE,1),('vee',FALSE,2),('ay',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A851C008CE9EAA9CA39',m.id,l.id,'What is the name of the letter ''T'' in English?','hard','Huruf T dieja ''tee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tee',TRUE,0),('double-u',FALSE,1),('bee',FALSE,2),('eye',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A7C144B37C06E05351B4',m.id,l.id,'What is the name of the letter ''U'' in English?','hard','Huruf U dieja ''you'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ex',FALSE,0),('see',FALSE,1),('jay',FALSE,2),('you',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F06D40A75910536C51BB',m.id,l.id,'What is the name of the letter ''V'' in English?','hard','Huruf V dieja ''vee'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('why',FALSE,0),('dee',FALSE,1),('kay',FALSE,2),('vee',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-48F559830E6419FEC16E',m.id,l.id,'What is the name of the letter ''W'' in English?','easy','Huruf W dieja ''double-u'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('zee (US)',FALSE,0),('ee',FALSE,1),('el',FALSE,2),('double-u',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A5F7CA54C675110E6E7C',m.id,l.id,'What is the name of the letter ''X'' in English?','medium','Huruf X dieja ''ex'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ex',TRUE,0),('ay',FALSE,1),('ef',FALSE,2),('em',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58CB42889871D1BDDAE5',m.id,l.id,'What is the name of the letter ''Y'' in English?','easy','Huruf Y dieja ''why'' saat menyebut alfabet (American English).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='letter-names' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('why',TRUE,0),('bee',FALSE,1),('jee',FALSE,2),('en',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F8D7010BAAACE2E846C3',m.id,l.id,'Which is the correct letter-by-letter spelling of ''vessel''?','hard','Spelling menuliskan setiap huruf secara berurutan: VESSEL.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('G-A-L-L-E-Y',FALSE,0),('C-R-E-W-S',FALSE,1),('F-E-N-C-E',FALSE,2),('V-E-S-S-E-L',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BDE8419728E12BC32549',m.id,l.id,'Which is the correct letter-by-letter spelling of ''weather''?','hard','Spelling menuliskan setiap huruf secara berurutan: WEATHER.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('V-O-Y-A-G-E-S',FALSE,0),('M-E-S-S-R-O-O-M',FALSE,1),('B-I-O-L-O-G-Y',FALSE,2),('W-E-A-T-H-E-R',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E52B1939357214494E2C',m.id,l.id,'Which is the correct letter-by-letter spelling of ''compass''?','hard','Spelling menuliskan setiap huruf secara berurutan: COMPASS.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('W-H-I-T-E-B-O-A-R-D',FALSE,0),('C-O-M-P-A-S-S',TRUE,1),('L-A-U-N-D-R-Y',FALSE,2),('V-I-S-I-T-O-R',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EDCDCFEA9271F75AC3B8',m.id,l.id,'Which is the correct letter-by-letter spelling of ''galley''?','hard','Spelling menuliskan setiap huruf secara berurutan: GALLEY.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('B-R-I-D-G-E',FALSE,0),('E-X-E-R-C-I-S-E',FALSE,1),('G-A-L-L-E-Y',TRUE,2),('M-A-P-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-272536C64DE0EAE56AD1',m.id,l.id,'Which is the correct letter-by-letter spelling of ''voyages''?','hard','Spelling menuliskan setiap huruf secara berurutan: VOYAGES.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('C-U-P-B-O-A-R-D',FALSE,0),('G-A-L-A-X-Y',FALSE,1),('V-O-Y-A-G-E-S',TRUE,2),('C-R-E-W-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EFA5AB0C6D62302CD84A',m.id,l.id,'Which is the correct letter-by-letter spelling of ''laundry''?','hard','Spelling menuliskan setiap huruf secara berurutan: LAUNDRY.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('L-A-U-N-D-R-Y',TRUE,0),('M-E-S-S-R-O-O-M',FALSE,1),('M-A-G-A-Z-I-N-E',FALSE,2),('H-E-A-T',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8C11E80BF71B81695E26',m.id,l.id,'Which is the correct letter-by-letter spelling of ''maps''?','medium','Spelling menuliskan setiap huruf secara berurutan: MAPS.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('V-I-S-I-T-O-R',FALSE,0),('F-E-N-C-E',FALSE,1),('D-R-E-S-S',FALSE,2),('M-A-P-S',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5C746D6B1C1FCC092F8F',m.id,l.id,'Which is the correct letter-by-letter spelling of ''crews''?','hard','Spelling menuliskan setiap huruf secara berurutan: CREWS.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('B-R-I-D-G-E',FALSE,0),('B-I-O-L-O-G-Y',FALSE,1),('T-H-E-O-R-Y',FALSE,2),('C-R-E-W-S',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-062CBCC90BA9A6B904C2',m.id,l.id,'Which is the correct letter-by-letter spelling of ''messroom''?','easy','Spelling menuliskan setiap huruf secara berurutan: MESSROOM.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('B-R-I-T-I-S-H',FALSE,0),('M-E-S-S-R-O-O-M',TRUE,1),('C-U-P-B-O-A-R-D',FALSE,2),('W-H-I-T-E-B-O-A-R-D',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FF595FA53109AE4E7185',m.id,l.id,'Which is the correct letter-by-letter spelling of ''visitor''?','medium','Spelling menuliskan setiap huruf secara berurutan: VISITOR.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('E-V-E-R-Y-O-N-E',FALSE,0),('V-I-S-I-T-O-R',TRUE,1),('M-A-G-A-Z-I-N-E',FALSE,2),('E-X-E-R-C-I-S-E',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-196C01D35767A555D886',m.id,l.id,'Which is the correct letter-by-letter spelling of ''bridge''?','hard','Spelling menuliskan setiap huruf secara berurutan: BRIDGE.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('F-E-N-C-E',FALSE,0),('G-A-L-A-X-Y',FALSE,1),('M-A-T-H-E-M-A-T-I-C-S',FALSE,2),('B-R-I-D-G-E',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-163094D0C2163136EAC6',m.id,l.id,'Which is the correct letter-by-letter spelling of ''cupboard''?','medium','Spelling menuliskan setiap huruf secara berurutan: CUPBOARD.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('C-U-P-B-O-A-R-D',TRUE,0),('B-I-O-L-O-G-Y',FALSE,1),('H-E-A-T',FALSE,2),('C-R-O-W-N',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EE564FB41DE1866B5093',m.id,l.id,'Which is the correct letter-by-letter spelling of ''magazine''?','easy','Spelling menuliskan setiap huruf secara berurutan: MAGAZINE.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('M-A-G-A-Z-I-N-E',TRUE,0),('W-H-I-T-E-B-O-A-R-D',FALSE,1),('D-R-E-S-S',FALSE,2),('V-E-S-S-E-L',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3D29D856C7F78CA445F4',m.id,l.id,'Which is the correct letter-by-letter spelling of ''fence''?','easy','Spelling menuliskan setiap huruf secara berurutan: FENCE.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('T-H-E-O-R-Y',FALSE,0),('W-E-A-T-H-E-R',FALSE,1),('F-E-N-C-E',TRUE,2),('E-X-E-R-C-I-S-E',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-702FC77FD4F36C96A5A8',m.id,l.id,'Which is the correct letter-by-letter spelling of ''biology''?','hard','Spelling menuliskan setiap huruf secara berurutan: BIOLOGY.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('G-A-L-A-X-Y',FALSE,0),('B-R-I-T-I-S-H',FALSE,1),('C-O-M-P-A-S-S',FALSE,2),('B-I-O-L-O-G-Y',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-83370D205C809EE41969',m.id,l.id,'Which is the correct letter-by-letter spelling of ''whiteboard''?','easy','Spelling menuliskan setiap huruf secara berurutan: WHITEBOARD.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('W-H-I-T-E-B-O-A-R-D',TRUE,0),('H-E-A-T',FALSE,1),('E-V-E-R-Y-O-N-E',FALSE,2),('G-A-L-L-E-Y',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2FC87904D59B27F61B66',m.id,l.id,'Which is the correct letter-by-letter spelling of ''exercise''?','hard','Spelling menuliskan setiap huruf secara berurutan: EXERCISE.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('E-X-E-R-C-I-S-E',TRUE,0),('D-R-E-S-S',FALSE,1),('M-A-T-H-E-M-A-T-I-C-S',FALSE,2),('V-O-Y-A-G-E-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BF52CF7CD601AECEF1D5',m.id,l.id,'Which is the correct letter-by-letter spelling of ''galaxy''?','medium','Spelling menuliskan setiap huruf secara berurutan: GALAXY.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('G-A-L-A-X-Y',TRUE,0),('T-H-E-O-R-Y',FALSE,1),('C-R-O-W-N',FALSE,2),('L-A-U-N-D-R-Y',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-099371C2E841DEC6DE24',m.id,l.id,'Which is the correct letter-by-letter spelling of ''heat''?','easy','Spelling menuliskan setiap huruf secara berurutan: HEAT.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('V-E-S-S-E-L',FALSE,0),('M-A-P-S',FALSE,1),('H-E-A-T',TRUE,2),('B-R-I-T-I-S-H',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DFB73860D0A291D54DD0',m.id,l.id,'Which is the correct letter-by-letter spelling of ''dress''?','hard','Spelling menuliskan setiap huruf secara berurutan: DRESS.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('D-R-E-S-S',TRUE,0),('E-V-E-R-Y-O-N-E',FALSE,1),('W-E-A-T-H-E-R',FALSE,2),('C-R-E-W-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1BDD2268F757F9410F1C',m.id,l.id,'Which is the correct letter-by-letter spelling of ''theory''?','easy','Spelling menuliskan setiap huruf secara berurutan: THEORY.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('T-H-E-O-R-Y',TRUE,0),('M-A-T-H-E-M-A-T-I-C-S',FALSE,1),('C-O-M-P-A-S-S',FALSE,2),('M-E-S-S-R-O-O-M',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F8168C4EC8C15009EB34',m.id,l.id,'Which is the correct letter-by-letter spelling of ''British''?','hard','Spelling menuliskan setiap huruf secara berurutan: BRITISH.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('G-A-L-L-E-Y',FALSE,0),('V-I-S-I-T-O-R',FALSE,1),('B-R-I-T-I-S-H',TRUE,2),('C-R-O-W-N',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-70466E39A8A3D61D8DFC',m.id,l.id,'Which is the correct letter-by-letter spelling of ''everyone''?','medium','Spelling menuliskan setiap huruf secara berurutan: EVERYONE.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('B-R-I-D-G-E',FALSE,0),('E-V-E-R-Y-O-N-E',TRUE,1),('V-E-S-S-E-L',FALSE,2),('V-O-Y-A-G-E-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FE165E9FC15DAA564325',m.id,l.id,'Which is the correct letter-by-letter spelling of ''mathematics''?','hard','Spelling menuliskan setiap huruf secara berurutan: MATHEMATICS.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('W-E-A-T-H-E-R',FALSE,0),('L-A-U-N-D-R-Y',FALSE,1),('C-U-P-B-O-A-R-D',FALSE,2),('M-A-T-H-E-M-A-T-I-C-S',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1BB57CD51B9F834F3812',m.id,l.id,'Which is the correct letter-by-letter spelling of ''crown''?','easy','Spelling menuliskan setiap huruf secara berurutan: CROWN.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-words' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('M-A-G-A-Z-I-N-E',FALSE,0),('C-R-O-W-N',TRUE,1),('C-O-M-P-A-S-S',FALSE,2),('M-A-P-S',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5213F888048B3B5E952F',m.id,l.id,'Which English word is spelled vee – ee – ess – ess – ee – el?','hard','Nama-nama huruf tersebut membentuk kata ''vessel''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('vessel',TRUE,0),('galley',FALSE,1),('crews',FALSE,2),('fence',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2F4A515C08E612EF69DF',m.id,l.id,'Which English word is spelled double-u – ee – ay – tee – aitch – ee – ar?','easy','Nama-nama huruf tersebut membentuk kata ''weather''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('weather',TRUE,0),('voyages',FALSE,1),('messroom',FALSE,2),('biology',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C8D994C745B973449E42',m.id,l.id,'Which English word is spelled see – oh – em – pee – ay – ess – ess?','hard','Nama-nama huruf tersebut membentuk kata ''compass''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('laundry',FALSE,0),('visitor',FALSE,1),('whiteboard',FALSE,2),('compass',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-67781F4D7E57D7E3E6CD',m.id,l.id,'Which English word is spelled jee – ay – el – el – ee – why?','medium','Nama-nama huruf tersebut membentuk kata ''galley''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('exercise',FALSE,0),('galley',TRUE,1),('maps',FALSE,2),('bridge',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-86EB9BA925557368AA01',m.id,l.id,'Which English word is spelled vee – oh – why – ay – jee – ee – ess?','hard','Nama-nama huruf tersebut membentuk kata ''voyages''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('galaxy',FALSE,0),('voyages',TRUE,1),('crews',FALSE,2),('cupboard',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-74DAB7EB34B97D8AB3A0',m.id,l.id,'Which English word is spelled el – ay – you – en – dee – ar – why?','hard','Nama-nama huruf tersebut membentuk kata ''laundry''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('messroom',FALSE,0),('magazine',FALSE,1),('heat',FALSE,2),('laundry',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D8C96B1C02B226F9F1AA',m.id,l.id,'Which English word is spelled em – ay – pee – ess?','hard','Nama-nama huruf tersebut membentuk kata ''maps''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('maps',TRUE,0),('visitor',FALSE,1),('fence',FALSE,2),('dress',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58378926526CA9B9DE7B',m.id,l.id,'Which English word is spelled see – ar – ee – double-u – ess?','medium','Nama-nama huruf tersebut membentuk kata ''crews''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('biology',FALSE,0),('theory',FALSE,1),('crews',TRUE,2),('bridge',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EF5C8B42298128C47293',m.id,l.id,'Which English word is spelled em – ee – ess – ess – ar – oh – oh – em?','medium','Nama-nama huruf tersebut membentuk kata ''messroom''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whiteboard',FALSE,0),('British',FALSE,1),('messroom',TRUE,2),('cupboard',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-47E5F46D14CE14357752',m.id,l.id,'Which English word is spelled vee – eye – ess – eye – tee – oh – ar?','hard','Nama-nama huruf tersebut membentuk kata ''visitor''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('everyone',FALSE,0),('visitor',TRUE,1),('magazine',FALSE,2),('exercise',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-48F5617D57669E24EC2B',m.id,l.id,'Which English word is spelled bee – ar – eye – dee – jee – ee?','hard','Nama-nama huruf tersebut membentuk kata ''bridge''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mathematics',FALSE,0),('bridge',TRUE,1),('fence',FALSE,2),('galaxy',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D17F2FF7E1BFC87C379F',m.id,l.id,'Which English word is spelled see – you – pee – bee – oh – ay – ar – dee?','hard','Nama-nama huruf tersebut membentuk kata ''cupboard''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('biology',FALSE,0),('heat',FALSE,1),('crown',FALSE,2),('cupboard',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-55A867FE5441F7AACA8C',m.id,l.id,'Which English word is spelled em – ay – jee – ay – zee (US) – eye – en – ee?','hard','Nama-nama huruf tersebut membentuk kata ''magazine''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dress',FALSE,0),('vessel',FALSE,1),('magazine',TRUE,2),('whiteboard',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-23C2A1409D4BF6AC8E24',m.id,l.id,'Which English word is spelled ef – ee – en – see – ee?','hard','Nama-nama huruf tersebut membentuk kata ''fence''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fence',TRUE,0),('exercise',FALSE,1),('theory',FALSE,2),('weather',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B57062C6451884F1A501',m.id,l.id,'Which English word is spelled bee – eye – oh – el – oh – jee – why?','medium','Nama-nama huruf tersebut membentuk kata ''biology''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('British',FALSE,0),('compass',FALSE,1),('biology',TRUE,2),('galaxy',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4961AB7A4E7557E59D0E',m.id,l.id,'Which English word is spelled double-u – aitch – eye – tee – ee – bee – oh – ay – ar – dee?','medium','Nama-nama huruf tersebut membentuk kata ''whiteboard''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('everyone',FALSE,0),('galley',FALSE,1),('whiteboard',TRUE,2),('heat',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7631F9342ABA72414587',m.id,l.id,'Which English word is spelled ee – ex – ee – ar – see – eye – ess – ee?','hard','Nama-nama huruf tersebut membentuk kata ''exercise''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('exercise',TRUE,0),('dress',FALSE,1),('mathematics',FALSE,2),('voyages',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FEDFFFE402B27D33E313',m.id,l.id,'Which English word is spelled jee – ay – el – ay – ex – why?','hard','Nama-nama huruf tersebut membentuk kata ''galaxy''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('galaxy',TRUE,0),('theory',FALSE,1),('crown',FALSE,2),('laundry',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-323DA2A07A10058B87E0',m.id,l.id,'Which English word is spelled aitch – ee – ay – tee?','easy','Nama-nama huruf tersebut membentuk kata ''heat''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('heat',TRUE,0),('British',FALSE,1),('vessel',FALSE,2),('maps',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-108E8E2ED698E7CDB30F',m.id,l.id,'Which English word is spelled dee – ar – ee – ess – ess?','medium','Nama-nama huruf tersebut membentuk kata ''dress''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('weather',FALSE,0),('crews',FALSE,1),('dress',TRUE,2),('everyone',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CFF424A4186D69EAFFBE',m.id,l.id,'Which English word is spelled tee – aitch – ee – oh – ar – why?','medium','Nama-nama huruf tersebut membentuk kata ''theory''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('theory',TRUE,0),('mathematics',FALSE,1),('compass',FALSE,2),('messroom',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-718BD94ED6B7CF468916',m.id,l.id,'Which English word is spelled bee – ar – eye – tee – eye – ess – aitch?','hard','Nama-nama huruf tersebut membentuk kata ''British''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('galley',FALSE,0),('visitor',FALSE,1),('British',TRUE,2),('crown',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D3F2A848B373DA83A2DB',m.id,l.id,'Which English word is spelled ee – vee – ee – ar – why – oh – en – ee?','medium','Nama-nama huruf tersebut membentuk kata ''everyone''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('everyone',TRUE,0),('vessel',FALSE,1),('voyages',FALSE,2),('bridge',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-350F4159C747AE050EAC',m.id,l.id,'Which English word is spelled em – ay – tee – aitch – ee – em – ay – tee – eye – see – ess?','hard','Nama-nama huruf tersebut membentuk kata ''mathematics''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cupboard',FALSE,0),('mathematics',TRUE,1),('weather',FALSE,2),('laundry',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0E8A6595426E77FDB362',m.id,l.id,'Which English word is spelled see – ar – oh – double-u – en?','hard','Nama-nama huruf tersebut membentuk kata ''crown''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decode-spelling' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('magazine',FALSE,0),('crown',TRUE,1),('compass',FALSE,2),('maps',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C1A40F147A265A78B95D',m.id,l.id,'Choose the best English expression for: Bagaimana cara mengejanya?','medium','''Bagaimana cara mengejanya?'' dalam konteks materi ini diterjemahkan menjadi ''How do you spell it?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('How do you spell it?',TRUE,0),('Could you repeat the last letter?',FALSE,1),('Is that B or D?',FALSE,2),('Please spell your surname.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2F64CD43166608F99515',m.id,l.id,'What is the Indonesian meaning of ''How do you spell it?''?','easy','Dalam konteks materi, ''How do you spell it?'' bermakna ''Bagaimana cara mengejanya?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Itu huruf B atau D?',FALSE,0),('Huruf pertamanya A.',FALSE,1),('Bisakah Anda mengatakannya sekali lagi?',FALSE,2),('Bagaimana cara mengejanya?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3950F7DAEB1818A8DA6A',m.id,l.id,'Choose the best English expression for: Bisa ulangi huruf terakhir?','medium','''Bisa ulangi huruf terakhir?'' dalam konteks materi ini diterjemahkan menjadi ''Could you repeat the last letter?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Please spell your surname.',FALSE,0),('The first letter is A.',FALSE,1),('Could you repeat the last letter?',TRUE,2),('Is that B or D?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8B429717537AFB6E740D',m.id,l.id,'What is the Indonesian meaning of ''Could you repeat the last letter?''?','hard','Dalam konteks materi, ''Could you repeat the last letter?'' bermakna ''Bisa ulangi huruf terakhir?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Tolong eja nama keluarga Anda.',FALSE,0),('Huruf terakhirnya Z.',FALSE,1),('Bagaimana cara mengeja namamu?',FALSE,2),('Bisa ulangi huruf terakhir?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-828AE8D57808B5BA2875',m.id,l.id,'Choose the best English expression for: Itu huruf B atau D?','easy','''Itu huruf B atau D?'' dalam konteks materi ini diterjemahkan menjadi ''Is that B or D?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('The last letter is Z.',FALSE,0),('Is that B or D?',TRUE,1),('Please spell your surname.',FALSE,2),('The first letter is A.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-999EC6D136E252418245',m.id,l.id,'What is the Indonesian meaning of ''Is that B or D?''?','medium','Dalam konteks materi, ''Is that B or D?'' bermakna ''Itu huruf B atau D?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Namaku dimulai dengan M.',FALSE,0),('Itu huruf B atau D?',TRUE,1),('Huruf pertamanya A.',FALSE,2),('Bisakah Anda mengatakannya sekali lagi?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9275E17B731B9EE8DC0A',m.id,l.id,'Choose the best English expression for: Tolong eja nama keluarga Anda.','medium','''Tolong eja nama keluarga Anda.'' dalam konteks materi ini diterjemahkan menjadi ''Please spell your surname.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('The first letter is A.',FALSE,0),('The last letter is Z.',FALSE,1),('Could you say that again?',FALSE,2),('Please spell your surname.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3EB57B5B5ABE391510C0',m.id,l.id,'What is the Indonesian meaning of ''Please spell your surname.''?','medium','Dalam konteks materi, ''Please spell your surname.'' bermakna ''Tolong eja nama keluarga Anda.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Huruf terakhirnya Z.',FALSE,0),('Bagaimana cara mengeja namamu?',FALSE,1),('Itu benar.',FALSE,2),('Tolong eja nama keluarga Anda.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1FD85B670C7D16DDBC08',m.id,l.id,'Choose the best English expression for: Huruf pertamanya A.','hard','''Huruf pertamanya A.'' dalam konteks materi ini diterjemahkan menjadi ''The first letter is A.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('The last letter is Z.',FALSE,0),('Could you say that again?',FALSE,1),('How do you spell your name?',FALSE,2),('The first letter is A.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1BCF743521F96A3BEDFE',m.id,l.id,'What is the Indonesian meaning of ''The first letter is A.''?','easy','Dalam konteks materi, ''The first letter is A.'' bermakna ''Huruf pertamanya A.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bisa bicara pelan-pelan?',FALSE,0),('Huruf pertamanya A.',TRUE,1),('Bisakah Anda mengatakannya sekali lagi?',FALSE,2),('Namaku dimulai dengan M.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E8BC76D656244352FA2',m.id,l.id,'Choose the best English expression for: Huruf terakhirnya Z.','hard','''Huruf terakhirnya Z.'' dalam konteks materi ini diterjemahkan menjadi ''The last letter is Z.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My name begins with M.',FALSE,0),('The last letter is Z.',TRUE,1),('Could you say that again?',FALSE,2),('How do you spell your name?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B17B94BDEAFC455E786A',m.id,l.id,'What is the Indonesian meaning of ''The last letter is Z.''?','medium','Dalam konteks materi, ''The last letter is Z.'' bermakna ''Huruf terakhirnya Z.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Saya tidak menangkap yang Anda katakan.',FALSE,0),('Huruf terakhirnya Z.',TRUE,1),('Bagaimana cara mengeja namamu?',FALSE,2),('Itu benar.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2DB72CF196BFE5644820',m.id,l.id,'Choose the best English expression for: Bisakah Anda mengatakannya sekali lagi?','medium','''Bisakah Anda mengatakannya sekali lagi?'' dalam konteks materi ini diterjemahkan menjadi ''Could you say that again?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('That''s correct.',FALSE,0),('Could you say that again?',TRUE,1),('How do you spell your name?',FALSE,2),('My name begins with M.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-985E5D3246DB3D1FB65F',m.id,l.id,'What is the Indonesian meaning of ''Could you say that again?''?','easy','Dalam konteks materi, ''Could you say that again?'' bermakna ''Bisakah Anda mengatakannya sekali lagi?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bisa bicara pelan-pelan?',FALSE,0),('Ada dua huruf L.',FALSE,1),('Bisakah Anda mengatakannya sekali lagi?',TRUE,2),('Namaku dimulai dengan M.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D4C5DCFBCB203FAEA672',m.id,l.id,'Choose the best English expression for: Bagaimana cara mengeja namamu?','medium','''Bagaimana cara mengeja namamu?'' dalam konteks materi ini diterjemahkan menjadi ''How do you spell your name?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My name begins with M.',FALSE,0),('That''s correct.',FALSE,1),('Could you speak slowly?',FALSE,2),('How do you spell your name?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-06E9A6AEA059DBBF0AB6',m.id,l.id,'What is the Indonesian meaning of ''How do you spell your name?''?','hard','Dalam konteks materi, ''How do you spell your name?'' bermakna ''Bagaimana cara mengeja namamu?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Saya tidak menangkap yang Anda katakan.',FALSE,0),('Kata itu dieja memakai dua huruf S.',FALSE,1),('Bagaimana cara mengeja namamu?',TRUE,2),('Itu benar.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F650860CF844BF2520F',m.id,l.id,'Choose the best English expression for: Namaku dimulai dengan M.','hard','''Namaku dimulai dengan M.'' dalam konteks materi ini diterjemahkan menjadi ''My name begins with M.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My name begins with M.',TRUE,0),('That''s correct.',FALSE,1),('Could you speak slowly?',FALSE,2),('I didn''t catch that.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-154B7F3CC85D6653C58C',m.id,l.id,'What is the Indonesian meaning of ''My name begins with M.''?','medium','Dalam konteks materi, ''My name begins with M.'' bermakna ''Namaku dimulai dengan M.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Namaku dimulai dengan M.',TRUE,0),('Bisa bicara pelan-pelan?',FALSE,1),('Ada dua huruf L.',FALSE,2),('Tolong tuliskan itu.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3A866956458E5EE927F8',m.id,l.id,'Choose the best English expression for: Itu benar.','medium','''Itu benar.'' dalam konteks materi ini diterjemahkan menjadi ''That''s correct.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I didn''t catch that.',FALSE,0),('There are two letters L.',FALSE,1),('That''s correct.',TRUE,2),('Could you speak slowly?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DA65DA2102B465D625C7',m.id,l.id,'What is the Indonesian meaning of ''That''s correct.''?','hard','Dalam konteks materi, ''That''s correct.'' bermakna ''Itu benar.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bagaimana cara mengejanya?',FALSE,0),('Itu benar.',TRUE,1),('Saya tidak menangkap yang Anda katakan.',FALSE,2),('Kata itu dieja memakai dua huruf S.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C531BBA8538E8FCE73E3',m.id,l.id,'Choose the best English expression for: Bisa bicara pelan-pelan?','medium','''Bisa bicara pelan-pelan?'' dalam konteks materi ini diterjemahkan menjadi ''Could you speak slowly?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Could you speak slowly?',TRUE,0),('I didn''t catch that.',FALSE,1),('There are two letters L.',FALSE,2),('It''s spelled with a double S.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CC8C40A64F046CF5DDCA',m.id,l.id,'What is the Indonesian meaning of ''Could you speak slowly?''?','medium','Dalam konteks materi, ''Could you speak slowly?'' bermakna ''Bisa bicara pelan-pelan?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Tolong tuliskan itu.',FALSE,0),('Bisa ulangi huruf terakhir?',FALSE,1),('Bisa bicara pelan-pelan?',TRUE,2),('Ada dua huruf L.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5DCE132554F0CDB1799B',m.id,l.id,'Choose the best English expression for: Saya tidak menangkap yang Anda katakan.','medium','''Saya tidak menangkap yang Anda katakan.'' dalam konteks materi ini diterjemahkan menjadi ''I didn''t catch that.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Please write it down.',FALSE,0),('I didn''t catch that.',TRUE,1),('There are two letters L.',FALSE,2),('It''s spelled with a double S.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-780EDCBF2250FC9F6235',m.id,l.id,'What is the Indonesian meaning of ''I didn''t catch that.''?','easy','Dalam konteks materi, ''I didn''t catch that.'' bermakna ''Saya tidak menangkap yang Anda katakan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Kata itu dieja memakai dua huruf S.',FALSE,0),('Bagaimana cara mengejanya?',FALSE,1),('Itu huruf B atau D?',FALSE,2),('Saya tidak menangkap yang Anda katakan.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3790C4C82C5F06372FAD',m.id,l.id,'Choose the best English expression for: Ada dua huruf L.','hard','''Ada dua huruf L.'' dalam konteks materi ini diterjemahkan menjadi ''There are two letters L.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='spelling-context' WHERE m.slug='alphabet-spelling'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('There are two letters L.',TRUE,0),('It''s spelled with a double S.',FALSE,1),('Please write it down.',FALSE,2),('How do you spell it?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FF9BAA432E402D2CC972',m.id,l.id,'Choose the best English expression for: ayah','medium','''ayah'' dalam konteks materi ini diterjemahkan menjadi ''father''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mother',FALSE,0),('son',FALSE,1),('daughter',FALSE,2),('father',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F58F67AD372C2B98F514',m.id,l.id,'What is the Indonesian meaning of ''father''?','easy','Dalam konteks materi, ''father'' bermakna ''ayah''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('kakek',FALSE,0),('ayah',TRUE,1),('anak laki-laki',FALSE,2),('saudara laki-laki',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F2A11B96E3761C73D442',m.id,l.id,'Choose the best English expression for: ibu','hard','''ibu'' dalam konteks materi ini diterjemahkan menjadi ''mother''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('daughter',FALSE,0),('brother',FALSE,1),('mother',TRUE,2),('son',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4C55815A3EC35201E007',m.id,l.id,'What is the Indonesian meaning of ''mother''?','medium','Dalam konteks materi, ''mother'' bermakna ''ibu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('saudara perempuan',FALSE,0),('nenek',FALSE,1),('ibu',TRUE,2),('anak perempuan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BEA3BADE59C0DF8B76AA',m.id,l.id,'Choose the best English expression for: anak laki-laki','medium','''anak laki-laki'' dalam konteks materi ini diterjemahkan menjadi ''son''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('brother',FALSE,0),('sister',FALSE,1),('son',TRUE,2),('daughter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CF1E649A6082BFFABBBA',m.id,l.id,'What is the Indonesian meaning of ''son''?','medium','Dalam konteks materi, ''son'' bermakna ''anak laki-laki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('kakek',FALSE,0),('paman',FALSE,1),('anak laki-laki',TRUE,2),('saudara laki-laki',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FFA0348D218FAE34D0D0',m.id,l.id,'Choose the best English expression for: anak perempuan','easy','''anak perempuan'' dalam konteks materi ini diterjemahkan menjadi ''daughter''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandfather',FALSE,0),('daughter',TRUE,1),('brother',FALSE,2),('sister',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-25806D5C9529155427D9',m.id,l.id,'What is the Indonesian meaning of ''daughter''?','medium','Dalam konteks materi, ''daughter'' bermakna ''anak perempuan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('anak perempuan',TRUE,0),('saudara perempuan',FALSE,1),('nenek',FALSE,2),('bibi',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-37EA697C7EAE11247B6D',m.id,l.id,'Choose the best English expression for: saudara laki-laki','hard','''saudara laki-laki'' dalam konteks materi ini diterjemahkan menjadi ''brother''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('brother',TRUE,0),('sister',FALSE,1),('grandfather',FALSE,2),('grandmother',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E5641E33189B633E7E3',m.id,l.id,'What is the Indonesian meaning of ''brother''?','hard','Dalam konteks materi, ''brother'' bermakna ''saudara laki-laki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('kakek',FALSE,0),('paman',FALSE,1),('sepupu',FALSE,2),('saudara laki-laki',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B0BC646EA148C06FEC7E',m.id,l.id,'Choose the best English expression for: saudara perempuan','hard','''saudara perempuan'' dalam konteks materi ini diterjemahkan menjadi ''sister''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandmother',FALSE,0),('uncle',FALSE,1),('sister',TRUE,2),('grandfather',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AF11548A9CCC080C69F1',m.id,l.id,'What is the Indonesian meaning of ''sister''?','hard','Dalam konteks materi, ''sister'' bermakna ''saudara perempuan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('bibi',FALSE,0),('keponakan laki-laki',FALSE,1),('saudara perempuan',TRUE,2),('nenek',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FEF1E8A8508990F6F21C',m.id,l.id,'Choose the best English expression for: kakek','medium','''kakek'' dalam konteks materi ini diterjemahkan menjadi ''grandfather''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandfather',TRUE,0),('grandmother',FALSE,1),('uncle',FALSE,2),('aunt',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A9F02B4B8C15BD92C0E5',m.id,l.id,'What is the Indonesian meaning of ''grandfather''?','medium','Dalam konteks materi, ''grandfather'' bermakna ''kakek''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('paman',FALSE,0),('sepupu',FALSE,1),('keponakan perempuan',FALSE,2),('kakek',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-14D31E3E9EA5C0C92B7E',m.id,l.id,'Choose the best English expression for: nenek','hard','''nenek'' dalam konteks materi ini diterjemahkan menjadi ''grandmother''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('aunt',FALSE,0),('cousin',FALSE,1),('grandmother',TRUE,2),('uncle',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FC4BD59C17FF3FC4BBAA',m.id,l.id,'What is the Indonesian meaning of ''grandmother''?','easy','Dalam konteks materi, ''grandmother'' bermakna ''nenek''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nenek',TRUE,0),('bibi',FALSE,1),('keponakan laki-laki',FALSE,2),('orang tua (ayah dan ibu)',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BBCF0C56452F8B788094',m.id,l.id,'Choose the best English expression for: paman','easy','''paman'' dalam konteks materi ini diterjemahkan menjadi ''uncle''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cousin',FALSE,0),('nephew',FALSE,1),('uncle',TRUE,2),('aunt',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4FF249A47AD51AD67177',m.id,l.id,'What is the Indonesian meaning of ''uncle''?','hard','Dalam konteks materi, ''uncle'' bermakna ''paman''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('paman',TRUE,0),('sepupu',FALSE,1),('keponakan perempuan',FALSE,2),('anak-anak',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-89E4694DD0E62695866D',m.id,l.id,'Choose the best English expression for: bibi','medium','''bibi'' dalam konteks materi ini diterjemahkan menjadi ''aunt''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('niece',FALSE,0),('aunt',TRUE,1),('cousin',FALSE,2),('nephew',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-52541789B5FC4C76E530',m.id,l.id,'What is the Indonesian meaning of ''aunt''?','easy','Dalam konteks materi, ''aunt'' bermakna ''bibi''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ayah',FALSE,0),('bibi',TRUE,1),('keponakan laki-laki',FALSE,2),('orang tua (ayah dan ibu)',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7D26BDD8C163574D6037',m.id,l.id,'Choose the best English expression for: sepupu','easy','''sepupu'' dalam konteks materi ini diterjemahkan menjadi ''cousin''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cousin',TRUE,0),('nephew',FALSE,1),('niece',FALSE,2),('parents',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9B016E3BCDA77D32B36',m.id,l.id,'What is the Indonesian meaning of ''cousin''?','medium','Dalam konteks materi, ''cousin'' bermakna ''sepupu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('keponakan perempuan',FALSE,0),('anak-anak',FALSE,1),('ibu',FALSE,2),('sepupu',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FBFA02D26FAF0E408E9F',m.id,l.id,'Choose the best English expression for: keponakan laki-laki','medium','''keponakan laki-laki'' dalam konteks materi ini diterjemahkan menjadi ''nephew''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('parents',FALSE,0),('children',FALSE,1),('nephew',TRUE,2),('niece',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E6A75B47AD00761E03B2',m.id,l.id,'What is the Indonesian meaning of ''nephew''?','easy','Dalam konteks materi, ''nephew'' bermakna ''keponakan laki-laki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('orang tua (ayah dan ibu)',FALSE,0),('ayah',FALSE,1),('anak laki-laki',FALSE,2),('keponakan laki-laki',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-822015B7F65FECE3F14B',m.id,l.id,'Choose the best English expression for: keponakan perempuan','easy','''keponakan perempuan'' dalam konteks materi ini diterjemahkan menjadi ''niece''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='family-members' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('parents',FALSE,0),('children',FALSE,1),('father',FALSE,2),('niece',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D62DB6D54C9C475B9EF7',m.id,l.id,'Choose the best English expression for: ayah mertua','medium','''ayah mertua'' dalam konteks materi ini diterjemahkan menjadi ''father-in-law''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sister-in-law',FALSE,0),('father-in-law',TRUE,1),('mother-in-law',FALSE,2),('brother-in-law',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-265CA7A18766CE790A23',m.id,l.id,'What is the Indonesian meaning of ''father-in-law''?','easy','Dalam konteks materi, ''father-in-law'' bermakna ''ayah mertua''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('duda karena pasangan meninggal',FALSE,0),('ayah mertua',TRUE,1),('ipar laki-laki',FALSE,2),('suami',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BAE8588E6C35C7D95143',m.id,l.id,'Choose the best English expression for: ibu mertua','medium','''ibu mertua'' dalam konteks materi ini diterjemahkan menjadi ''mother-in-law''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sister-in-law',FALSE,0),('husband',FALSE,1),('mother-in-law',TRUE,2),('brother-in-law',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F0E97A8EC1220B6D89FA',m.id,l.id,'What is the Indonesian meaning of ''mother-in-law''?','hard','Dalam konteks materi, ''mother-in-law'' bermakna ''ibu mertua''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('istri',FALSE,0),('janda karena pasangan meninggal',FALSE,1),('ibu mertua',TRUE,2),('ipar perempuan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ACC6FEA2F7A8B8FE0032',m.id,l.id,'Choose the best English expression for: ipar laki-laki','medium','''ipar laki-laki'' dalam konteks materi ini diterjemahkan menjadi ''brother-in-law''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('husband',FALSE,0),('wife',FALSE,1),('brother-in-law',TRUE,2),('sister-in-law',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A30BD21468395ACAA900',m.id,l.id,'What is the Indonesian meaning of ''brother-in-law''?','easy','Dalam konteks materi, ''brother-in-law'' bermakna ''ipar laki-laki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ipar laki-laki',TRUE,0),('suami',FALSE,1),('duda karena pasangan meninggal',FALSE,2),('anak yatim atau piatu',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F6CF5FBC453C1EFF9042',m.id,l.id,'Choose the best English expression for: ipar perempuan','easy','''ipar perempuan'' dalam konteks materi ini diterjemahkan menjadi ''sister-in-law''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sister-in-law',TRUE,0),('husband',FALSE,1),('wife',FALSE,2),('widower',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09FA925880E91AED072A',m.id,l.id,'What is the Indonesian meaning of ''sister-in-law''?','easy','Dalam konteks materi, ''sister-in-law'' bermakna ''ipar perempuan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ipar perempuan',TRUE,0),('istri',FALSE,1),('janda karena pasangan meninggal',FALSE,2),('cucu',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-769B5DBF7BFBC24100F7',m.id,l.id,'Choose the best English expression for: suami','easy','''suami'' dalam konteks materi ini diterjemahkan menjadi ''husband''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wife',FALSE,0),('widower',FALSE,1),('widow',FALSE,2),('husband',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-53D292BCE0D16F87A1E6',m.id,l.id,'What is the Indonesian meaning of ''husband''?','medium','Dalam konteks materi, ''husband'' bermakna ''suami''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('suami',TRUE,0),('duda karena pasangan meninggal',FALSE,1),('anak yatim atau piatu',FALSE,2),('cucu laki-laki',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3AFDF2E24AEF5EB161DC',m.id,l.id,'Choose the best English expression for: istri','hard','''istri'' dalam konteks materi ini diterjemahkan menjadi ''wife''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('widow',FALSE,0),('orphan',FALSE,1),('wife',TRUE,2),('widower',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-54D25F8215433E4C3880',m.id,l.id,'What is the Indonesian meaning of ''wife''?','medium','Dalam konteks materi, ''wife'' bermakna ''istri''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cucu',FALSE,0),('cucu perempuan',FALSE,1),('istri',TRUE,2),('janda karena pasangan meninggal',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BB3C9B8D991BE73DA528',m.id,l.id,'Choose the best English expression for: duda karena pasangan meninggal','medium','''duda karena pasangan meninggal'' dalam konteks materi ini diterjemahkan menjadi ''widower''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandchild',FALSE,0),('widower',TRUE,1),('widow',FALSE,2),('orphan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F3142478D326B0C481A',m.id,l.id,'What is the Indonesian meaning of ''widower''?','medium','Dalam konteks materi, ''widower'' bermakna ''duda karena pasangan meninggal''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('anak yatim atau piatu',FALSE,0),('cucu laki-laki',FALSE,1),('kerabat',FALSE,2),('duda karena pasangan meninggal',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9ECEA8628968773CB2D7',m.id,l.id,'Choose the best English expression for: janda karena pasangan meninggal','easy','''janda karena pasangan meninggal'' dalam konteks materi ini diterjemahkan menjadi ''widow''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandchild',FALSE,0),('grandson',FALSE,1),('widow',TRUE,2),('orphan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ED3725E46F5DC2007A47',m.id,l.id,'What is the Indonesian meaning of ''widow''?','hard','Dalam konteks materi, ''widow'' bermakna ''janda karena pasangan meninggal''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('janda karena pasangan meninggal',TRUE,0),('cucu',FALSE,1),('cucu perempuan',FALSE,2),('ayah tiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E51820E14D33219668D',m.id,l.id,'Choose the best English expression for: anak yatim atau piatu','easy','''anak yatim atau piatu'' dalam konteks materi ini diterjemahkan menjadi ''orphan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('grandson',FALSE,0),('granddaughter',FALSE,1),('orphan',TRUE,2),('grandchild',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FE805198A73F528FD8F2',m.id,l.id,'What is the Indonesian meaning of ''orphan''?','hard','Dalam konteks materi, ''orphan'' bermakna ''anak yatim atau piatu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('anak yatim atau piatu',TRUE,0),('cucu laki-laki',FALSE,1),('kerabat',FALSE,2),('ibu tiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-20364F5ABC36E1E0EB1F',m.id,l.id,'Choose the best English expression for: cucu','medium','''cucu'' dalam konteks materi ini diterjemahkan menjadi ''grandchild''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('granddaughter',FALSE,0),('relatives',FALSE,1),('grandchild',TRUE,2),('grandson',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0A310C48C5E10060E819',m.id,l.id,'What is the Indonesian meaning of ''grandchild''?','hard','Dalam konteks materi, ''grandchild'' bermakna ''cucu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cucu',TRUE,0),('cucu perempuan',FALSE,1),('ayah tiri',FALSE,2),('ayah mertua',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FDCD942F3C2DDF7FF520',m.id,l.id,'Choose the best English expression for: cucu laki-laki','hard','''cucu laki-laki'' dalam konteks materi ini diterjemahkan menjadi ''grandson''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('granddaughter',FALSE,0),('relatives',FALSE,1),('stepfather',FALSE,2),('grandson',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AA02958D5A2D4E4473E2',m.id,l.id,'What is the Indonesian meaning of ''grandson''?','hard','Dalam konteks materi, ''grandson'' bermakna ''cucu laki-laki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ibu mertua',FALSE,0),('cucu laki-laki',TRUE,1),('kerabat',FALSE,2),('ibu tiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-12E0CE8B4B652AD119C6',m.id,l.id,'Choose the best English expression for: cucu perempuan','medium','''cucu perempuan'' dalam konteks materi ini diterjemahkan menjadi ''granddaughter''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('relatives',FALSE,0),('stepfather',FALSE,1),('stepmother',FALSE,2),('granddaughter',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-98190CDAD694C5117EC2',m.id,l.id,'What is the Indonesian meaning of ''granddaughter''?','easy','Dalam konteks materi, ''granddaughter'' bermakna ''cucu perempuan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ayah mertua',FALSE,0),('ipar laki-laki',FALSE,1),('cucu perempuan',TRUE,2),('ayah tiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-757EE5389CE0146390C5',m.id,l.id,'Choose the best English expression for: kerabat','medium','''kerabat'' dalam konteks materi ini diterjemahkan menjadi ''relatives''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='extended-family' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('relatives',TRUE,0),('stepfather',FALSE,1),('stepmother',FALSE,2),('father-in-law',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BECE2F4724C4FF8F9C69',m.id,l.id,'You meet your teacher at 8 a.m. Say:','easy','Morning is the appropriate greeting in the morning.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good night.',FALSE,0),('Good evening.',FALSE,1),('Goodbye.',FALSE,2),('Good morning.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4C3A0BF4301CC39CFB49',m.id,l.id,'You greet a friend at 7 p.m. Say:','medium','Good evening is a greeting for the evening.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good evening.',TRUE,0),('Good morning.',FALSE,1),('Good night.',FALSE,2),('Goodbye.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB7D070C05E12F67CDBC',m.id,l.id,'You are about to sleep. Say:','hard','Good night is used when saying goodbye or going to sleep.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good night.',TRUE,0),('Good morning.',FALSE,1),('Good afternoon.',FALSE,2),('Hello.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-702EC6D3E037668B908A',m.id,l.id,'Someone says ''Nice to meet you.'' Reply:','medium','A natural reciprocal response adds too.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good night.',FALSE,0),('I''m twelve.',FALSE,1),('I''m hungry.',FALSE,2),('Nice to meet you, too.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-22A39FB42257F20DF079',m.id,l.id,'Your friend asks ''How are you?'' Reply:','medium','How are you asks about your condition.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I''m fine, thank you.',TRUE,0),('At seven.',FALSE,1),('My name is Rio.',FALSE,2),('See you yesterday.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CC55D68747EB8DFA7273',m.id,l.id,'You meet a new customer at 2 p.m. Say:','medium','Afternoon is the appropriate part of the day.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good night.',FALSE,0),('Good morning.',FALSE,1),('See you.',FALSE,2),('Good afternoon.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-642EDB46E47BE451C85D',m.id,l.id,'You leave class and plan to meet again. Say:','easy','See you later is a farewell.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Nice to meet you.',FALSE,0),('Good morning.',FALSE,1),('See you later.',TRUE,2),('How do you do?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AEF0C2EBF340250B2C33',m.id,l.id,'A: How are you? B: _____','medium','Answer a greeting with a description of how you are.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I''m seventeen o''clock.',FALSE,0),('My father a driver.',FALSE,1),('At home is.',FALSE,2),('I''m doing well, thanks.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D4D0F230B9F79DAC6198',m.id,l.id,'A: Hello! B: _____','hard','Hi is a normal reply to Hello.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Hi!',TRUE,0),('Goodbye yesterday.',FALSE,1),('I''m the night.',FALSE,2),('At twelve.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B0790CBA4C94F9437AE2',m.id,l.id,'A: Goodbye! B: _____','easy','Goodbye is a polite response to a farewell.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I have two.',FALSE,0),('My cousin.',FALSE,1),('Goodbye!',TRUE,2),('Good afternoon at sleep.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E805D4972D261A1EE32',m.id,l.id,'At 11 a.m., you greet someone:','easy','11 a.m. is still morning.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('See you tomorrow.',FALSE,0),('Good morning.',TRUE,1),('Good night.',FALSE,2),('Good evening.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-825B221D7D5387ABDE37',m.id,l.id,'You say goodbye at 11 p.m. Say:','medium','Good night is appropriate when parting late in the day.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Welcome.',FALSE,0),('Good night.',TRUE,1),('Good afternoon.',FALSE,2),('Good morning.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-594EDBEA01E612D2C80F',m.id,l.id,'Someone says ''Pleased to meet you.'' Reply:','easy','Return a polite introduction similarly.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('No, I am not.',FALSE,0),('I am from Monday.',FALSE,1),('Pleased to meet you, too.',TRUE,2),('How old your name?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4646095D8C2997E33873',m.id,l.id,'A: Thank you for your help. B: _____','medium','You''re welcome acknowledges thanks.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I''m seven.',FALSE,0),('You''re welcome.',TRUE,1),('Good morning tomorrow.',FALSE,2),('Not yesterday.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D2F89C4512D52E562E97',m.id,l.id,'You want a polite opening to a stranger:','easy','Excuse me is a courteous way to get attention.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Tomorrow.',FALSE,0),('Excuse me.',TRUE,1),('Go away.',FALSE,2),('Never mind you.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2D09DEBA1FE2F4F41834',m.id,l.id,'You greet your classmates as you enter in the morning:','medium','Use Good morning upon arrival in the morning.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('See you yesterday.',FALSE,0),('I am noon.',FALSE,1),('Good morning, everyone.',TRUE,2),('Good night, everyone.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9AE19E8BB8BE7E194388',m.id,l.id,'A: How do you do? B: _____ (formal traditional greeting)','easy','How do you do is traditionally answered with the same phrase.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('At six p.m.',FALSE,0),('I''m going home.',FALSE,1),('Yesterday was fine.',FALSE,2),('How do you do?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0EF017787A416613F25C',m.id,l.id,'Which phrase is normally a farewell, not a meeting greeting?','hard','See you next time implies parting.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('See you next time.',TRUE,0),('Good morning.',FALSE,1),('Hello there.',FALSE,2),('Nice to meet you.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4AE8C38167391784ED8D',m.id,l.id,'You first meet a coworker. You can say:','easy','Nice to meet you introduces a new acquaintance.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('It''s midnight yesterday.',FALSE,0),('Nice to meet you.',TRUE,1),('See you at yesterday.',FALSE,2),('Goodbye already.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E95BB0C113DC570FC255',m.id,l.id,'A: See you on Friday! B: _____','hard','See you then acknowledges a planned next meeting.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('When tomorrow.',FALSE,0),('See you then!',TRUE,1),('Good morning last night.',FALSE,2),('I''m fifteen chairs.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-60F7B62F05D546D10E87',m.id,l.id,'At noon, a formal greeting could be:','hard','Noon begins the afternoon in many contexts.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good night.',FALSE,0),('Good morning tomorrow.',FALSE,1),('Bye forever.',FALSE,2),('Good afternoon.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6220B5AC4FFC0CA2E5AD',m.id,l.id,'You enter a party in the evening:','medium','Good evening is used when greeting at evening events.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Good evening.',TRUE,0),('Good night.',FALSE,1),('See you later.',FALSE,2),('See you tomorrow.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D764541D2A1AACB8938B',m.id,l.id,'A: Welcome to our class! B: _____','medium','Thank you is a natural response to welcome.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Never before.',FALSE,0),('Thank you!',TRUE,1),('Good night then.',FALSE,2),('At Monday.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-00019B38120C5FB6E944',m.id,l.id,'You must leave the meeting. Say:','medium','Goodbye is a polite leave-taking expression.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I have to go now. Goodbye.',TRUE,0),('I am a morning.',FALSE,1),('Nice weather slept.',FALSE,2),('Did before us.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E45366C7CE8AD2C1879',m.id,l.id,'You introduce yourself:','easy','Introducing yourself uses My name is.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='greetings' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Hello, my name is Dita.',TRUE,0),('See you last year.',FALSE,1),('Good night from seven.',FALSE,2),('I have name yesterday.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0042ACEF70162C6F973D',m.id,l.id,'Choose the best English expression for: musim semi','medium','''musim semi'' dalam konteks materi ini diterjemahkan menjadi ''spring''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('summer',FALSE,0),('autumn',FALSE,1),('fall',FALSE,2),('spring',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9C768677C7AE30C1023B',m.id,l.id,'What is the Indonesian meaning of ''spring''?','hard','Dalam konteks materi, ''spring'' bermakna ''musim semi''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim gugur (British English)',FALSE,0),('musim dingin',FALSE,1),('musim kemarau',FALSE,2),('musim semi',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2074C2B3480579724942',m.id,l.id,'Choose the best English expression for: musim panas','easy','''musim panas'' dalam konteks materi ini diterjemahkan menjadi ''summer''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('autumn',FALSE,0),('fall',FALSE,1),('winter',FALSE,2),('summer',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7275D0DEF6CE24B94844',m.id,l.id,'What is the Indonesian meaning of ''summer''?','medium','Dalam konteks materi, ''summer'' bermakna ''musim panas''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim hujan',FALSE,0),('pagi',FALSE,1),('musim panas',TRUE,2),('musim gugur (American English)',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-45C04FA937B2EB386296',m.id,l.id,'Choose the best English expression for: musim gugur (British English)','hard','''musim gugur (British English)'' dalam konteks materi ini diterjemahkan menjadi ''autumn''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('rainy season',FALSE,0),('autumn',TRUE,1),('fall',FALSE,2),('winter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6C7AAD299B52FCF0AABB',m.id,l.id,'What is the Indonesian meaning of ''autumn''?','easy','Dalam konteks materi, ''autumn'' bermakna ''musim gugur (British English)''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('siang hingga sore',FALSE,0),('musim gugur (British English)',TRUE,1),('musim dingin',FALSE,2),('musim kemarau',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73B46C8F5B98F31E72F0',m.id,l.id,'Choose the best English expression for: musim gugur (American English)','easy','''musim gugur (American English)'' dalam konteks materi ini diterjemahkan menjadi ''fall''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('winter',FALSE,0),('rainy season',FALSE,1),('dry season',FALSE,2),('fall',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE0188E049AD86DCB7FC',m.id,l.id,'What is the Indonesian meaning of ''fall''?','easy','Dalam konteks materi, ''fall'' bermakna ''musim gugur (American English)''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim gugur (American English)',TRUE,0),('musim hujan',FALSE,1),('pagi',FALSE,2),('sore atau malam awal',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DC2ADE13E909468AAFC6',m.id,l.id,'Choose the best English expression for: musim dingin','easy','''musim dingin'' dalam konteks materi ini diterjemahkan menjadi ''winter''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('rainy season',FALSE,0),('dry season',FALSE,1),('morning',FALSE,2),('winter',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-890AB8249F826A6AC8C8',m.id,l.id,'What is the Indonesian meaning of ''winter''?','easy','Dalam konteks materi, ''winter'' bermakna ''musim dingin''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim dingin',TRUE,0),('musim kemarau',FALSE,1),('siang hingga sore',FALSE,2),('malam',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DEA2B56657E6DC26DA23',m.id,l.id,'Choose the best English expression for: musim hujan','hard','''musim hujan'' dalam konteks materi ini diterjemahkan menjadi ''rainy season''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('morning',FALSE,0),('afternoon',FALSE,1),('rainy season',TRUE,2),('dry season',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3AFF352ABAA581494B07',m.id,l.id,'What is the Indonesian meaning of ''rainy season''?','medium','Dalam konteks materi, ''rainy season'' bermakna ''musim hujan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sore atau malam awal',FALSE,0),('tengah malam',FALSE,1),('musim hujan',TRUE,2),('pagi',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D6457A24F02AD962A95',m.id,l.id,'Choose the best English expression for: musim kemarau','hard','''musim kemarau'' dalam konteks materi ini diterjemahkan menjadi ''dry season''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('afternoon',FALSE,0),('evening',FALSE,1),('dry season',TRUE,2),('morning',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AB6DD5F73885F7747521',m.id,l.id,'What is the Indonesian meaning of ''dry season''?','easy','Dalam konteks materi, ''dry season'' bermakna ''musim kemarau''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('siang hingga sore',FALSE,0),('malam',FALSE,1),('tengah hari',FALSE,2),('musim kemarau',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E3D36AA3CAB0FAF9E26D',m.id,l.id,'Choose the best English expression for: pagi','medium','''pagi'' dalam konteks materi ini diterjemahkan menjadi ''morning''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('afternoon',FALSE,0),('evening',FALSE,1),('night',FALSE,2),('morning',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-954B84C9B9822021797F',m.id,l.id,'What is the Indonesian meaning of ''morning''?','hard','Dalam konteks materi, ''morning'' bermakna ''pagi''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('matahari terbit',FALSE,0),('pagi',TRUE,1),('sore atau malam awal',FALSE,2),('tengah malam',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ADCA13945EBEE2A1842E',m.id,l.id,'Choose the best English expression for: siang hingga sore','hard','''siang hingga sore'' dalam konteks materi ini diterjemahkan menjadi ''afternoon''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('afternoon',TRUE,0),('evening',FALSE,1),('night',FALSE,2),('midnight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9A9E8ADD2D0CF76C56DC',m.id,l.id,'What is the Indonesian meaning of ''afternoon''?','medium','Dalam konteks materi, ''afternoon'' bermakna ''siang hingga sore''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('matahari terbenam',FALSE,0),('siang hingga sore',TRUE,1),('malam',FALSE,2),('tengah hari',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-19595895A10D986CFCB2',m.id,l.id,'Choose the best English expression for: sore atau malam awal','hard','''sore atau malam awal'' dalam konteks materi ini diterjemahkan menjadi ''evening''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('noon',FALSE,0),('evening',TRUE,1),('night',FALSE,2),('midnight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E97C57664625039CDD2',m.id,l.id,'What is the Indonesian meaning of ''evening''?','hard','Dalam konteks materi, ''evening'' bermakna ''sore atau malam awal''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('matahari terbit',FALSE,0),('musim semi',FALSE,1),('sore atau malam awal',TRUE,2),('tengah malam',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9ABE555443DDCC8D8EC9',m.id,l.id,'Choose the best English expression for: malam','easy','''malam'' dalam konteks materi ini diterjemahkan menjadi ''night''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('night',TRUE,0),('midnight',FALSE,1),('noon',FALSE,2),('sunrise',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BD2A201B5BDD09E5D12',m.id,l.id,'What is the Indonesian meaning of ''night''?','medium','Dalam konteks materi, ''night'' bermakna ''malam''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim panas',FALSE,0),('malam',TRUE,1),('tengah hari',FALSE,2),('matahari terbenam',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-319A2A6A1C7849DCFEB3',m.id,l.id,'Choose the best English expression for: tengah malam','easy','''tengah malam'' dalam konteks materi ini diterjemahkan menjadi ''midnight''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sunrise',FALSE,0),('sunset',FALSE,1),('midnight',TRUE,2),('noon',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-117702798E5F86C22EC1',m.id,l.id,'What is the Indonesian meaning of ''midnight''?','medium','Dalam konteks materi, ''midnight'' bermakna ''tengah malam''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('musim gugur (British English)',FALSE,0),('tengah malam',TRUE,1),('matahari terbit',FALSE,2),('musim semi',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-368443D94CEE0863764E',m.id,l.id,'Choose the best English expression for: tengah hari','medium','''tengah hari'' dalam konteks materi ini diterjemahkan menjadi ''noon''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='seasons-periods' WHERE m.slug='family-vocabulary'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('spring',FALSE,0),('noon',TRUE,1),('sunrise',FALSE,2),('sunset',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AEA73E85017272515D49',m.id,l.id,'Which English number corresponds to 7?','medium','7 dibaca seven (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three hundred and fifteen',FALSE,0),('seven',TRUE,1),('twenty-one',FALSE,2),('seventy-six',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AA50651FAA2514E6D5DB',m.id,l.id,'Which English number corresponds to 13?','medium','13 dibaca thirteen (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-eight',FALSE,0),('eighty-five',FALSE,1),('four hundred and five',FALSE,2),('thirteen',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0D4F1CD872246A5739C2',m.id,l.id,'Which English number corresponds to 15?','medium','15 dibaca fifteen (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifteen',TRUE,0),('thirty',FALSE,1),('ninety-nine',FALSE,2),('nine hundred and twenty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2B5DF68340B6FF1B8FF1',m.id,l.id,'Which English number corresponds to 18?','easy','18 dibaca eighteen (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('forty',FALSE,0),('one hundred and five',FALSE,1),('one thousand two hundred',FALSE,2),('eighteen',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-260E139E964C5B5FE57C',m.id,l.id,'Which English number corresponds to 21?','medium','21 dibaca twenty-one (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one hundred and seventeen',FALSE,0),('two thousand twenty-five',FALSE,1),('twenty-one',TRUE,2),('fifty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0496D935C65E58E03D5C',m.id,l.id,'Which English number corresponds to 28?','medium','28 dibaca twenty-eight (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand eight hundred and three',FALSE,0),('twenty-eight',TRUE,1),('seventy-six',FALSE,2),('one hundred and seventy-five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-65805A7CB49D66935C93',m.id,l.id,'Which English number corresponds to 30?','medium','30 dibaca thirty (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirty',TRUE,0),('eighty-five',FALSE,1),('two hundred and eight',FALSE,2),('fifty thousand twenty-three',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A6942EBFD311993DE154',m.id,l.id,'Which English number corresponds to 40?','medium','40 dibaca forty (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ninety-nine',FALSE,0),('three hundred and fifteen',FALSE,1),('two hundred and fifty-one thousand two hundred and thirty',FALSE,2),('forty',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B0C903AB877859173CD0',m.id,l.id,'Which English number corresponds to 50?','medium','50 dibaca fifty (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one hundred and five',FALSE,0),('four hundred and five',FALSE,1),('one million twenty-five thousand one hundred',FALSE,2),('fifty',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F194AC3A86F9AEF28673',m.id,l.id,'Which English number corresponds to 76?','medium','76 dibaca seventy-six (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nine hundred and twenty',FALSE,0),('seven',FALSE,1),('seventy-six',TRUE,2),('one hundred and seventeen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-93A2E94128C478555BED',m.id,l.id,'Which English number corresponds to 85?','easy','85 dibaca eighty-five (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirteen',FALSE,0),('eighty-five',TRUE,1),('one hundred and seventy-five',FALSE,2),('one thousand two hundred',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1DDAF3ECF42A44ED075C',m.id,l.id,'Which English number corresponds to 99?','easy','99 dibaca ninety-nine (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ninety-nine',TRUE,0),('two hundred and eight',FALSE,1),('two thousand twenty-five',FALSE,2),('fifteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CF9E2EA94A7413126E08',m.id,l.id,'Which English number corresponds to 105?','hard','105 dibaca one hundred and five (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eighteen',FALSE,0),('one hundred and five',TRUE,1),('three hundred and fifteen',FALSE,2),('two thousand eight hundred and three',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D794DD156A73A558F4C5',m.id,l.id,'Which English number corresponds to 117?','easy','117 dibaca one hundred and seventeen (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-one',FALSE,0),('one hundred and seventeen',TRUE,1),('four hundred and five',FALSE,2),('fifty thousand twenty-three',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-796A5C2E8D12CEAF96FE',m.id,l.id,'Which English number corresponds to 175?','easy','175 dibaca one hundred and seventy-five (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two hundred and fifty-one thousand two hundred and thirty',FALSE,0),('twenty-eight',FALSE,1),('one hundred and seventy-five',TRUE,2),('nine hundred and twenty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B7E54DECC3FCB5BE4F34',m.id,l.id,'Which English number corresponds to 208?','hard','208 dibaca two hundred and eight (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two hundred and eight',TRUE,0),('one thousand two hundred',FALSE,1),('one million twenty-five thousand one hundred',FALSE,2),('thirty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FD173713D0D9223240E4',m.id,l.id,'Which English number corresponds to 315?','hard','315 dibaca three hundred and fifteen (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand twenty-five',FALSE,0),('seven',FALSE,1),('forty',FALSE,2),('three hundred and fifteen',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-26EC7F95E1BF10447B7C',m.id,l.id,'Which English number corresponds to 405?','hard','405 dibaca four hundred and five (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifty',FALSE,0),('four hundred and five',TRUE,1),('two thousand eight hundred and three',FALSE,2),('thirteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C486DAE58694BA16BCBD',m.id,l.id,'Which English number corresponds to 920?','medium','920 dibaca nine hundred and twenty (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seventy-six',FALSE,0),('nine hundred and twenty',TRUE,1),('fifty thousand twenty-three',FALSE,2),('fifteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-858740D2BBB880B3C556',m.id,l.id,'Which English number corresponds to 1,200?','easy','1,200 dibaca one thousand two hundred (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eighteen',FALSE,0),('eighty-five',FALSE,1),('one thousand two hundred',TRUE,2),('two hundred and fifty-one thousand two hundred and thirty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E856649A1CEB040779FB',m.id,l.id,'Which English number corresponds to 2,025?','medium','2,025 dibaca two thousand twenty-five (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-one',FALSE,0),('ninety-nine',FALSE,1),('two thousand twenty-five',TRUE,2),('one million twenty-five thousand one hundred',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-357D1349C31D429000DD',m.id,l.id,'Which English number corresponds to 2,803?','hard','2,803 dibaca two thousand eight hundred and three (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one hundred and five',FALSE,0),('two thousand eight hundred and three',TRUE,1),('seven',FALSE,2),('twenty-eight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B14C2C942160AB7EA7C8',m.id,l.id,'Which English number corresponds to 50,023?','easy','50,023 dibaca fifty thousand twenty-three (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifty thousand twenty-three',TRUE,0),('thirteen',FALSE,1),('thirty',FALSE,2),('one hundred and seventeen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5740E20FC36952C5734C',m.id,l.id,'Which English number corresponds to 251,230?','easy','251,230 dibaca two hundred and fifty-one thousand two hundred and thirty (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifteen',FALSE,0),('forty',FALSE,1),('one hundred and seventy-five',FALSE,2),('two hundred and fifty-one thousand two hundred and thirty',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C4B04B2326ABA2AFD0AE',m.id,l.id,'Which English number corresponds to 1,025,100?','easy','1,025,100 dibaca one million twenty-five thousand one hundred (gaya dengan and setelah hundred).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='cardinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eighteen',FALSE,0),('fifty',FALSE,1),('two hundred and eight',FALSE,2),('one million twenty-five thousand one hundred',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3186E102E732271F860C',m.id,l.id,'How do you say the ordinal number 1st?','easy','1st adalah bilangan tingkat first.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ninth',FALSE,0),('fifteenth',FALSE,1),('first',TRUE,2),('fourth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CCE7A1CA53CF3228D7BF',m.id,l.id,'How do you say the ordinal number 2nd?','hard','2nd adalah bilangan tingkat second.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eleventh',FALSE,0),('twentieth',FALSE,1),('second',TRUE,2),('fifth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-50F5747BC61071CB9B11',m.id,l.id,'How do you say the ordinal number 3rd?','hard','3rd adalah bilangan tingkat third.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sixth',FALSE,0),('twelfth',FALSE,1),('twenty-first',FALSE,2),('third',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-97D4D6E3EF05E778E52B',m.id,l.id,'How do you say the ordinal number 4th?','medium','4th adalah bilangan tingkat fourth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eighth',FALSE,0),('thirteenth',FALSE,1),('twenty-second',FALSE,2),('fourth',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D74194EAE48353DAF5C9',m.id,l.id,'How do you say the ordinal number 5th?','easy','5th adalah bilangan tingkat fifth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fourteenth',FALSE,0),('twenty-third',FALSE,1),('fifth',TRUE,2),('ninth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E794ACE0BD9536988F33',m.id,l.id,'How do you say the ordinal number 6th?','medium','6th adalah bilangan tingkat sixth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sixth',TRUE,0),('eleventh',FALSE,1),('fifteenth',FALSE,2),('twenty-fourth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D07D1127BC08E500A944',m.id,l.id,'How do you say the ordinal number 8th?','hard','8th adalah bilangan tingkat eighth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twelfth',FALSE,0),('twentieth',FALSE,1),('twenty-fifth',FALSE,2),('eighth',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6FD0C0BDA408054F8E05',m.id,l.id,'How do you say the ordinal number 9th?','medium','9th adalah bilangan tingkat ninth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-sixth',FALSE,0),('ninth',TRUE,1),('thirteenth',FALSE,2),('twenty-first',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E41FE1EBC889E131F38',m.id,l.id,'How do you say the ordinal number 11th?','easy','11th adalah bilangan tingkat eleventh.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-second',FALSE,0),('twenty-seventh',FALSE,1),('eleventh',TRUE,2),('fourteenth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-733E85676174DE1F57C6',m.id,l.id,'How do you say the ordinal number 12th?','medium','12th adalah bilangan tingkat twelfth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifteenth',FALSE,0),('twenty-third',FALSE,1),('twenty-eighth',FALSE,2),('twelfth',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C675887C579134139D1F',m.id,l.id,'How do you say the ordinal number 13th?','easy','13th adalah bilangan tingkat thirteenth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirteenth',TRUE,0),('twentieth',FALSE,1),('twenty-fourth',FALSE,2),('twenty-ninth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D87B669C70CD73213AEF',m.id,l.id,'How do you say the ordinal number 14th?','easy','14th adalah bilangan tingkat fourteenth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fourteenth',TRUE,0),('twenty-first',FALSE,1),('twenty-fifth',FALSE,2),('thirtieth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8513D079AB12B99024B4',m.id,l.id,'How do you say the ordinal number 15th?','hard','15th adalah bilangan tingkat fifteenth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirty-first',FALSE,0),('fifteenth',TRUE,1),('twenty-second',FALSE,2),('twenty-sixth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3309126FC37E3D20F700',m.id,l.id,'How do you say the ordinal number 20th?','easy','20th adalah bilangan tingkat twentieth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-third',FALSE,0),('twenty-seventh',FALSE,1),('first',FALSE,2),('twentieth',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AAF1307CD1BA00E195C6',m.id,l.id,'How do you say the ordinal number 21st?','hard','21st adalah bilangan tingkat twenty-first.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-first',TRUE,0),('twenty-fourth',FALSE,1),('twenty-eighth',FALSE,2),('second',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2566C06ADFBE6C586D78',m.id,l.id,'How do you say the ordinal number 22nd?','easy','22nd adalah bilangan tingkat twenty-second.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-ninth',FALSE,0),('third',FALSE,1),('twenty-second',TRUE,2),('twenty-fifth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7BD0EAB9DFF0A41335B6',m.id,l.id,'How do you say the ordinal number 23rd?','medium','23rd adalah bilangan tingkat twenty-third.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fourth',FALSE,0),('twenty-third',TRUE,1),('twenty-sixth',FALSE,2),('thirtieth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0A20470A2B8CCCF45CD8',m.id,l.id,'How do you say the ordinal number 24th?','medium','24th adalah bilangan tingkat twenty-fourth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirty-first',FALSE,0),('fifth',FALSE,1),('twenty-fourth',TRUE,2),('twenty-seventh',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A27B3B50758D9A0E5E39',m.id,l.id,'How do you say the ordinal number 25th?','easy','25th adalah bilangan tingkat twenty-fifth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-fifth',TRUE,0),('twenty-eighth',FALSE,1),('first',FALSE,2),('sixth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C7174509D4FCCBAB0A3B',m.id,l.id,'How do you say the ordinal number 26th?','medium','26th adalah bilangan tingkat twenty-sixth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eighth',FALSE,0),('twenty-sixth',TRUE,1),('twenty-ninth',FALSE,2),('second',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C5B2A6BC60C0B4D22F13',m.id,l.id,'How do you say the ordinal number 27th?','easy','27th adalah bilangan tingkat twenty-seventh.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-seventh',TRUE,0),('thirtieth',FALSE,1),('third',FALSE,2),('ninth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9ABD72E09A78807674AF',m.id,l.id,'How do you say the ordinal number 28th?','medium','28th adalah bilangan tingkat twenty-eighth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-eighth',TRUE,0),('thirty-first',FALSE,1),('fourth',FALSE,2),('eleventh',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-51E56F47885A508F65A6',m.id,l.id,'How do you say the ordinal number 29th?','hard','29th adalah bilangan tingkat twenty-ninth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('first',FALSE,0),('fifth',FALSE,1),('twelfth',FALSE,2),('twenty-ninth',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3201521194C70DE760DB',m.id,l.id,'How do you say the ordinal number 30th?','easy','30th adalah bilangan tingkat thirtieth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thirteenth',FALSE,0),('thirtieth',TRUE,1),('second',FALSE,2),('sixth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4978E06B5F25A9589D12',m.id,l.id,'How do you say the ordinal number 31st?','hard','31st adalah bilangan tingkat thirty-first.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='ordinal-numbers' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('third',FALSE,0),('eighth',FALSE,1),('fourteenth',FALSE,2),('thirty-first',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1FAE19698B15085FB91A',m.id,l.id,'How should the decimal number 1.1 be read?','hard','Bilangan desimal 1.1 dapat dibaca ''one point one'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twelve point three five',FALSE,0),('one point one',TRUE,1),('twenty-three point four zero three four',FALSE,2),('three point four',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6D612020416BB943D78B',m.id,l.id,'How should the decimal number 1.23 be read?','medium','Bilangan desimal 1.23 dapat dibaca ''one point two three'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one point two three',TRUE,0),('zero point zero four five',FALSE,1),('five point zero seven',FALSE,2),('seventy-five point zero nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A6AF93C10BE7A9B5AFBF',m.id,l.id,'How should the decimal number 23.4034 be read?','medium','Bilangan desimal 23.4034 dapat dibaca ''twenty-three point four zero three four'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nineteen forty-five',FALSE,0),('twenty-three point four zero three four',TRUE,1),('zero point five six',FALSE,2),('ninety-nine point zero five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-98BE0487531FF4105A46',m.id,l.id,'How should the decimal number 0.045 be read?','hard','Bilangan desimal 0.045 dapat dibaca ''zero point zero four five'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seven point six zero',FALSE,0),('one point two zero',FALSE,1),('nineteen oh-two',FALSE,2),('zero point zero four five',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-800990EA0898C3224C4F',m.id,l.id,'How should the decimal number 0.56 be read?','hard','Bilangan desimal 0.56 dapat dibaca ''zero point five six'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twelve point three five',FALSE,0),('nineteen eighty-six',FALSE,1),('zero point five six',TRUE,2),('eighty-nine point nine nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-78622C06C1F7D47A137C',m.id,l.id,'How should the decimal number 7.60 be read?','easy','Bilangan desimal 7.60 dapat dibaca ''seven point six zero'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seventy-five point zero nine',FALSE,0),('two thousand',FALSE,1),('seven point six zero',TRUE,2),('three point four',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-229CA51DFE8BF3C9A150',m.id,l.id,'How should the decimal number 89.99 be read?','easy','Bilangan desimal 89.99 dapat dibaca ''eighty-nine point nine nine'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand and one',FALSE,0),('eighty-nine point nine nine',TRUE,1),('five point zero seven',FALSE,2),('nineteen forty-five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C5A839D4E29B0946A7A8',m.id,l.id,'How should the decimal number 3.4 be read?','medium','Bilangan desimal 3.4 dapat dibaca ''three point four'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three point four',TRUE,0),('ninety-nine point zero five',FALSE,1),('nineteen oh-two',FALSE,2),('two thousand and five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4676E0B31F552F9876F0',m.id,l.id,'How should the decimal number 5.07 be read?','easy','Bilangan desimal 5.07 dapat dibaca ''five point zero seven'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one point two zero',FALSE,0),('nineteen eighty-six',FALSE,1),('twenty ten',FALSE,2),('five point zero seven',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-46F85F5ECFF070260DD6',m.id,l.id,'How should the decimal number 99.05 be read?','easy','Bilangan desimal 99.05 dapat dibaca ''ninety-nine point zero five'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand',FALSE,0),('twenty fifteen',FALSE,1),('ninety-nine point zero five',TRUE,2),('twelve point three five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DE833D7DE2A8F79C1BBF',m.id,l.id,'How should the decimal number 1.20 be read?','hard','Bilangan desimal 1.20 dapat dibaca ''one point two zero'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty twenty',FALSE,0),('one point two zero',TRUE,1),('seventy-five point zero nine',FALSE,2),('two thousand and one',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-87B6BC2A6762466C5E8B',m.id,l.id,'How should the decimal number 12.35 be read?','medium','Bilangan desimal 12.35 dapat dibaca ''twelve point three five'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand and five',FALSE,0),('twenty twenty-six',FALSE,1),('twelve point three five',TRUE,2),('nineteen forty-five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09BFB337C9113C71DB95',m.id,l.id,'How should the decimal number 75.09 be read?','medium','Bilangan desimal 75.09 dapat dibaca ''seventy-five point zero nine'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nineteen oh-two',FALSE,0),('twenty ten',FALSE,1),('nineteen ninety-nine',FALSE,2),('seventy-five point zero nine',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E66F2B93C3C08ADCAD69',m.id,l.id,'How should the year 1945 be read?','medium','Tahun 1945 dapat dibaca ''nineteen forty-five'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nineteen eighty-six',FALSE,0),('twenty fifteen',FALSE,1),('eighteen eighty-eight',FALSE,2),('nineteen forty-five',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-13E9F5A2FD21F9C09639',m.id,l.id,'How should the year 1902 be read?','medium','Tahun 1902 dapat dibaca ''nineteen oh-two'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty twenty',FALSE,0),('one point one',FALSE,1),('nineteen oh-two',TRUE,2),('two thousand',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7BF0F7E7FBB6D4147392',m.id,l.id,'How should the year 1986 be read?','hard','Tahun 1986 dapat dibaca ''nineteen eighty-six'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two thousand and one',FALSE,0),('twenty twenty-six',FALSE,1),('one point two three',FALSE,2),('nineteen eighty-six',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DC5E508A03324DF72C24',m.id,l.id,'How should the year 2000 be read?','hard','Tahun 2000 dapat dibaca ''two thousand'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nineteen ninety-nine',FALSE,0),('twenty-three point four zero three four',FALSE,1),('two thousand',TRUE,2),('two thousand and five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F75D3FEFEC47BC53B1D5',m.id,l.id,'How should the year 2001 be read?','hard','Tahun 2001 dapat dibaca ''two thousand and one'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty ten',FALSE,0),('eighteen eighty-eight',FALSE,1),('zero point zero four five',FALSE,2),('two thousand and one',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-01E8DB4B0240C0162E59',m.id,l.id,'How should the year 2005 be read?','medium','Tahun 2005 dapat dibaca ''two thousand and five'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty fifteen',FALSE,0),('one point one',FALSE,1),('zero point five six',FALSE,2),('two thousand and five',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AE244A31D7155CC134C9',m.id,l.id,'How should the year 2010 be read?','hard','Tahun 2010 dapat dibaca ''twenty ten'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seven point six zero',FALSE,0),('twenty ten',TRUE,1),('twenty twenty',FALSE,2),('one point two three',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8818F0E497D546C249CE',m.id,l.id,'How should the year 2015 be read?','medium','Tahun 2015 dapat dibaca ''twenty fifteen'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty fifteen',TRUE,0),('twenty twenty-six',FALSE,1),('twenty-three point four zero three four',FALSE,2),('eighty-nine point nine nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-97EC68B8E80D097AC724',m.id,l.id,'How should the year 2020 be read?','medium','Tahun 2020 dapat dibaca ''twenty twenty'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty twenty',TRUE,0),('nineteen ninety-nine',FALSE,1),('zero point zero four five',FALSE,2),('three point four',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-663A3B9C54D3C7F7DE90',m.id,l.id,'How should the year 2026 be read?','easy','Tahun 2026 dapat dibaca ''twenty twenty-six'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty twenty-six',TRUE,0),('eighteen eighty-eight',FALSE,1),('zero point five six',FALSE,2),('five point zero seven',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7E3815DB3CA1E7D95EE6',m.id,l.id,'How should the year 1999 be read?','easy','Tahun 1999 dapat dibaca ''nineteen ninety-nine'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one point one',FALSE,0),('seven point six zero',FALSE,1),('ninety-nine point zero five',FALSE,2),('nineteen ninety-nine',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-24E9A8B3245D16623B00',m.id,l.id,'How should the year 1888 be read?','easy','Tahun 1888 dapat dibaca ''eighteen eighty-eight'' dalam gaya yang diajarkan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='decimals-years' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one point two three',FALSE,0),('eighty-nine point nine nine',FALSE,1),('one point two zero',FALSE,2),('eighteen eighty-eight',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6306691CBFF3D17458F5',m.id,l.id,'How is this expression read aloud: 1/2?','easy','Ekspresi 1/2 dibaca one half.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one half',TRUE,0),('one third',FALSE,1),('two fifths',FALSE,2),('seven plus ten equals seventeen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5A041F48751803661472',m.id,l.id,'How is this expression read aloud: 1/3?','easy','Ekspresi 1/3 dibaca one third.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one third',TRUE,0),('two thirds',FALSE,1),('three fifths',FALSE,2),('eight plus six equals fourteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F8E282759B0010606D86',m.id,l.id,'How is this expression read aloud: 2/3?','easy','Ekspresi 2/3 dibaca two thirds.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-five divided by five equals five',FALSE,0),('two thirds',TRUE,1),('one quarter',FALSE,2),('four fifths',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-781C84F1EFE0BE146F70',m.id,l.id,'How is this expression read aloud: 1/4?','medium','Ekspresi 1/4 dibaca one quarter.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eight times three equals twenty-four',FALSE,0),('one quarter',TRUE,1),('three quarters',FALSE,2),('one sixth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F11F0E2EC4DB9C0FD337',m.id,l.id,'How is this expression read aloud: 3/4?','medium','Ekspresi 3/4 dibaca three quarters.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('five sixths',FALSE,0),('nine minus four equals five',FALSE,1),('three quarters',TRUE,2),('one fifth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91FE5029861D4C905F4E',m.id,l.id,'How is this expression read aloud: 1/5?','hard','Ekspresi 1/5 dibaca one fifth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('six times seven equals forty-two',FALSE,0),('one fifth',TRUE,1),('two fifths',FALSE,2),('one eighth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9DADFA0A62BDEDE20253',m.id,l.id,'How is this expression read aloud: 2/5?','easy','Ekspresi 2/5 dibaca two fifths.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three eighths',FALSE,0),('ten minus three equals seven',FALSE,1),('two fifths',TRUE,2),('three fifths',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-114AEC8F1E9F42CD156A',m.id,l.id,'How is this expression read aloud: 3/5?','medium','Ekspresi 3/5 dibaca three fifths.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('four fifths',FALSE,0),('seven plus ten equals seventeen',FALSE,1),('twelve divided by four equals three',FALSE,2),('three fifths',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-32F6093C8FB5388AD7DE',m.id,l.id,'How is this expression read aloud: 4/5?','hard','Ekspresi 4/5 dibaca four fifths.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('four fifths',TRUE,0),('one sixth',FALSE,1),('eight plus six equals fourteen',FALSE,2),('fourteen plus five equals nineteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1533CB42CCACA54E3C01',m.id,l.id,'How is this expression read aloud: 1/6?','medium','Ekspresi 1/6 dibaca one sixth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-five divided by five equals five',FALSE,0),('five times five equals twenty-five',FALSE,1),('one sixth',TRUE,2),('five sixths',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C1D0DE56A00E2885F96A',m.id,l.id,'How is this expression read aloud: 5/6?','hard','Ekspresi 5/6 dibaca five sixths.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eight times three equals twenty-four',FALSE,0),('sixteen divided by two equals eight',FALSE,1),('five sixths',TRUE,2),('one eighth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EDDD5A21F0EB1EE2680B',m.id,l.id,'How is this expression read aloud: 1/8?','hard','Ekspresi 1/8 dibaca one eighth.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fifteen minus seven equals eight',FALSE,0),('one eighth',TRUE,1),('three eighths',FALSE,2),('nine minus four equals five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9E28CA7D6763A8EDD8CB',m.id,l.id,'How is this expression read aloud: 3/8?','medium','Ekspresi 3/8 dibaca three eighths.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one half',FALSE,0),('three eighths',TRUE,1),('seven plus ten equals seventeen',FALSE,2),('six times seven equals forty-two',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A4B459060E2A24469F98',m.id,l.id,'How is this expression read aloud: 7 + 10 = 17?','easy','Ekspresi 7 + 10 = 17 dibaca seven plus ten equals seventeen.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ten minus three equals seven',FALSE,0),('one third',FALSE,1),('seven plus ten equals seventeen',TRUE,2),('eight plus six equals fourteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2AA0AF0285CD2E11DD9C',m.id,l.id,'How is this expression read aloud: 8 + 6 = 14?','hard','Ekspresi 8 + 6 = 14 dibaca eight plus six equals fourteen.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twelve divided by four equals three',FALSE,0),('two thirds',FALSE,1),('eight plus six equals fourteen',TRUE,2),('twenty-five divided by five equals five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-87BBDABD4A5761B9133C',m.id,l.id,'How is this expression read aloud: 25 ÷ 5 = 5?','hard','Ekspresi 25 ÷ 5 = 5 dibaca twenty-five divided by five equals five.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one quarter',FALSE,0),('twenty-five divided by five equals five',TRUE,1),('eight times three equals twenty-four',FALSE,2),('fourteen plus five equals nineteen',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4A22F98D69985949E0B7',m.id,l.id,'How is this expression read aloud: 8 × 3 = 24?','hard','Ekspresi 8 × 3 = 24 dibaca eight times three equals twenty-four.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three quarters',FALSE,0),('eight times three equals twenty-four',TRUE,1),('nine minus four equals five',FALSE,2),('five times five equals twenty-five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09C36943F79C7CA32490',m.id,l.id,'How is this expression read aloud: 9 − 4 = 5?','easy','Ekspresi 9 − 4 = 5 dibaca nine minus four equals five.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('six times seven equals forty-two',FALSE,0),('sixteen divided by two equals eight',FALSE,1),('one fifth',FALSE,2),('nine minus four equals five',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09A04549C3E3F2345601',m.id,l.id,'How is this expression read aloud: 6 × 7 = 42?','hard','Ekspresi 6 × 7 = 42 dibaca six times seven equals forty-two.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('two fifths',FALSE,0),('six times seven equals forty-two',TRUE,1),('ten minus three equals seven',FALSE,2),('fifteen minus seven equals eight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D05C9C710ED72C0FFCA7',m.id,l.id,'How is this expression read aloud: 10 − 3 = 7?','easy','Ekspresi 10 − 3 = 7 dibaca ten minus three equals seven.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three fifths',FALSE,0),('ten minus three equals seven',TRUE,1),('twelve divided by four equals three',FALSE,2),('one half',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E8C0637FD5740826FBB8',m.id,l.id,'How is this expression read aloud: 12 ÷ 4 = 3?','easy','Ekspresi 12 ÷ 4 = 3 dibaca twelve divided by four equals three.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fourteen plus five equals nineteen',FALSE,0),('one third',FALSE,1),('four fifths',FALSE,2),('twelve divided by four equals three',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B6C29F4388A69AC2C21',m.id,l.id,'How is this expression read aloud: 14 + 5 = 19?','easy','Ekspresi 14 + 5 = 19 dibaca fourteen plus five equals nineteen.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fourteen plus five equals nineteen',TRUE,0),('five times five equals twenty-five',FALSE,1),('two thirds',FALSE,2),('one sixth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5518AD8A490DAF1C5274',m.id,l.id,'How is this expression read aloud: 5 × 5 = 25?','medium','Ekspresi 5 × 5 = 25 dibaca five times five equals twenty-five.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one quarter',FALSE,0),('five sixths',FALSE,1),('five times five equals twenty-five',TRUE,2),('sixteen divided by two equals eight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6F446E28710C2751516E',m.id,l.id,'How is this expression read aloud: 16 ÷ 2 = 8?','hard','Ekspresi 16 ÷ 2 = 8 dibaca sixteen divided by two equals eight.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sixteen divided by two equals eight',TRUE,0),('fifteen minus seven equals eight',FALSE,1),('three quarters',FALSE,2),('one eighth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-072DCA859C37A034441B',m.id,l.id,'How is this expression read aloud: 15 − 7 = 8?','easy','Ekspresi 15 − 7 = 8 dibaca fifteen minus seven equals eight.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='fractions-math' WHERE m.slug='cardinal-ordinal'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('three eighths',FALSE,0),('fifteen minus seven equals eight',TRUE,1),('one half',FALSE,2),('one fifth',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4C8B986D786764C01C3E',m.id,l.id,'Which conversational English expression means 07:00?','hard','07:00 dibaca seven o''clock (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a quarter past eleven',FALSE,0),('seven o''clock',TRUE,1),('ten past seven',FALSE,2),('twenty-five past five',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B3AEC453204ADFBFD7FE',m.id,l.id,'Which conversational English expression means 07:10?','medium','07:10 dibaca ten past seven (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-five past five',FALSE,0),('a quarter past eleven',FALSE,1),('half past six',FALSE,2),('ten past seven',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-272FD75A37D2664655AF',m.id,l.id,'Which conversational English expression means 05:25?','hard','05:25 dibaca twenty-five past five (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('half past six',FALSE,0),('a quarter to eleven',FALSE,1),('twenty-five past five',TRUE,2),('a quarter past eleven',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F0D717703F14993FAAC8',m.id,l.id,'Which conversational English expression means 11:15?','hard','11:15 dibaca a quarter past eleven (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a quarter past eleven',TRUE,0),('half past six',FALSE,1),('a quarter to eleven',FALSE,2),('five to nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F958831A83B6FA501405',m.id,l.id,'Which conversational English expression means 06:30?','medium','06:30 dibaca half past six (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('five to nine',FALSE,0),('twenty-five to six',FALSE,1),('half past six',TRUE,2),('a quarter to eleven',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ABE871ECB525595C9A3D',m.id,l.id,'Which conversational English expression means 10:45?','easy','10:45 dibaca a quarter to eleven (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a quarter to eleven',TRUE,0),('five to nine',FALSE,1),('twenty-five to six',FALSE,2),('twenty past nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B7285E69ED4DCDD3B5C9',m.id,l.id,'Which conversational English expression means 08:55?','medium','08:55 dibaca five to nine (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one o''clock',FALSE,0),('five to nine',TRUE,1),('twenty-five to six',FALSE,2),('twenty past nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8F2079B270F420686BB7',m.id,l.id,'Which conversational English expression means 05:35?','easy','05:35 dibaca twenty-five to six (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one o''clock',FALSE,0),('twenty-nine past two',FALSE,1),('twenty-five to six',TRUE,2),('twenty past nine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3C556361F8BAFC2D7431',m.id,l.id,'Which conversational English expression means 09:20?','hard','09:20 dibaca twenty past nine (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a quarter past three',FALSE,0),('twenty past nine',TRUE,1),('one o''clock',FALSE,2),('twenty-nine past two',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-096472933FBF80EA4756',m.id,l.id,'Which conversational English expression means 13:00?','medium','13:00 dibaca one o''clock (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-nine past two',FALSE,0),('a quarter past three',FALSE,1),('eleven to ten',FALSE,2),('one o''clock',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6657E42F9712B7AEBFA7',m.id,l.id,'Which conversational English expression means 14:29?','medium','14:29 dibaca twenty-nine past two (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a quarter past three',FALSE,0),('eleven to ten',FALSE,1),('seventeen past ten',FALSE,2),('twenty-nine past two',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C7CBC7A29266C9097B1E',m.id,l.id,'Which conversational English expression means 15:15?','hard','15:15 dibaca a quarter past three (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seventeen past ten',FALSE,0),('twenty-seven to twelve',FALSE,1),('a quarter past three',TRUE,2),('eleven to ten',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-415AFCE07DCDB1EFCAF7',m.id,l.id,'Which conversational English expression means 21:49?','hard','21:49 dibaca eleven to ten (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('eleven to ten',TRUE,0),('seventeen past ten',FALSE,1),('twenty-seven to twelve',FALSE,2),('four o''clock',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BA6041233895EBF2664',m.id,l.id,'Which conversational English expression means 22:17?','hard','22:17 dibaca seventeen past ten (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('four o''clock',FALSE,0),('five past five',FALSE,1),('seventeen past ten',TRUE,2),('twenty-seven to twelve',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-005E449F1093CEA97C6E',m.id,l.id,'Which conversational English expression means 23:33?','medium','23:33 dibaca twenty-seven to twelve (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('four o''clock',FALSE,0),('five past five',FALSE,1),('a quarter to eight',FALSE,2),('twenty-seven to twelve',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1C7873214FC8EB6E6EF3',m.id,l.id,'Which conversational English expression means 16:00?','easy','16:00 dibaca four o''clock (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-five to one',FALSE,0),('four o''clock',TRUE,1),('five past five',FALSE,2),('a quarter to eight',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-881DBFE9701B4000FDD4',m.id,l.id,'Which conversational English expression means 17:05?','hard','17:05 dibaca five past five (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one o''clock',FALSE,0),('five past five',TRUE,1),('a quarter to eight',FALSE,2),('twenty-five to one',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DE5CA4B6EDD2BE73BBB2',m.id,l.id,'Which conversational English expression means 19:45?','hard','19:45 dibaca a quarter to eight (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('one o''clock',FALSE,0),('twelve to three',FALSE,1),('a quarter to eight',TRUE,2),('twenty-five to one',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3DC53B10C19B770C195F',m.id,l.id,'Which conversational English expression means 12:35?','hard','12:35 dibaca twenty-five to one (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-five to one',TRUE,0),('one o''clock',FALSE,1),('twelve to three',FALSE,2),('twenty-six past six',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AE9A52A11C51B559BDC3',m.id,l.id,'Which conversational English expression means 01:00?','medium','01:00 dibaca one o''clock (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-two to twelve',FALSE,0),('one o''clock',TRUE,1),('twelve to three',FALSE,2),('twenty-six past six',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-011BA0D6118CB7C2019D',m.id,l.id,'Which conversational English expression means 02:48?','easy','02:48 dibaca twelve to three (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-two to twelve',FALSE,0),('twenty-five past ten',FALSE,1),('twelve to three',TRUE,2),('twenty-six past six',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E9F1E785470886E5A5E7',m.id,l.id,'Which conversational English expression means 06:26?','medium','06:26 dibaca twenty-six past six (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-two to five',FALSE,0),('twenty-six past six',TRUE,1),('twenty-two to twelve',FALSE,2),('twenty-five past ten',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F2471B745803CA73D861',m.id,l.id,'Which conversational English expression means 11:38?','easy','11:38 dibaca twenty-two to twelve (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('twenty-two to twelve',TRUE,0),('twenty-five past ten',FALSE,1),('twenty-two to five',FALSE,2),('seven o''clock',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C16FF92DC7BA2636F6B1',m.id,l.id,'Which conversational English expression means 10:25?','easy','10:25 dibaca twenty-five past ten (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ten past seven',FALSE,0),('twenty-five past ten',TRUE,1),('twenty-two to five',FALSE,2),('seven o''clock',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-79A42052038C99134FF4',m.id,l.id,'Which conversational English expression means 04:38?','easy','04:38 dibaca twenty-two to five (format jam 12, tanpa AM/PM).'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='telling-time' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ten past seven',FALSE,0),('twenty-five past five',FALSE,1),('twenty-two to five',TRUE,2),('seven o''clock',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C6291AD6EAE15A482C83',m.id,l.id,'Choose the best English expression for: Senin','easy','''Senin'' dalam konteks materi ini diterjemahkan menjadi ''Monday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Wednesday',FALSE,0),('Thursday',FALSE,1),('Monday',TRUE,2),('Tuesday',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A13FF567C3DB6CB96055',m.id,l.id,'What is the Indonesian meaning of ''Monday''?','hard','Dalam konteks materi, ''Monday'' bermakna ''Senin''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Rabu',FALSE,0),('Jumat',FALSE,1),('Minggu',FALSE,2),('Senin',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91D2BBFDAD872B000ABB',m.id,l.id,'Choose the best English expression for: Selasa','easy','''Selasa'' dalam konteks materi ini diterjemahkan menjadi ''Tuesday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Friday',FALSE,0),('Tuesday',TRUE,1),('Wednesday',FALSE,2),('Thursday',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DF903747D08EDCAC632D',m.id,l.id,'What is the Indonesian meaning of ''Tuesday''?','medium','Dalam konteks materi, ''Tuesday'' bermakna ''Selasa''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Kamis',FALSE,0),('Sabtu',FALSE,1),('Januari',FALSE,2),('Selasa',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D1EA5B63CD15F3E49689',m.id,l.id,'Choose the best English expression for: Rabu','medium','''Rabu'' dalam konteks materi ini diterjemahkan menjadi ''Wednesday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Thursday',FALSE,0),('Friday',FALSE,1),('Saturday',FALSE,2),('Wednesday',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ACEB8013DDE7F401A712',m.id,l.id,'What is the Indonesian meaning of ''Wednesday''?','medium','Dalam konteks materi, ''Wednesday'' bermakna ''Rabu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Jumat',FALSE,0),('Minggu',FALSE,1),('Februari',FALSE,2),('Rabu',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6E04EEDED3E687C4EAAF',m.id,l.id,'Choose the best English expression for: Kamis','medium','''Kamis'' dalam konteks materi ini diterjemahkan menjadi ''Thursday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Saturday',FALSE,0),('Sunday',FALSE,1),('Thursday',TRUE,2),('Friday',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-754A17EF74383AF74E37',m.id,l.id,'What is the Indonesian meaning of ''Thursday''?','easy','Dalam konteks materi, ''Thursday'' bermakna ''Kamis''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Sabtu',FALSE,0),('Januari',FALSE,1),('Maret',FALSE,2),('Kamis',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DA466A34F12175688820',m.id,l.id,'Choose the best English expression for: Jumat','easy','''Jumat'' dalam konteks materi ini diterjemahkan menjadi ''Friday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Friday',TRUE,0),('Saturday',FALSE,1),('Sunday',FALSE,2),('January',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E378CAE64D5C4A102BF',m.id,l.id,'What is the Indonesian meaning of ''Friday''?','medium','Dalam konteks materi, ''Friday'' bermakna ''Jumat''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Februari',FALSE,0),('April',FALSE,1),('Jumat',TRUE,2),('Minggu',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09969ACA6E89FE35A325',m.id,l.id,'Choose the best English expression for: Sabtu','hard','''Sabtu'' dalam konteks materi ini diterjemahkan menjadi ''Saturday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('January',FALSE,0),('February',FALSE,1),('Saturday',TRUE,2),('Sunday',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-47EF4E196266EB947013',m.id,l.id,'What is the Indonesian meaning of ''Saturday''?','medium','Dalam konteks materi, ''Saturday'' bermakna ''Sabtu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Mei',FALSE,0),('Sabtu',TRUE,1),('Januari',FALSE,2),('Maret',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-66FAAC592A2C3E1254D8',m.id,l.id,'Choose the best English expression for: Minggu','medium','''Minggu'' dalam konteks materi ini diterjemahkan menjadi ''Sunday''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('March',FALSE,0),('Sunday',TRUE,1),('January',FALSE,2),('February',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C623B352F831C1F0ED59',m.id,l.id,'What is the Indonesian meaning of ''Sunday''?','medium','Dalam konteks materi, ''Sunday'' bermakna ''Minggu''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('April',FALSE,0),('Juni',FALSE,1),('Minggu',TRUE,2),('Februari',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E243F6013F17A16BD3D3',m.id,l.id,'Choose the best English expression for: Januari','easy','''Januari'' dalam konteks materi ini diterjemahkan menjadi ''January''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('April',FALSE,0),('January',TRUE,1),('February',FALSE,2),('March',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-95EDDF852CB8E3EF5274',m.id,l.id,'What is the Indonesian meaning of ''January''?','medium','Dalam konteks materi, ''January'' bermakna ''Januari''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Juli',FALSE,0),('Januari',TRUE,1),('Maret',FALSE,2),('Mei',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-12670ADEBAE60152E517',m.id,l.id,'Choose the best English expression for: Februari','medium','''Februari'' dalam konteks materi ini diterjemahkan menjadi ''February''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('April',FALSE,0),('May',FALSE,1),('February',TRUE,2),('March',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A3DF9A8AA5CADDB644A1',m.id,l.id,'What is the Indonesian meaning of ''February''?','hard','Dalam konteks materi, ''February'' bermakna ''Februari''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Juni',FALSE,0),('Agustus',FALSE,1),('Februari',TRUE,2),('April',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B7D4CABDEC96E74503CC',m.id,l.id,'Choose the best English expression for: Maret','hard','''Maret'' dalam konteks materi ini diterjemahkan menjadi ''March''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('June',FALSE,0),('March',TRUE,1),('April',FALSE,2),('May',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3DC2A3AECDFD15AC862E',m.id,l.id,'What is the Indonesian meaning of ''March''?','easy','Dalam konteks materi, ''March'' bermakna ''Maret''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Juli',FALSE,0),('September',FALSE,1),('Maret',TRUE,2),('Mei',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8E42D336B905AC17986A',m.id,l.id,'Choose the best English expression for: April','medium','''April'' dalam konteks materi ini diterjemahkan menjadi ''April''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('June',FALSE,0),('July',FALSE,1),('April',TRUE,2),('May',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DFA08E553DE2012D361D',m.id,l.id,'What is the Indonesian meaning of ''April''?','easy','Dalam konteks materi, ''April'' bermakna ''April''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Oktober',FALSE,0),('April',TRUE,1),('Juni',FALSE,2),('Agustus',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-442C1CA6A814BF9DF0A1',m.id,l.id,'Choose the best English expression for: Mei','hard','''Mei'' dalam konteks materi ini diterjemahkan menjadi ''May''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('July',FALSE,0),('August',FALSE,1),('May',TRUE,2),('June',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-20936E64BFD30AC8FDFA',m.id,l.id,'What is the Indonesian meaning of ''May''?','easy','Dalam konteks materi, ''May'' bermakna ''Mei''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Mei',TRUE,0),('Juli',FALSE,1),('September',FALSE,2),('November',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-05C4270CFE55E0CB0C58',m.id,l.id,'Choose the best English expression for: Juni','medium','''Juni'' dalam konteks materi ini diterjemahkan menjadi ''June''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='days-months' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('June',TRUE,0),('July',FALSE,1),('August',FALSE,2),('September',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-89CD10F89C3179F98389',m.id,l.id,'Choose the British written date for March 20, 2026.','hard','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('20 March 2026',TRUE,0),('March 20, 2026',FALSE,1),('03/20/2026',FALSE,2),('2026 March 20',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FDA480D0F6BFE22B7C77',m.id,l.id,'Choose the American written date for 30 April 2015.','medium','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('April 30, 2015',TRUE,0),('30 April 2015',FALSE,1),('30/04/2015',FALSE,2),('2015 April 30',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8749B7C4EEF428F18226',m.id,l.id,'Choose the British written date for July 20, 2009.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('20 July 2009',TRUE,0),('July 20, 2009',FALSE,1),('07/20/2009',FALSE,2),('2009 July 20',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D2967ED4B0A2AC0CB9DD',m.id,l.id,'Choose the American written date for 29 December 1999.','easy','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('December 29, 1999',TRUE,0),('29 December 1999',FALSE,1),('29/12/1999',FALSE,2),('1999 December 29',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D2F55884332A9549A76',m.id,l.id,'Choose the British written date for January 11, 1958.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('11 January 1958',TRUE,0),('January 11, 1958',FALSE,1),('01/11/1958',FALSE,2),('1958 January 11',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5B11D0431EEF23DE8622',m.id,l.id,'Choose the American written date for 2 October 1776.','medium','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2 October 1776',FALSE,0),('02/10/1776',FALSE,1),('1776 October 2',FALSE,2),('October 2, 1776',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6255F41D4413859FF873',m.id,l.id,'Choose the British written date for August 17, 2001.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2001 August 17',FALSE,0),('17 August 2001',TRUE,1),('August 17, 2001',FALSE,2),('08/17/2001',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-781525D5209F3A7164BE',m.id,l.id,'Choose the American written date for 3 October 2010.','hard','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2010 October 3',FALSE,0),('October 3, 2010',TRUE,1),('3 October 2010',FALSE,2),('03/10/2010',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F3666BEECB4CBEC8DA19',m.id,l.id,'Choose the British written date for July 12, 1876.','easy','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('07/12/1876',FALSE,0),('1876 July 12',FALSE,1),('12 July 1876',TRUE,2),('July 12, 1876',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-224C771DBE7CF82DC426',m.id,l.id,'Choose the American written date for 31 December 2003.','medium','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2003 December 31',FALSE,0),('December 31, 2003',TRUE,1),('31 December 2003',FALSE,2),('31/12/2003',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9A2D7524BE05DB01906C',m.id,l.id,'Choose the British written date for March 26, 1889.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('26 March 1889',TRUE,0),('March 26, 1889',FALSE,1),('03/26/1889',FALSE,2),('1889 March 26',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D06242C34A8055A62418',m.id,l.id,'Choose the American written date for 1 April 2009.','easy','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('1 April 2009',FALSE,0),('01/04/2009',FALSE,1),('2009 April 1',FALSE,2),('April 1, 2009',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A19BA1A2581E305633EB',m.id,l.id,'Choose the British written date for October 10, 1888.','easy','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('10/10/1888',FALSE,0),('1888 October 10',FALSE,1),('10 October 1888',TRUE,2),('October 10, 1888',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4023390EB0994C68B65A',m.id,l.id,'Choose the American written date for 23 June 2013.','hard','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('23/06/2013',FALSE,0),('2013 June 23',FALSE,1),('June 23, 2013',TRUE,2),('23 June 2013',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-90F6CC6B494DD8E36F7C',m.id,l.id,'Choose the British written date for August 8, 1959.','hard','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('August 8, 1959',FALSE,0),('08/08/1959',FALSE,1),('1959 August 8',FALSE,2),('8 August 1959',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6FB2F9C0D40808330003',m.id,l.id,'Choose the American written date for 30 January 1983.','easy','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('January 30, 1983',TRUE,0),('30 January 1983',FALSE,1),('30/01/1983',FALSE,2),('1983 January 30',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-710E914A963E56123887',m.id,l.id,'Choose the British written date for November 2, 1990.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('11/02/1990',FALSE,0),('1990 November 2',FALSE,1),('2 November 1990',TRUE,2),('November 2, 1990',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FB20E84CACB1CF5A5840',m.id,l.id,'Choose the American written date for 6 April 1856.','medium','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('April 6, 1856',TRUE,0),('6 April 1856',FALSE,1),('06/04/1856',FALSE,2),('1856 April 6',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-567320A87407029B4282',m.id,l.id,'Choose the British written date for February 21, 2007.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('21 February 2007',TRUE,0),('February 21, 2007',FALSE,1),('02/21/2007',FALSE,2),('2007 February 21',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-19C2F7995669C54B0BE8',m.id,l.id,'Choose the American written date for 16 June 2014.','medium','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2014 June 16',FALSE,0),('June 16, 2014',TRUE,1),('16 June 2014',FALSE,2),('16/06/2014',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C4CE4096EF5B80C37D57',m.id,l.id,'Choose the British written date for March 13, 1986.','hard','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('03/13/1986',FALSE,0),('1986 March 13',FALSE,1),('13 March 1986',TRUE,2),('March 13, 1986',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-182781416D439CE51DAC',m.id,l.id,'Choose the American written date for 4 September 2001.','easy','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2001 September 4',FALSE,0),('September 4, 2001',TRUE,1),('4 September 2001',FALSE,2),('04/09/2001',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-04F4B16655FFC2E8339A',m.id,l.id,'Choose the British written date for July 17, 1887.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('07/17/1887',FALSE,0),('1887 July 17',FALSE,1),('17 July 1887',TRUE,2),('July 17, 1887',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A255AAE6B7A9424922E4',m.id,l.id,'Choose the American written date for 28 April 2014.','hard','American English umumnya menulis month–day, year menggunakan koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('28/04/2014',FALSE,0),('2014 April 28',FALSE,1),('April 28, 2014',TRUE,2),('28 April 2014',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6F91BCF05C5B32AA6AA4',m.id,l.id,'Choose the British written date for March 2, 2015.','medium','British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='british-american-dates' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('2 March 2015',TRUE,0),('March 2, 2015',FALSE,1),('03/02/2015',FALSE,2),('2015 March 2',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F1C3A044B465AD11FD87',m.id,l.id,'Complete the schedule: Our class begins _____ Monday.','easy','Untuk ekspresi waktu ''Monday'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-404EE2EE370351A14464',m.id,l.id,'Complete the schedule: Our class begins _____ Tuesday afternoon.','easy','Untuk ekspresi waktu ''Tuesday afternoon'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('on',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6711DC1BFCD0C22AC2EC',m.id,l.id,'Complete the schedule: Our class begins _____ Friday morning.','easy','Untuk ekspresi waktu ''Friday morning'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4195EABEC36F67325F03',m.id,l.id,'Complete the schedule: Our class begins _____ March 20th.','easy','Untuk ekspresi waktu ''March 20th'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('on',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-49776BA3702F2B49EDF9',m.id,l.id,'Complete the schedule: Our class begins _____ Christmas Day.','hard','Untuk ekspresi waktu ''Christmas Day'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9B70843B89B23589D3E0',m.id,l.id,'Complete the schedule: Our class begins _____ Sunday.','medium','Untuk ekspresi waktu ''Sunday'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B124AE304500D8D1EF40',m.id,l.id,'Complete the schedule: Our class begins _____ July 4th.','hard','Untuk ekspresi waktu ''July 4th'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3E68F5C87FEE2567F1F0',m.id,l.id,'Complete the schedule: Our class begins _____ Thursday evening.','medium','Untuk ekspresi waktu ''Thursday evening'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C428DE7B696547EE6ED6',m.id,l.id,'Complete the schedule: Our class begins _____ September 9th.','hard','Untuk ekspresi waktu ''September 9th'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8ECBD0315FF7F709057B',m.id,l.id,'Complete the schedule: Our class begins _____ Saturday night.','medium','Untuk ekspresi waktu ''Saturday night'' gunakan preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('on',TRUE,1),('in',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2FACB9A5F6F7914E0E3A',m.id,l.id,'Complete the schedule: Our class begins _____ May.','hard','Untuk ekspresi waktu ''May'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('in',TRUE,1),('on',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BEA2E9A89D174DD7D2CE',m.id,l.id,'Complete the schedule: Our class begins _____ 2026.','medium','Untuk ekspresi waktu ''2026'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9B99E631CA20D5D4C140',m.id,l.id,'Complete the schedule: Our class begins _____ summer.','hard','Untuk ekspresi waktu ''summer'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('in',TRUE,1),('on',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EBF5138537E48AC94B3A',m.id,l.id,'Complete the schedule: Our class begins _____ winter.','medium','Untuk ekspresi waktu ''winter'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('in',TRUE,1),('on',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-90A67430680CCABFBF8D',m.id,l.id,'Complete the schedule: Our class begins _____ the morning.','hard','Untuk ekspresi waktu ''the morning'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F4B279802B8F2E35239',m.id,l.id,'Complete the schedule: Our class begins _____ the afternoon.','medium','Untuk ekspresi waktu ''the afternoon'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0C236831F99B805D70B7',m.id,l.id,'Complete the schedule: Our class begins _____ the evening.','medium','Untuk ekspresi waktu ''the evening'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('in',TRUE,1),('on',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E4B8074BCC3B4015E0E4',m.id,l.id,'Complete the schedule: Our class begins _____ October.','easy','Untuk ekspresi waktu ''October'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('at',FALSE,1),('for',FALSE,2),('in',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C922F69D09F28F8BAB10',m.id,l.id,'Complete the schedule: Our class begins _____ 1997.','hard','Untuk ekspresi waktu ''1997'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('in',TRUE,1),('on',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28E797CF5F8E587E21D1',m.id,l.id,'Complete the schedule: Our class begins _____ January.','medium','Untuk ekspresi waktu ''January'' gunakan preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('at',FALSE,1),('for',FALSE,2),('in',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D048CECBAE2F071E1BF3',m.id,l.id,'Complete the schedule: Our class begins _____ 7 a.m..','easy','Untuk ekspresi waktu ''7 a.m.'' gunakan preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('in',FALSE,1),('for',FALSE,2),('at',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB9C11DAA3C3E1B553F3',m.id,l.id,'Complete the schedule: Our class begins _____ noon.','hard','Untuk ekspresi waktu ''noon'' gunakan preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('for',FALSE,1),('at',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1F0F21CDD3111C4F2C7F',m.id,l.id,'Complete the schedule: Our class begins _____ midnight.','hard','Untuk ekspresi waktu ''midnight'' gunakan preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('at',TRUE,1),('on',FALSE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BF09DB1F4CFA97D5A31',m.id,l.id,'Complete the schedule: Our class begins _____ 10 o’clock.','medium','Untuk ekspresi waktu ''10 o’clock'' gunakan preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('at',TRUE,1),('on',FALSE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-53407AACAD4867550F3E',m.id,l.id,'Complete the schedule: Our class begins _____ night.','medium','Untuk ekspresi waktu ''night'' gunakan preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-practice' WHERE m.slug='telling-time-dates'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',TRUE,0),('on',FALSE,1),('in',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9CF5FA4E3FD9F7928BBC',m.id,l.id,'In its ordinary general meaning, is ''book'' countable or uncountable?','medium','''book'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a verb',FALSE,0),('Always a pronoun',FALSE,1),('Countable',TRUE,2),('Uncountable',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C6E44811DD96211B4359',m.id,l.id,'In its ordinary general meaning, is ''apple'' countable or uncountable?','hard','''apple'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Countable',TRUE,1),('Uncountable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2FC99EECA7071415DE1F',m.id,l.id,'In its ordinary general meaning, is ''chair'' countable or uncountable?','hard','''chair'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-07CC3760AAADBF23F141',m.id,l.id,'In its ordinary general meaning, is ''student'' countable or uncountable?','hard','''student'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-575E6DB5B7568A485031',m.id,l.id,'In its ordinary general meaning, is ''tomato'' countable or uncountable?','hard','''tomato'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Countable',TRUE,1),('Uncountable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6FFD52BFDEC99E8610F4',m.id,l.id,'In its ordinary general meaning, is ''pen'' countable or uncountable?','medium','''pen'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Countable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-25FBD1CBFCC132D782C5',m.id,l.id,'In its ordinary general meaning, is ''umbrella'' countable or uncountable?','hard','''umbrella'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Countable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9DB79C5FC4AC06728957',m.id,l.id,'In its ordinary general meaning, is ''picture'' countable or uncountable?','hard','''picture'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Countable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C79C5674817F144E8289',m.id,l.id,'In its ordinary general meaning, is ''egg'' countable or uncountable?','easy','''egg'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F4FD961CF9A43B329E00',m.id,l.id,'In its ordinary general meaning, is ''car'' countable or uncountable?','easy','''car'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-85F4BFDC0C6A27707A3B',m.id,l.id,'In its ordinary general meaning, is ''banana'' countable or uncountable?','hard','''banana'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58397F8496C7637C6D45',m.id,l.id,'In its ordinary general meaning, is ''pencil'' countable or uncountable?','hard','''pencil'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',TRUE,0),('Uncountable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3D5C4811D4ADC0D4D89E',m.id,l.id,'In its ordinary general meaning, is ''bottle'' countable or uncountable?','easy','''bottle'' secara umum merupakan countable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Countable',TRUE,1),('Uncountable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F922CDE0A5823CBA594B',m.id,l.id,'In its ordinary general meaning, is ''water'' countable or uncountable?','medium','''water'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',TRUE,0),('Countable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-14F66E370329AD8F57AB',m.id,l.id,'In its ordinary general meaning, is ''rice'' countable or uncountable?','easy','''rice'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Uncountable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-22102596C1B708220DBA',m.id,l.id,'In its ordinary general meaning, is ''information'' countable or uncountable?','medium','''information'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a verb',FALSE,0),('Always a pronoun',FALSE,1),('Uncountable',TRUE,2),('Countable',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0DEECCA8B7E98BED40CE',m.id,l.id,'In its ordinary general meaning, is ''furniture'' countable or uncountable?','easy','''furniture'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',TRUE,0),('Countable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2C005B1515D81D15AC75',m.id,l.id,'In its ordinary general meaning, is ''advice'' countable or uncountable?','hard','''advice'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Uncountable',TRUE,1),('Countable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB3B8122EB42757CB4DA',m.id,l.id,'In its ordinary general meaning, is ''music'' countable or uncountable?','hard','''music'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a verb',FALSE,0),('Always a pronoun',FALSE,1),('Uncountable',TRUE,2),('Countable',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CC5F87A0B69898B4E944',m.id,l.id,'In its ordinary general meaning, is ''sugar'' countable or uncountable?','easy','''sugar'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Uncountable',TRUE,0),('Countable',FALSE,1),('Always a verb',FALSE,2),('Always a pronoun',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A7D19AD18F98446E489A',m.id,l.id,'In its ordinary general meaning, is ''milk'' countable or uncountable?','hard','''milk'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Uncountable',TRUE,1),('Countable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0F8DD65DCBA117960E87',m.id,l.id,'In its ordinary general meaning, is ''homework'' countable or uncountable?','easy','''homework'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Uncountable',TRUE,1),('Countable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9ED303B940F4C7C3652',m.id,l.id,'In its ordinary general meaning, is ''money'' countable or uncountable?','easy','''money'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Uncountable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C99CF4079EFC5CE7FF84',m.id,l.id,'In its ordinary general meaning, is ''bread'' countable or uncountable?','medium','''bread'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Countable',FALSE,0),('Always a verb',FALSE,1),('Always a pronoun',FALSE,2),('Uncountable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-092EC7913351D6BF5B07',m.id,l.id,'In its ordinary general meaning, is ''equipment'' countable or uncountable?','easy','''equipment'' secara umum merupakan uncountable noun dalam konteks dasar ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='countable-vs-uncountable' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Always a pronoun',FALSE,0),('Uncountable',TRUE,1),('Countable',FALSE,2),('Always a verb',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0F503BCA3D4F0920D172',m.id,l.id,'Choose the correct article: She has _____ apple.','medium','''apple'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('an',TRUE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9F5B2C61CCA29D38FA6',m.id,l.id,'Choose the correct article: She has _____ book.','hard','''book'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('a',TRUE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CB3672B029DB75637628',m.id,l.id,'Choose the correct article: She has _____ egg.','hard','''egg'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',TRUE,0),('a',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1102A061C1C71349B019',m.id,l.id,'Choose the correct article: She has _____ umbrella.','medium','''umbrella'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('an',TRUE,1),('a',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1D0D291F19CB6D0B2B8D',m.id,l.id,'Choose the correct article: She has _____ hour.','easy','''hour'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FA77B9701D1B786544B5',m.id,l.id,'Choose the correct article: She has _____ university.','medium','''university'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',TRUE,0),('an',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D8EDD9975135732FD249',m.id,l.id,'Choose the correct article: She has _____ teacher.','hard','''teacher'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('some',FALSE,1),('many',FALSE,2),('a',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD0B7A1D552C26C723A1',m.id,l.id,'Choose the correct article: She has _____ artist.','easy','''artist'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('an',TRUE,1),('a',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CB43C6988D0D0678D8DE',m.id,l.id,'Choose the correct article: She has _____ doctor.','medium','''doctor'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',TRUE,0),('an',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-48231E5BC7AB25DEB9BB',m.id,l.id,'Choose the correct article: She has _____ elephant.','hard','''elephant'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6F06DF572F5D9F245930',m.id,l.id,'Choose the correct article: She has _____ honest person.','hard','''honest person'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB52832E3AA2F966058B',m.id,l.id,'Choose the correct article: She has _____ European country.','medium','''European country'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('a',TRUE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-266A05CBBC68B758892B',m.id,l.id,'Choose the correct article: She has _____ engineer.','hard','''engineer'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8C46FB2CE23164B336C2',m.id,l.id,'Choose the correct article: She has _____ student.','hard','''student'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',TRUE,0),('an',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-47C9EA60E8EE7EA3E5C3',m.id,l.id,'Choose the correct article: She has _____ orange.','easy','''orange'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',TRUE,0),('a',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B2C7AD86500DD6DE692D',m.id,l.id,'Choose the correct article: She has _____ computer.','medium','''computer'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('a',TRUE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E8C73154D6715BEB1425',m.id,l.id,'Choose the correct article: She has _____ island.','hard','''island'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',TRUE,0),('a',FALSE,1),('some',FALSE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A36EC77E0F545C801975',m.id,l.id,'Choose the correct article: She has _____ house.','medium','''house'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('a',TRUE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0B2C3D1ECE348E689346',m.id,l.id,'Choose the correct article: She has _____ idea.','easy','''idea'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',FALSE,0),('many',FALSE,1),('an',TRUE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73EBEB7D874B15BFDAAF',m.id,l.id,'Choose the correct article: She has _____ useful book.','hard','''useful book'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',TRUE,1),('an',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A419E93D5E45D5E9ADA2',m.id,l.id,'Choose the correct article: She has _____ old bike.','easy','''old bike'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('an',TRUE,1),('a',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-463C014D75FBAE68C623',m.id,l.id,'Choose the correct article: She has _____ young child.','medium','''young child'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',TRUE,1),('an',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AF6356BB7D45C03C6A5C',m.id,l.id,'Choose the correct article: She has _____ interesting story.','hard','''interesting story'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CAEAB985418D45DA2AB6',m.id,l.id,'Choose the correct article: She has _____ one-way ticket.','medium','''one-way ticket'' diawali bunyi konsonan, sehingga memakai ''a''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',TRUE,1),('an',FALSE,2),('some',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A269F403C3DA3802F18A',m.id,l.id,'Choose the correct article: She has _____ English class.','easy','''English class'' diawali bunyi vokal, sehingga memakai ''an''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='a-an' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',FALSE,1),('many',FALSE,2),('an',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D931E7D1789ACF293B58',m.id,l.id,'There are _____ books on the shelf. (affirmative)','easy','Some bisa dipakai bersama plural countable dalam kalimat afirmatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('some',TRUE,1),('much',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-03D78985989E459F7E56',m.id,l.id,'There isn''t _____ milk in the bottle.','medium','Any biasa dipakai dalam kalimat negatif untuk milk.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('any',TRUE,1),('many',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-72037E4E2C4C8F66C622',m.id,l.id,'We have _____ chairs for the guests. (affirmative)','hard','Some dapat menerangkan countable plural dalam kalimat afirmatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('a',FALSE,1),('some',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-63AF208E86295A5874AC',m.id,l.id,'I don''t have _____ homework tonight.','hard','Homework uncountable; any lazim dipakai dalam kalimat negatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('any',TRUE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-991AABD878F8AA8696EB',m.id,l.id,'_____ people attended the meeting. (a large number)','easy','People countable plural memakai many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Many',TRUE,0),('Much',FALSE,1),('A',FALSE,2),('An',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D7A8BD379C7801790DFF',m.id,l.id,'How _____ rice do you need?','hard','Rice uncountable memakai much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3FDAA4C9256880D42DD6',m.id,l.id,'How _____ students are absent today?','medium','Students plural countable memakai many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('many',TRUE,1),('much',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BF540CBB8AF6256E0ED6',m.id,l.id,'We need _____ sugar for the cake. (a small unspecified amount)','easy','Some dapat dipakai dengan sugar yang uncountable.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('an',FALSE,1),('a',FALSE,2),('some',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28B02319237647D531F4',m.id,l.id,'Do you have _____ questions?','hard','Any umum dalam pertanyaan umum dengan plural countable.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('any',TRUE,1),('much',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-04BF61F2600B09FB4D70',m.id,l.id,'Would you like _____ tea? (an offer)','medium','Some sering dipakai dalam tawaran.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('some',TRUE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-63C0B0E2D26019A502DD',m.id,l.id,'There are not _____ oranges left.','medium','Any pada kalimat negatif dengan plural countable.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('any',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0FE484BBDA6ECB7C7F13',m.id,l.id,'He has _____ friends in London. (a large number)','medium','Friends countable plural memakai many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('an',FALSE,1),('a',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C2B6244827F1F5468E04',m.id,l.id,'We don''t have _____ information about the event.','medium','Information uncountable dan kalimat negatif memakai any.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('any',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B8CBC1CC0B2BDB30ACE7',m.id,l.id,'She drank _____ water after running.','easy','Some dapat menunjukkan jumlah tidak pasti dari uncountable water.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',TRUE,0),('many',FALSE,1),('an',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E99322063A9CCAED2DE',m.id,l.id,'How _____ money did you spend?','medium','Money uncountable dalam makna umum.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B417D9F2BF9CBBF077A5',m.id,l.id,'I found _____ apples in the kitchen. (affirmative)','easy','Some sesuai untuk plural apples dalam kalimat afirmatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('a',FALSE,1),('some',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-735CB81044928D3F0D8A',m.id,l.id,'He didn''t buy _____ bread.','medium','Any cocok untuk negatif dan bread uncountable.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('any',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F64219872CB8162FF16',m.id,l.id,'How _____ bags do you carry?','medium','Bags plural countable memerlukan many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',TRUE,0),('much',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-08268FA2E6E7C9D2CA56',m.id,l.id,'There is _____ cheese in the fridge. (an unspecified amount)','hard','Cheese sebagai zat makanan uncountable memakai some.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('some',TRUE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4892D7634F6D1FB0E9F6',m.id,l.id,'We haven''t got _____ time.','hard','Time dalam makna durasi merupakan uncountable sehingga much tepat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-72E1E8D128EBA2843230',m.id,l.id,'She has _____ pencils in her case. (several)','hard','Pencils plural countable dan jumlah tak tentu menggunakan some.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('some',TRUE,1),('much',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-04F321C1FC268D994300',m.id,l.id,'Is there _____ juice left?','hard','Any umum pada pertanyaan tentang sisa juice.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('any',TRUE,1),('many',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-25E1D3D32FB96A553E7B',m.id,l.id,'There aren''t _____ buses after midnight.','easy','Buses dapat dihitung; many cocok untuk sedikit jumlah tersisa dalam negatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C6B6C7F89A7F97E4AC41',m.id,l.id,'I have _____ good news for you.','easy','News diperlakukan uncountable; some good news benar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('some',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BC21D527C67916AC9A36',m.id,l.id,'How _____ furniture is in the room?','easy','Furniture uncountable sehingga how much benar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='some-any' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C0D312EBE9D2A4D4B0CC',m.id,l.id,'Complete: How _____ books do we need?','easy','Noun ''books'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1263B6AFA86CB64A8B6E',m.id,l.id,'Complete: How _____ apples do we need?','medium','Noun ''apples'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-34EB4BB733F0C759BDD0',m.id,l.id,'Complete: How _____ chairs do we need?','easy','Noun ''chairs'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5C700633B3D786EEF3CE',m.id,l.id,'Complete: How _____ students do we need?','medium','Noun ''students'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-38562032EA87E6333784',m.id,l.id,'Complete: How _____ eggs do we need?','hard','Noun ''eggs'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('many',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D5AB80BFC8FEF6A86009',m.id,l.id,'Complete: How _____ windows do we need?','medium','Noun ''windows'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9C8DFDD26603FC4C78D',m.id,l.id,'Complete: How _____ cars do we need?','easy','Noun ''cars'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('many',TRUE,1),('much',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DFA547B3F51A59A66545',m.id,l.id,'Complete: How _____ pencils do we need?','medium','Noun ''pencils'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-984FDD8FD37630A97DC0',m.id,l.id,'Complete: How _____ people do we need?','easy','Noun ''people'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',FALSE,0),('a',FALSE,1),('an',FALSE,2),('many',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BA0182A912516155BD5',m.id,l.id,'Complete: How _____ bananas do we need?','easy','Noun ''bananas'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('many',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2DED48CAD5037B835D36',m.id,l.id,'Complete: How _____ bottles do we need?','hard','Noun ''bottles'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('many',TRUE,2),('much',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CE52FBB1199C6A40A66E',m.id,l.id,'Complete: How _____ houses do we need?','easy','Noun ''houses'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('many',TRUE,1),('much',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-05DE6FB8ACC039F1C270',m.id,l.id,'Complete: How _____ phones do we need?','hard','Noun ''phones'' berbentuk plural countable → many.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',TRUE,0),('much',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58A705435DB4DE15FDB0',m.id,l.id,'Complete: How _____ milk do we need?','easy','Noun ''milk'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0629EBB1B57A9DA03FC9',m.id,l.id,'Complete: How _____ sugar do we need?','hard','Noun ''sugar'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('an',FALSE,0),('much',TRUE,1),('many',FALSE,2),('a',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C47B9EF7CF531799B662',m.id,l.id,'Complete: How _____ rice do we need?','medium','Noun ''rice'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-15BA9C18C77E0C07648E',m.id,l.id,'Complete: How _____ water do we need?','hard','Noun ''water'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-859783B761B0B6E81875',m.id,l.id,'Complete: How _____ money do we need?','easy','Noun ''money'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ECF407383707EEA45C1E',m.id,l.id,'Complete: How _____ information do we need?','hard','Noun ''information'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-50B18772BB770BB0DAF3',m.id,l.id,'Complete: How _____ furniture do we need?','medium','Noun ''furniture'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('much',TRUE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-82F7FD7C1371CE6F33AF',m.id,l.id,'Complete: How _____ homework do we need?','hard','Noun ''homework'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7FAC8D43DF7B7B74408E',m.id,l.id,'Complete: How _____ music do we need?','easy','Noun ''music'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F23BD350B6985866E5E9',m.id,l.id,'Complete: How _____ advice do we need?','hard','Noun ''advice'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('much',TRUE,0),('many',FALSE,1),('a',FALSE,2),('an',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ACD3E17378E4EBB5A919',m.id,l.id,'Complete: How _____ bread do we need?','hard','Noun ''bread'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('many',FALSE,0),('a',FALSE,1),('an',FALSE,2),('much',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-25786E06E7409C27506C',m.id,l.id,'Complete: How _____ coffee do we need?','medium','Noun ''coffee'' berbentuk uncountable → much.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='how-much-many' WHERE m.slug='countable-uncountable'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('a',FALSE,0),('an',FALSE,1),('much',TRUE,2),('many',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0391014008E2AD501B39',m.id,l.id,'Choose the standard plural form of ''book''.','medium','Dalam pemakaian umum, bentuk plural dari ''book'' adalah ''books''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('books',TRUE,0),('bookes',FALSE,1),('bookies',FALSE,2),('bookses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DA302DE53A5184DFB166',m.id,l.id,'Choose the standard plural form of ''pen''.','hard','Dalam pemakaian umum, bentuk plural dari ''pen'' adalah ''pens''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('penses',FALSE,0),('pens',TRUE,1),('penes',FALSE,2),('penies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AC5A10372336AF21478D',m.id,l.id,'Choose the standard plural form of ''hand''.','easy','Dalam pemakaian umum, bentuk plural dari ''hand'' adalah ''hands''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('handes',FALSE,0),('handies',FALSE,1),('handses',FALSE,2),('hands',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A830ACE6BE8D5BBB34C1',m.id,l.id,'Choose the standard plural form of ''flower''.','easy','Dalam pemakaian umum, bentuk plural dari ''flower'' adalah ''flowers''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('floweries',FALSE,0),('flowerses',FALSE,1),('flowers',TRUE,2),('floweres',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-05FF0195567FC08AFF4C',m.id,l.id,'Choose the standard plural form of ''roof''.','easy','Dalam pemakaian umum, bentuk plural dari ''roof'' adalah ''roofs''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('roofses',FALSE,0),('roofs',TRUE,1),('roofes',FALSE,2),('roofies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D4C36E1C2620377E28F3',m.id,l.id,'Choose the standard plural form of ''bus''.','hard','Dalam pemakaian umum, bentuk plural dari ''bus'' adalah ''buses''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('buses',TRUE,0),('buss',FALSE,1),('busies',FALSE,2),('busses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E31023C81F42BCA08ED9',m.id,l.id,'Choose the standard plural form of ''box''.','medium','Dalam pemakaian umum, bentuk plural dari ''box'' adalah ''boxes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('boxes',TRUE,0),('boxs',FALSE,1),('boxies',FALSE,2),('boxses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E64DD712391FB1EE2DBB',m.id,l.id,'Choose the standard plural form of ''church''.','hard','Dalam pemakaian umum, bentuk plural dari ''church'' adalah ''churches''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('churchies',FALSE,0),('churchses',FALSE,1),('churches',TRUE,2),('churchs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E9C7B34DC2AC8111649',m.id,l.id,'Choose the standard plural form of ''brush''.','hard','Dalam pemakaian umum, bentuk plural dari ''brush'' adalah ''brushes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('brushes',TRUE,0),('brushs',FALSE,1),('brushies',FALSE,2),('brushses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-288B5C4C9C1E22CC2456',m.id,l.id,'Choose the standard plural form of ''hero''.','medium','Dalam pemakaian umum, bentuk plural dari ''hero'' adalah ''heroes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('heroes',TRUE,0),('heros',FALSE,1),('heroies',FALSE,2),('heroses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-05A8404A6FD1BE6831D8',m.id,l.id,'Choose the standard plural form of ''tomato''.','hard','Dalam pemakaian umum, bentuk plural dari ''tomato'' adalah ''tomatoes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tomatoies',FALSE,0),('tomatoses',FALSE,1),('tomatoes',TRUE,2),('tomatos',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-38C1746051C7E092244F',m.id,l.id,'Choose the standard plural form of ''potato''.','hard','Dalam pemakaian umum, bentuk plural dari ''potato'' adalah ''potatoes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('potatoes',TRUE,0),('potatos',FALSE,1),('potatoies',FALSE,2),('potatoses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5536ED5444610196085C',m.id,l.id,'Choose the standard plural form of ''mosquito''.','medium','Dalam pemakaian umum, bentuk plural dari ''mosquito'' adalah ''mosquitoes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mosquitoes',TRUE,0),('mosquitos',FALSE,1),('mosquitoies',FALSE,2),('mosquitoses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FFC1CEFB58BB5B0AE851',m.id,l.id,'Choose the standard plural form of ''radio''.','medium','Dalam pemakaian umum, bentuk plural dari ''radio'' adalah ''radios''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('radioes',FALSE,0),('radioies',FALSE,1),('radioses',FALSE,2),('radios',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9754261879F3E2A580AE',m.id,l.id,'Choose the standard plural form of ''photo''.','hard','Dalam pemakaian umum, bentuk plural dari ''photo'' adalah ''photos''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('photos',TRUE,0),('photoes',FALSE,1),('photoies',FALSE,2),('photoses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AAEE84F150E4B358630C',m.id,l.id,'Choose the standard plural form of ''piano''.','hard','Dalam pemakaian umum, bentuk plural dari ''piano'' adalah ''pianos''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('pianoses',FALSE,0),('pianos',TRUE,1),('pianoes',FALSE,2),('pianoies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4DBC62B74CD0A9156949',m.id,l.id,'Choose the standard plural form of ''video''.','easy','Dalam pemakaian umum, bentuk plural dari ''video'' adalah ''videos''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('videoes',FALSE,0),('videoies',FALSE,1),('videoses',FALSE,2),('videos',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7FD86E3C62CC84108182',m.id,l.id,'Choose the standard plural form of ''watch''.','easy','Dalam pemakaian umum, bentuk plural dari ''watch'' adalah ''watches''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('watches',TRUE,0),('watchs',FALSE,1),('watchies',FALSE,2),('watchses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1CD3B5EAE2E285AB13AC',m.id,l.id,'Choose the standard plural form of ''dish''.','easy','Dalam pemakaian umum, bentuk plural dari ''dish'' adalah ''dishes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dishies',FALSE,0),('dishses',FALSE,1),('dishes',TRUE,2),('dishs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0F0E3815DAB555D2D345',m.id,l.id,'Choose the standard plural form of ''class''.','medium','Dalam pemakaian umum, bentuk plural dari ''class'' adalah ''classes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('classses',FALSE,0),('classes',TRUE,1),('classs',FALSE,2),('classies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C4F8D17AA63D1D0DC5B0',m.id,l.id,'Choose the standard plural form of ''fox''.','hard','Dalam pemakaian umum, bentuk plural dari ''fox'' adalah ''foxes''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('foxies',FALSE,0),('foxses',FALSE,1),('foxes',TRUE,2),('foxs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EFAD7BDA36176B29DC87',m.id,l.id,'Choose the standard plural form of ''bench''.','easy','Dalam pemakaian umum, bentuk plural dari ''bench'' adalah ''benches''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('benchies',FALSE,0),('benchses',FALSE,1),('benches',TRUE,2),('benchs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D068FB4DE4D93D6258CA',m.id,l.id,'Choose the standard plural form of ''car''.','medium','Dalam pemakaian umum, bentuk plural dari ''car'' adalah ''cars''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carses',FALSE,0),('cars',TRUE,1),('cares',FALSE,2),('caries',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F144A4F70579BB5CABDE',m.id,l.id,'Choose the standard plural form of ''cup''.','easy','Dalam pemakaian umum, bentuk plural dari ''cup'' adalah ''cups''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cupes',FALSE,0),('cupies',FALSE,1),('cupses',FALSE,2),('cups',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C673C7E30D6E672AC5FD',m.id,l.id,'Choose the standard plural form of ''dress''.','medium','Dalam pemakaian umum, bentuk plural dari ''dress'' adalah ''dresses''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='regular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dresss',FALSE,0),('dressies',FALSE,1),('dressses',FALSE,2),('dresses',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0B48814507572DFBA30D',m.id,l.id,'What is the standard plural of ''baby''?','easy','''baby'' memiliki bentuk plural ''babies'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('babves',FALSE,0),('babies',TRUE,1),('babys',FALSE,2),('babyes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A07174DA8A6288763A9A',m.id,l.id,'What is the standard plural of ''lady''?','medium','''lady'' memiliki bentuk plural ''ladies'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('ladyes',FALSE,0),('ladves',FALSE,1),('ladies',TRUE,2),('ladys',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A7B92F78CE2B7E1473A9',m.id,l.id,'What is the standard plural of ''duty''?','hard','''duty'' memiliki bentuk plural ''duties'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('duties',TRUE,0),('dutys',FALSE,1),('dutyes',FALSE,2),('dutves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F81CDDBF755290AFB8AB',m.id,l.id,'What is the standard plural of ''cherry''?','hard','''cherry'' memiliki bentuk plural ''cherries'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cherrys',FALSE,0),('cherryes',FALSE,1),('cherrves',FALSE,2),('cherries',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-52CE2FFCBA81E412B40A',m.id,l.id,'What is the standard plural of ''city''?','easy','''city'' memiliki bentuk plural ''cities'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cities',TRUE,0),('citys',FALSE,1),('cityes',FALSE,2),('citves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F00FB115D59689CB0DF7',m.id,l.id,'What is the standard plural of ''country''?','medium','''country'' memiliki bentuk plural ''countries'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('countrves',FALSE,0),('countries',TRUE,1),('countrys',FALSE,2),('countryes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F733142AB3B319BBEA9',m.id,l.id,'What is the standard plural of ''party''?','hard','''party'' memiliki bentuk plural ''parties'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('partyes',FALSE,0),('partves',FALSE,1),('parties',TRUE,2),('partys',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-40E8083770581C4822BE',m.id,l.id,'What is the standard plural of ''story''?','easy','''story'' memiliki bentuk plural ''stories'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('storys',FALSE,0),('storyes',FALSE,1),('storves',FALSE,2),('stories',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A276D220AF067860E8C7',m.id,l.id,'What is the standard plural of ''puppy''?','medium','''puppy'' memiliki bentuk plural ''puppies'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('puppies',TRUE,0),('puppys',FALSE,1),('puppyes',FALSE,2),('puppves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DC960FF46C4345A1E844',m.id,l.id,'What is the standard plural of ''family''?','easy','''family'' memiliki bentuk plural ''families'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('families',TRUE,0),('familys',FALSE,1),('familyes',FALSE,2),('familves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-13F5FA02C3189E12F4F4',m.id,l.id,'What is the standard plural of ''boy''?','hard','''boy'' memiliki bentuk plural ''boys'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('boies',FALSE,0),('boves',FALSE,1),('boys',TRUE,2),('boyes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A3FF40BE3028BCEE1ABF',m.id,l.id,'What is the standard plural of ''key''?','medium','''key'' memiliki bentuk plural ''keys'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('keies',FALSE,0),('keves',FALSE,1),('keys',TRUE,2),('keyes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91DF098341C3C8F99900',m.id,l.id,'What is the standard plural of ''day''?','medium','''day'' memiliki bentuk plural ''days'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('dayes',FALSE,0),('daies',FALSE,1),('daves',FALSE,2),('days',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A4291B033F4CB8471BAF',m.id,l.id,'What is the standard plural of ''toy''?','medium','''toy'' memiliki bentuk plural ''toys'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('toyes',FALSE,0),('toies',FALSE,1),('toves',FALSE,2),('toys',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EF7995922C8510D450C5',m.id,l.id,'What is the standard plural of ''monkey''?','easy','''monkey'' memiliki bentuk plural ''monkeys'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('monkeies',FALSE,0),('monkeves',FALSE,1),('monkeys',TRUE,2),('monkeyes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1681BFC8164C465BEC0D',m.id,l.id,'What is the standard plural of ''knife''?','medium','''knife'' memiliki bentuk plural ''knives'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('knives',TRUE,0),('knifes',FALSE,1),('knifees',FALSE,2),('knifies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-789C68FBF985F953A1E6',m.id,l.id,'What is the standard plural of ''calf''?','easy','''calf'' memiliki bentuk plural ''calves'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('calfs',FALSE,0),('calfes',FALSE,1),('calies',FALSE,2),('calves',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3E08D9752D78E97C1D08',m.id,l.id,'What is the standard plural of ''shelf''?','easy','''shelf'' memiliki bentuk plural ''shelves'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('shelies',FALSE,0),('shelves',TRUE,1),('shelfs',FALSE,2),('shelfes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-63943AD79D27D6D5A12F',m.id,l.id,'What is the standard plural of ''leaf''?','hard','''leaf'' memiliki bentuk plural ''leaves'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('leafs',FALSE,0),('leafes',FALSE,1),('leaies',FALSE,2),('leaves',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1B0F26CBA45EB5C813C7',m.id,l.id,'What is the standard plural of ''half''?','easy','''half'' memiliki bentuk plural ''halves'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('halfs',FALSE,0),('halfes',FALSE,1),('halies',FALSE,2),('halves',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1A104A2FA117D7348BE2',m.id,l.id,'What is the standard plural of ''wolf''?','medium','''wolf'' memiliki bentuk plural ''wolves'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wolfs',FALSE,0),('wolfes',FALSE,1),('wolies',FALSE,2),('wolves',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A74ED80D7D5D88AC6686',m.id,l.id,'What is the standard plural of ''wife''?','medium','''wife'' memiliki bentuk plural ''wives'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wifies',FALSE,0),('wives',TRUE,1),('wifes',FALSE,2),('wifees',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CB34E71E7F07B4582F55',m.id,l.id,'What is the standard plural of ''chief''?','easy','''chief'' memiliki bentuk plural ''chiefs'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('chieies',FALSE,0),('chieves',FALSE,1),('chiefs',TRUE,2),('chiefes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B9094414E39ED88EEAB8',m.id,l.id,'What is the standard plural of ''proof''?','hard','''proof'' memiliki bentuk plural ''proofs'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('proofs',TRUE,0),('proofes',FALSE,1),('prooies',FALSE,2),('prooves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9FC35D5FA59E24E494B2',m.id,l.id,'What is the standard plural of ''belief''?','hard','''belief'' memiliki bentuk plural ''beliefs'' sesuai aturan ejaan atau pengecualiannya.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='y-f-fe-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beliefes',FALSE,0),('belieies',FALSE,1),('believes',FALSE,2),('beliefs',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-36C7D999F939EC88F890',m.id,l.id,'What is the standard plural form for ''child''?','easy','Kata ''child'' memiliki bentuk jamak ''children'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('childies',FALSE,0),('children',TRUE,1),('childs',FALSE,2),('childes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DAFB9B30313D9558CAE7',m.id,l.id,'What is the standard plural form for ''man''?','hard','Kata ''man'' memiliki bentuk jamak ''men'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('men',TRUE,0),('mans',FALSE,1),('manes',FALSE,2),('manies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FFC3C2CAF460A7D6C841',m.id,l.id,'What is the standard plural form for ''woman''?','medium','Kata ''woman'' memiliki bentuk jamak ''women'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('womanes',FALSE,0),('womanies',FALSE,1),('women',TRUE,2),('womans',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-14855B4734949A4EDA57',m.id,l.id,'What is the standard plural form for ''foot''?','easy','Kata ''foot'' memiliki bentuk jamak ''feet'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('foots',FALSE,0),('footes',FALSE,1),('footies',FALSE,2),('feet',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D827C1FE50B0C22DE662',m.id,l.id,'What is the standard plural form for ''tooth''?','easy','Kata ''tooth'' memiliki bentuk jamak ''teeth'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('toothes',FALSE,0),('toothies',FALSE,1),('teeth',TRUE,2),('tooths',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-68A0A139106E3E0B0D99',m.id,l.id,'What is the standard plural form for ''mouse''?','medium','Kata ''mouse'' memiliki bentuk jamak ''mice'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mouseies',FALSE,0),('mice',TRUE,1),('mouses',FALSE,2),('mousees',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9791452FC6A5736C7D67',m.id,l.id,'What is the standard plural form for ''goose''?','medium','Kata ''goose'' memiliki bentuk jamak ''geese'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gooses',FALSE,0),('goosees',FALSE,1),('gooseies',FALSE,2),('geese',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E40FE1A9BFF26517EEB',m.id,l.id,'What is the standard plural form for ''person''?','medium','Kata ''person'' memiliki bentuk jamak ''people'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('persones',FALSE,0),('personies',FALSE,1),('people',TRUE,2),('persons',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A7590EAED18872F3605D',m.id,l.id,'What is the standard plural form for ''ox''?','easy','Kata ''ox'' memiliki bentuk jamak ''oxen'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('oxes',FALSE,0),('oxies',FALSE,1),('oxen',TRUE,2),('oxs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-770DF61F508C3BD40B1E',m.id,l.id,'What is the standard plural form for ''louse''?','hard','Kata ''louse'' memiliki bentuk jamak ''lice'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('louses',FALSE,0),('lousees',FALSE,1),('louseies',FALSE,2),('lice',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9D0903E643B2DE136F9',m.id,l.id,'What is the standard plural form for ''sheep''?','easy','Kata ''sheep'' memiliki bentuk jamak ''sheep'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sheepes',FALSE,0),('sheepies',FALSE,1),('sheep',TRUE,2),('sheeps',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8680DA1EE15634F036FD',m.id,l.id,'What is the standard plural form for ''deer''?','easy','Kata ''deer'' memiliki bentuk jamak ''deer'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('deeres',FALSE,0),('deeries',FALSE,1),('deer',TRUE,2),('deers',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7CF3CF0289A308951CAB',m.id,l.id,'What is the standard plural form for ''fish''?','medium','Kata ''fish'' memiliki bentuk jamak ''fish'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fishes',FALSE,0),('fishies',FALSE,1),('fish',TRUE,2),('fishs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-321FCDAA0C57C9FB4592',m.id,l.id,'What is the standard plural form for ''person (two people)''?','hard','Kata ''person'' memiliki bentuk jamak ''people'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('persones',FALSE,0),('personies',FALSE,1),('people',TRUE,2),('persons',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-795A5A5073E4BEBB64B9',m.id,l.id,'What is the standard plural form for ''child (three of them)''?','easy','Kata ''child'' memiliki bentuk jamak ''children'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('children',TRUE,0),('childs',FALSE,1),('childes',FALSE,2),('childies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-74CF86800B8259401A7B',m.id,l.id,'What is the standard plural form for ''woman (four of them)''?','easy','Kata ''woman'' memiliki bentuk jamak ''women'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('women',TRUE,0),('womans',FALSE,1),('womanes',FALSE,2),('womanies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-87ED391A53648400FF91',m.id,l.id,'What is the standard plural form for ''man (five of them)''?','easy','Kata ''man'' memiliki bentuk jamak ''men'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('manes',FALSE,0),('manies',FALSE,1),('men',TRUE,2),('mans',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6633C042E4969138C466',m.id,l.id,'What is the standard plural form for ''mouse (two animals)''?','easy','Kata ''mouse'' memiliki bentuk jamak ''mice'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mousees',FALSE,0),('mouseies',FALSE,1),('mice',TRUE,2),('mouses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-649FE7F1854EA01FA9F2',m.id,l.id,'What is the standard plural form for ''foot (both)''?','easy','Kata ''foot'' memiliki bentuk jamak ''feet'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('footies',FALSE,0),('feet',TRUE,1),('foots',FALSE,2),('footes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-931D8FB5B0F8F3CC0502',m.id,l.id,'What is the standard plural form for ''tooth (many)''?','medium','Kata ''tooth'' memiliki bentuk jamak ''teeth'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('toothies',FALSE,0),('teeth',TRUE,1),('tooths',FALSE,2),('toothes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2DBD35D7DC24212D9781',m.id,l.id,'What is the standard plural form for ''goose (a flock)''?','medium','Kata ''goose'' memiliki bentuk jamak ''geese'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gooses',FALSE,0),('goosees',FALSE,1),('gooseies',FALSE,2),('geese',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A5CDBE3B9662D274C340',m.id,l.id,'What is the standard plural form for ''ox (two animals)''?','medium','Kata ''ox'' memiliki bentuk jamak ''oxen'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('oxs',FALSE,0),('oxes',FALSE,1),('oxies',FALSE,2),('oxen',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-11FB7EB0D5DB41406B92',m.id,l.id,'What is the standard plural form for ''sheep (several)''?','easy','Kata ''sheep'' memiliki bentuk jamak ''sheep'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sheep',TRUE,0),('sheeps',FALSE,1),('sheepes',FALSE,2),('sheepies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-400EE556238DEDC99D21',m.id,l.id,'What is the standard plural form for ''deer (several)''?','hard','Kata ''deer'' memiliki bentuk jamak ''deer'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('deeres',FALSE,0),('deeries',FALSE,1),('deer',TRUE,2),('deers',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-53CFCC5AEDCBF86E74B7',m.id,l.id,'What is the standard plural form for ''louse (many)''?','easy','Kata ''louse'' memiliki bentuk jamak ''lice'' dalam penggunaan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-plurals' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lousees',FALSE,0),('louseies',FALSE,1),('lice',TRUE,2),('louses',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D13CF4B2A31E21331A7',m.id,l.id,'Complete: The girl _____ ready for class.','easy','Subject ''The girl'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('am',FALSE,1),('be',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09227832AFC32402D0A5',m.id,l.id,'Complete: The girls _____ near the door.','easy','Subject ''The girls'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('are',TRUE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-79AF97C6D1C32A966DC6',m.id,l.id,'Complete: A student _____ in the classroom.','hard','Subject ''A student'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('is',TRUE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A5BC00D7CD7175E210A1',m.id,l.id,'Complete: The students _____ very expensive.','medium','Subject ''The students'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('am',FALSE,1),('be',FALSE,2),('are',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E814D3D1EF6AED9F5499',m.id,l.id,'Complete: This child _____ on the desk.','easy','Subject ''This child'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('is',TRUE,1),('are',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-43956BA30D0B863A9814',m.id,l.id,'Complete: These children _____ ready for class.','easy','Subject ''These children'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('am',FALSE,1),('be',FALSE,2),('are',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-31D24076DF418B1DDFA1',m.id,l.id,'Complete: That apple _____ near the door.','easy','Subject ''That apple'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('is',TRUE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C1F7C521067E56A5AA25',m.id,l.id,'Complete: Those apples _____ in the classroom.','hard','Subject ''Those apples'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('are',TRUE,1),('is',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EE37EB0F623B7E639939',m.id,l.id,'Complete: A car _____ very expensive.','medium','Subject ''A car'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('am',FALSE,1),('be',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-334A90A5D56664678F08',m.id,l.id,'Complete: The cars _____ on the desk.','hard','Subject ''The cars'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('are',TRUE,1),('is',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-33D3741A0E57ABFF652B',m.id,l.id,'Complete: This box _____ ready for class.','hard','Subject ''This box'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('is',TRUE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-523F7CC8AC13F6A9BC97',m.id,l.id,'Complete: These boxes _____ near the door.','easy','Subject ''These boxes'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('is',FALSE,1),('am',FALSE,2),('be',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C95257503102E3341B6C',m.id,l.id,'Complete: The man _____ in the classroom.','easy','Subject ''The man'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',TRUE,0),('are',FALSE,1),('am',FALSE,2),('be',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-072CCEAECA53C3B2D676',m.id,l.id,'Complete: The men _____ very expensive.','medium','Subject ''The men'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('are',TRUE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-459C7A9F67631690E786',m.id,l.id,'Complete: The woman _____ on the desk.','hard','Subject ''The woman'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('am',FALSE,1),('be',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A205C6E006654F994AA2',m.id,l.id,'Complete: The women _____ ready for class.','easy','Subject ''The women'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('is',FALSE,1),('am',FALSE,2),('be',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5ADCE43915F5634B7CAE',m.id,l.id,'Complete: That mouse _____ near the door.','hard','Subject ''That mouse'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('is',TRUE,1),('are',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5E4A08923958F236F3B5',m.id,l.id,'Complete: Those mice _____ in the classroom.','easy','Subject ''Those mice'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('are',TRUE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-612B710BB9D26D7204AE',m.id,l.id,'Complete: The information _____ very expensive.','easy','Subject ''The information'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('am',FALSE,1),('be',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-66CD9EE9996F1F237423',m.id,l.id,'Complete: The furniture _____ on the desk.','easy','Subject ''The furniture'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('is',TRUE,1),('are',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-81090451AC96F2FDF43A',m.id,l.id,'Complete: This book _____ ready for class.','medium','Subject ''This book'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('is',TRUE,1),('are',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A5946D4071251888574C',m.id,l.id,'Complete: These books _____ near the door.','medium','Subject ''These books'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('is',FALSE,1),('am',FALSE,2),('be',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E4FC2413FA7BE6C2E65',m.id,l.id,'Complete: Those sheep _____ in the classroom.','easy','Subject ''Those sheep'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('are',TRUE,1),('is',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-16D039E2D98D92784B90',m.id,l.id,'Complete: The teacher _____ very expensive.','easy','Subject ''The teacher'' memerlukan ''is'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('be',FALSE,1),('is',TRUE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A70257599F0552B5F9B6',m.id,l.id,'Complete: Our friends _____ on the desk.','medium','Subject ''Our friends'' memerlukan ''are'' untuk kesesuaian singular/plural pada kalimat ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='plural-agreement' WHERE m.slug='singular-plural'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('be',FALSE,0),('are',TRUE,1),('is',FALSE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-46EDF992A10F9F85A5A2',m.id,l.id,'Complete the nominal sentence: I _____ happy.','easy','Subject ''I'' cocok dengan bentuk to be ''am'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',FALSE,1),('am',TRUE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D1F093C921075F1CEFF',m.id,l.id,'Complete the nominal sentence: He _____ at home.','medium','Subject ''He'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',TRUE,0),('am',FALSE,1),('are',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-46D962C43D0F94F8EDBB',m.id,l.id,'Complete the nominal sentence: She _____ ready.','medium','Subject ''She'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',TRUE,0),('am',FALSE,1),('are',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D8146D3BE6F48A41CBD',m.id,l.id,'Complete the nominal sentence: It _____ very helpful.','easy','Subject ''It'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('are',FALSE,1),('does',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DF567774C3EBD3A4BC8D',m.id,l.id,'Complete the nominal sentence: You _____ in the garden.','medium','Subject ''You'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('am',FALSE,1),('is',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CB86DDD9ACC360ABD2E6',m.id,l.id,'Complete the nominal sentence: We _____ happy.','medium','Subject ''We'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('are',TRUE,1),('am',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-859172866DBC0FC647AF',m.id,l.id,'Complete the nominal sentence: They _____ at home.','easy','Subject ''They'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('does',FALSE,1),('are',TRUE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-60973B463C2AEF36B1DB',m.id,l.id,'Complete the nominal sentence: My father _____ ready.','hard','Subject ''My father'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',FALSE,1),('is',TRUE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9BF2214BFF06EEDD1BCC',m.id,l.id,'Complete the nominal sentence: My parents _____ very helpful.','easy','Subject ''My parents'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('is',FALSE,1),('does',FALSE,2),('are',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-08FF7BB973B5C298E0BC',m.id,l.id,'Complete the nominal sentence: The children _____ in the garden.','easy','Subject ''The children'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('are',TRUE,1),('am',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F1358B7A58F3690A37DF',m.id,l.id,'Complete the nominal sentence: The doctor _____ happy.','hard','Subject ''The doctor'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',FALSE,1),('is',TRUE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8B01D08045B09E9A33A0',m.id,l.id,'Complete the nominal sentence: These students _____ at home.','hard','Subject ''These students'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('am',FALSE,1),('is',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AA0C6C4131CEDC5670D4',m.id,l.id,'Complete the nominal sentence: A cat _____ ready.','easy','Subject ''A cat'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('is',TRUE,1),('am',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5CC44C455B1E38E862F1',m.id,l.id,'Complete the nominal sentence: Those books _____ very helpful.','medium','Subject ''Those books'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('are',TRUE,1),('am',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BFB4549F708F5ADCF711',m.id,l.id,'Complete the nominal sentence: The weather _____ in the garden.','medium','Subject ''The weather'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('are',FALSE,1),('does',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-85860F558B9DFE590195',m.id,l.id,'Complete the nominal sentence: Our classroom _____ happy.','easy','Subject ''Our classroom'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('is',TRUE,1),('am',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BCCDBC1B0E371C6A74BF',m.id,l.id,'Complete the nominal sentence: Rina _____ at home.','hard','Subject ''Rina'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('are',FALSE,1),('does',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-889C6E1BE4F51A28F69D',m.id,l.id,'Complete the nominal sentence: Rina and Ali _____ ready.','hard','Subject ''Rina and Ali'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('is',FALSE,1),('does',FALSE,2),('are',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D243226F3875CCD81BC2',m.id,l.id,'Complete the nominal sentence: My brother _____ very helpful.','hard','Subject ''My brother'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('are',FALSE,1),('does',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-161260A89782D0B21103',m.id,l.id,'Complete the nominal sentence: My sisters _____ in the garden.','medium','Subject ''My sisters'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('am',FALSE,1),('is',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7C2A77787EA2BFAC5AE0',m.id,l.id,'Complete the nominal sentence: The coffee _____ happy.','easy','Subject ''The coffee'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',TRUE,0),('am',FALSE,1),('are',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E8318276D1F3B4A71EFA',m.id,l.id,'Complete the nominal sentence: This flower _____ at home.','medium','Subject ''This flower'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',FALSE,1),('is',TRUE,2),('am',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-93E7B7E05CC01C89A244',m.id,l.id,'Complete the nominal sentence: Both teachers _____ ready.','hard','Subject ''Both teachers'' cocok dengan bentuk to be ''are'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',TRUE,0),('am',FALSE,1),('is',FALSE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5208C1719C55299CC736',m.id,l.id,'Complete the nominal sentence: A bicycle _____ very helpful.','easy','Subject ''A bicycle'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',FALSE,0),('is',TRUE,1),('am',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4F5F1D57FAACF2605730',m.id,l.id,'Complete the nominal sentence: The furniture _____ in the garden.','medium','Subject ''The furniture'' cocok dengan bentuk to be ''is'' pada Simple Present nominal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='nominal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('am',FALSE,0),('are',FALSE,1),('does',FALSE,2),('is',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-63746C66F169E0BCECCC',m.id,l.id,'Complete: She _____ every day. (verb: study)','hard','Subject ''She'' memerlukan bentuk Simple Present ''studies'' dari kata kerja ''study''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('studys',FALSE,0),('studyes',FALSE,1),('studies',TRUE,2),('study',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E2B85B05491F50545305',m.id,l.id,'Complete: He _____ on Mondays. (verb: watch)','medium','Subject ''He'' memerlukan bentuk Simple Present ''watches'' dari kata kerja ''watch''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('watching',FALSE,0),('watches',TRUE,1),('watch',FALSE,2),('watchs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-62DBCB25DCD569BC3FC5',m.id,l.id,'Complete: They _____ each morning. (verb: work)','easy','Subject ''They'' memerlukan bentuk Simple Present ''work'' dari kata kerja ''work''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('working',FALSE,0),('work',TRUE,1),('works',FALSE,2),('workes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E494B66C953FE6AE1071',m.id,l.id,'Complete: I _____ every evening. (verb: play)','medium','Subject ''I'' memerlukan bentuk Simple Present ''play'' dari kata kerja ''play''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('play',TRUE,0),('plays',FALSE,1),('playes',FALSE,2),('plaies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5EF4DD72912830371B05',m.id,l.id,'Complete: It _____ regularly. (verb: run)','easy','Subject ''It'' memerlukan bentuk Simple Present ''runs'' dari kata kerja ''run''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('runes',FALSE,0),('runing',FALSE,1),('runs',TRUE,2),('run',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9CFBBF572AB96EF4867E',m.id,l.id,'Complete: We _____ every day. (verb: go)','hard','Subject ''We'' memerlukan bentuk Simple Present ''go'' dari kata kerja ''go''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gos',FALSE,0),('goes',FALSE,1),('going',FALSE,2),('go',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-36B7B44B3403429398FA',m.id,l.id,'Complete: My brother _____ on Mondays. (verb: study)','medium','Subject ''My brother'' memerlukan bentuk Simple Present ''studies'' dari kata kerja ''study''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('study',FALSE,0),('studys',FALSE,1),('studyes',FALSE,2),('studies',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D34ACE5F9B8089A85673',m.id,l.id,'Complete: My parents _____ each morning. (verb: cook)','easy','Subject ''My parents'' memerlukan bentuk Simple Present ''cook'' dari kata kerja ''cook''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cooks',FALSE,0),('cookes',FALSE,1),('cooking',FALSE,2),('cook',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-089ED46068CDF6A50173',m.id,l.id,'Complete: The train _____ every evening. (verb: arrive)','easy','Subject ''The train'' memerlukan bentuk Simple Present ''arrives'' dari kata kerja ''arrive''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('arrives',TRUE,0),('arrive',FALSE,1),('arrivees',FALSE,2),('arriveing',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DC51AAEFF9AE724E74B2',m.id,l.id,'Complete: The children _____ regularly. (verb: read)','easy','Subject ''The children'' memerlukan bentuk Simple Present ''read'' dari kata kerja ''read''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('reads',FALSE,0),('reades',FALSE,1),('reading',FALSE,2),('read',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0721B55BDE8A6566B7FB',m.id,l.id,'Complete: You _____ every day. (verb: speak)','hard','Subject ''You'' memerlukan bentuk Simple Present ''speak'' dari kata kerja ''speak''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('speaks',FALSE,0),('speakes',FALSE,1),('speaking',FALSE,2),('speak',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-16DEC598C37F51EE7E0D',m.id,l.id,'Complete: Rina _____ on Mondays. (verb: teach)','hard','Subject ''Rina'' memerlukan bentuk Simple Present ''teaches'' dari kata kerja ''teach''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('teaches',TRUE,0),('teach',FALSE,1),('teachs',FALSE,2),('teaching',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D99A220B95C906286EBF',m.id,l.id,'Complete: The dog _____ each morning. (verb: bark)','easy','Subject ''The dog'' memerlukan bentuk Simple Present ''barks'' dari kata kerja ''bark''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('bark',FALSE,0),('barkes',FALSE,1),('barking',FALSE,2),('barks',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F21A2585C46C5BE5F729',m.id,l.id,'Complete: He _____ every evening. (verb: fix)','easy','Subject ''He'' memerlukan bentuk Simple Present ''fixes'' dari kata kerja ''fix''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fixing',FALSE,0),('fixes',TRUE,1),('fix',FALSE,2),('fixs',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BBEAB55338CCCC8618B8',m.id,l.id,'Complete: They _____ regularly. (verb: wash)','medium','Subject ''They'' memerlukan bentuk Simple Present ''wash'' dari kata kerja ''wash''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('washs',FALSE,0),('washes',FALSE,1),('washing',FALSE,2),('wash',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B4F53A0567A398A0603',m.id,l.id,'Complete: She _____ every day. (verb: have)','medium','Subject ''She'' memerlukan bentuk Simple Present ''has'' dari kata kerja ''have''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('has',TRUE,0),('have',FALSE,1),('haves',FALSE,2),('havees',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5EB70E8E8608D05C41A7',m.id,l.id,'Complete: I _____ on Mondays. (verb: have)','medium','Subject ''I'' memerlukan bentuk Simple Present ''have'' dari kata kerja ''have''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('havees',FALSE,0),('haveing',FALSE,1),('have',TRUE,2),('haves',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5D205BCE6E9140C88B2E',m.id,l.id,'Complete: My uncle _____ each morning. (verb: drive)','easy','Subject ''My uncle'' memerlukan bentuk Simple Present ''drives'' dari kata kerja ''drive''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('drivees',FALSE,0),('driveing',FALSE,1),('drives',TRUE,2),('drive',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-87B090B8501E4147F3C6',m.id,l.id,'Complete: Those birds _____ every evening. (verb: fly)','easy','Subject ''Those birds'' memerlukan bentuk Simple Present ''fly'' dari kata kerja ''fly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fly',TRUE,0),('flys',FALSE,1),('flyes',FALSE,2),('flies',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3005397F7E5E0D02CE71',m.id,l.id,'Complete: The baby _____ regularly. (verb: cry)','medium','Subject ''The baby'' memerlukan bentuk Simple Present ''cries'' dari kata kerja ''cry''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cry',FALSE,0),('crys',FALSE,1),('cryes',FALSE,2),('cries',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-85FD1D1521E29D5D7241',m.id,l.id,'Complete: The teacher _____ every day. (verb: explain)','hard','Subject ''The teacher'' memerlukan bentuk Simple Present ''explains'' dari kata kerja ''explain''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('explaining',FALSE,0),('explains',TRUE,1),('explain',FALSE,2),('explaines',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-244B288137739207EC10',m.id,l.id,'Complete: We _____ on Mondays. (verb: visit)','hard','Subject ''We'' memerlukan bentuk Simple Present ''visit'' dari kata kerja ''visit''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('visiting',FALSE,0),('visit',TRUE,1),('visits',FALSE,2),('visites',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D8F4FBA073E567C09932',m.id,l.id,'Complete: She _____ each morning. (verb: carry)','easy','Subject ''She'' memerlukan bentuk Simple Present ''carries'' dari kata kerja ''carry''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carries',TRUE,0),('carry',FALSE,1),('carrys',FALSE,2),('carryes',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EC711BCD7C18EC354259',m.id,l.id,'Complete: He _____ every evening. (verb: do)','hard','Subject ''He'' memerlukan bentuk Simple Present ''does'' dari kata kerja ''do''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('doing',FALSE,0),('does',TRUE,1),('do',FALSE,2),('dos',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E373A345EF0FB2187D85',m.id,l.id,'Complete: The shop _____ regularly. (verb: close)','easy','Subject ''The shop'' memerlukan bentuk Simple Present ''closes'' dari kata kerja ''close''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='verbal-simple-present' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('closeing',FALSE,0),('closes',TRUE,1),('close',FALSE,2),('closees',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-067191CB0ED8226E59E2',m.id,l.id,'Choose the correct auxiliary for the question: _____ she play football?','hard','Pertanyaan verbal Simple Present dengan subjek ''she'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',FALSE,0),('is',FALSE,1),('are',FALSE,2),('does',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A19FCD99926D41C65AB',m.id,l.id,'Choose the correct auxiliary for the question: _____ he work here?','hard','Pertanyaan verbal Simple Present dengan subjek ''he'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',TRUE,1),('do',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E82E13B986B8F935D3EC',m.id,l.id,'Choose the correct auxiliary for the question: _____ it study English?','hard','Pertanyaan verbal Simple Present dengan subjek ''it'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',TRUE,1),('do',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D0D1008A981BE01F4C6E',m.id,l.id,'Choose the correct auxiliary for the question: _____ they speak Spanish?','hard','Pertanyaan verbal Simple Present dengan subjek ''they'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('are',FALSE,1),('do',TRUE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E1B7945B9FD56974D55',m.id,l.id,'Choose the correct auxiliary for the question: _____ we live nearby?','easy','Pertanyaan verbal Simple Present dengan subjek ''we'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('do',TRUE,1),('does',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D95BB262A7C229D12CE4',m.id,l.id,'Choose the correct auxiliary for the question: _____ you play football?','hard','Pertanyaan verbal Simple Present dengan subjek ''you'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('are',FALSE,1),('do',TRUE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-14F2B5EC5B1741B72B81',m.id,l.id,'Choose the correct auxiliary for the question: _____ I work here?','hard','Pertanyaan verbal Simple Present dengan subjek ''I'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F92DC7EFE30C347F752D',m.id,l.id,'Choose the correct auxiliary for the question: _____ your sister study English?','medium','Pertanyaan verbal Simple Present dengan subjek ''your sister'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',FALSE,0),('is',FALSE,1),('are',FALSE,2),('does',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FE97B7ACEA0BEA01358D',m.id,l.id,'Choose the correct auxiliary for the question: _____ your brothers speak Spanish?','easy','Pertanyaan verbal Simple Present dengan subjek ''your brothers'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-06262C2ABBCE347E9B6A',m.id,l.id,'Choose the correct auxiliary for the question: _____ the teacher live nearby?','medium','Pertanyaan verbal Simple Present dengan subjek ''the teacher'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('are',FALSE,1),('does',TRUE,2),('do',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-95092C8427F4CBDA68D4',m.id,l.id,'Choose the correct auxiliary for the question: _____ the students play football?','hard','Pertanyaan verbal Simple Present dengan subjek ''the students'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A47DF4497D9017F201D4',m.id,l.id,'Choose the correct auxiliary for the question: _____ your parents work here?','easy','Pertanyaan verbal Simple Present dengan subjek ''your parents'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('do',TRUE,1),('does',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AF2F35C3EF0D39CEFCE4',m.id,l.id,'Choose the correct auxiliary for the question: _____ the bus study English?','hard','Pertanyaan verbal Simple Present dengan subjek ''the bus'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',FALSE,0),('is',FALSE,1),('are',FALSE,2),('does',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E2A45A09B9F40602DBBA',m.id,l.id,'Choose the correct auxiliary for the question: _____ your friend speak Spanish?','hard','Pertanyaan verbal Simple Present dengan subjek ''your friend'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',TRUE,1),('do',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-908286F1D598FCFA2557',m.id,l.id,'Choose the correct auxiliary for the question: _____ those children live nearby?','easy','Pertanyaan verbal Simple Present dengan subjek ''those children'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('do',TRUE,1),('does',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6D3A2D100C6932239B83',m.id,l.id,'Choose the correct auxiliary for the question: _____ that boy play football?','medium','Pertanyaan verbal Simple Present dengan subjek ''that boy'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',TRUE,0),('do',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FEDBE6C022BAC0EDA606',m.id,l.id,'Choose the correct auxiliary for the question: _____ your classmates work here?','medium','Pertanyaan verbal Simple Present dengan subjek ''your classmates'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-48D27C5E84426F1FA6F4',m.id,l.id,'Choose the correct auxiliary for the question: _____ the cats study English?','medium','Pertanyaan verbal Simple Present dengan subjek ''the cats'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('is',FALSE,0),('are',FALSE,1),('do',TRUE,2),('does',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-88770C2D9B0D8F69D114',m.id,l.id,'Choose the correct auxiliary for the question: _____ your mother speak Spanish?','hard','Pertanyaan verbal Simple Present dengan subjek ''your mother'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('are',FALSE,0),('does',TRUE,1),('do',FALSE,2),('is',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1981F1A328A7C582EB13',m.id,l.id,'Choose the correct auxiliary for the question: _____ the girl live nearby?','easy','Pertanyaan verbal Simple Present dengan subjek ''the girl'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',FALSE,0),('is',FALSE,1),('are',FALSE,2),('does',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6AC5A7142C4F65F20FCF',m.id,l.id,'Choose the correct auxiliary for the question: _____ your father play football?','medium','Pertanyaan verbal Simple Present dengan subjek ''your father'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',TRUE,0),('do',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A55B222407AB795A9954',m.id,l.id,'Choose the correct auxiliary for the question: _____ both teachers work here?','hard','Pertanyaan verbal Simple Present dengan subjek ''both teachers'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E1D77C97E142BBC8E839',m.id,l.id,'Choose the correct auxiliary for the question: _____ this laptop study English?','easy','Pertanyaan verbal Simple Present dengan subjek ''this laptop'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',FALSE,0),('is',FALSE,1),('are',FALSE,2),('does',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8625BF24BDB21968538B',m.id,l.id,'Choose the correct auxiliary for the question: _____ these phones speak Spanish?','medium','Pertanyaan verbal Simple Present dengan subjek ''these phones'' memakai auxiliary ''do'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('do',TRUE,0),('does',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-32C1C9E0E75FD1E4617B',m.id,l.id,'Choose the correct auxiliary for the question: _____ the driver live nearby?','medium','Pertanyaan verbal Simple Present dengan subjek ''the driver'' memakai auxiliary ''does'' dan verb dasar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='do-does' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('does',TRUE,0),('do',FALSE,1),('is',FALSE,2),('are',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AE310C25197C28ED2D68',m.id,l.id,'Choose the normal placement of "always" in the sentence: She arrives on time.','easy','Dalam gaya netral, ''always'' lazim ditempatkan sebelum main verb: ''She always arrives...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('She always is arrives on time.',FALSE,0),('She always arrives on time.',TRUE,1),('She arrives on time always.',FALSE,2),('She arrives always on time.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-90AA92523F1F77C405F3',m.id,l.id,'Choose the normal placement of "usually" in the sentence: They eat breakfast.','medium','Dalam gaya netral, ''usually'' lazim ditempatkan sebelum main verb: ''They usually eat...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('They eat usually breakfast.',FALSE,0),('They usually is eat breakfast.',FALSE,1),('They usually eat breakfast.',TRUE,2),('They eat breakfast usually.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E5CD2EFCEBCB5DC18AB7',m.id,l.id,'Choose the normal placement of "often" in the sentence: My brother plays football.','medium','Dalam gaya netral, ''often'' lazim ditempatkan sebelum main verb: ''My brother often plays...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My brother often plays football.',TRUE,0),('My brother plays football often.',FALSE,1),('My brother plays often football.',FALSE,2),('My brother often is plays football.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-726866466CEA347651BE',m.id,l.id,'Choose the normal placement of "sometimes" in the sentence: We visit our grandparents.','hard','Dalam gaya netral, ''sometimes'' lazim ditempatkan sebelum main verb: ''We sometimes visit...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('We visit sometimes our grandparents.',FALSE,0),('We sometimes is visit our grandparents.',FALSE,1),('We sometimes visit our grandparents.',TRUE,2),('We visit our grandparents sometimes.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-997C9694CE749CBEDB98',m.id,l.id,'Choose the normal placement of "rarely" in the sentence: He drinks coffee.','hard','Dalam gaya netral, ''rarely'' lazim ditempatkan sebelum main verb: ''He rarely drinks...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('He rarely drinks coffee.',TRUE,0),('He drinks coffee rarely.',FALSE,1),('He drinks rarely coffee.',FALSE,2),('He rarely is drinks coffee.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C1925BE1304C79AF49F3',m.id,l.id,'Choose the normal placement of "never" in the sentence: I smoke.','easy','Dalam gaya netral, ''never'' lazim ditempatkan sebelum main verb: ''I never smoke...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I never is smoke.',FALSE,0),('I never smoke.',TRUE,1),('I smoke never.',FALSE,2),('I smoke never .',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AD25B13C9196F371710E',m.id,l.id,'Choose the normal placement of "always" in the sentence: The children do their homework.','easy','Dalam gaya netral, ''always'' lazim ditempatkan sebelum main verb: ''The children always do...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('The children always do their homework.',TRUE,0),('The children do their homework always.',FALSE,1),('The children do always their homework.',FALSE,2),('The children always is do their homework.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2432737D74BD0D7AA4B0',m.id,l.id,'Choose the normal placement of "usually" in the sentence: Rina studies at night.','hard','Dalam gaya netral, ''usually'' lazim ditempatkan sebelum main verb: ''Rina usually studies...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Rina usually is studies at night.',FALSE,0),('Rina usually studies at night.',TRUE,1),('Rina studies at night usually.',FALSE,2),('Rina studies usually at night.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F92D3743B4CEB396A649',m.id,l.id,'Choose the normal placement of "often" in the sentence: You help your friends.','medium','Dalam gaya netral, ''often'' lazim ditempatkan sebelum main verb: ''You often help...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('You help your friends often.',FALSE,0),('You help often your friends.',FALSE,1),('You often is help your friends.',FALSE,2),('You often help your friends.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91453DFFFCBDC34BA837',m.id,l.id,'Choose the normal placement of "sometimes" in the sentence: My father watches TV.','easy','Dalam gaya netral, ''sometimes'' lazim ditempatkan sebelum main verb: ''My father sometimes watches...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My father watches TV sometimes.',FALSE,0),('My father watches sometimes TV.',FALSE,1),('My father sometimes is watches TV.',FALSE,2),('My father sometimes watches TV.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BFAAEF0B57D5733917FE',m.id,l.id,'Choose the normal placement of "rarely" in the sentence: Our teacher arrives late.','medium','Dalam gaya netral, ''rarely'' lazim ditempatkan sebelum main verb: ''Our teacher rarely arrives...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Our teacher arrives late rarely.',FALSE,0),('Our teacher arrives rarely late.',FALSE,1),('Our teacher rarely is arrives late.',FALSE,2),('Our teacher rarely arrives late.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B7D82E573B7E5A341C87',m.id,l.id,'Choose the normal placement of "never" in the sentence: They skip breakfast.','easy','Dalam gaya netral, ''never'' lazim ditempatkan sebelum main verb: ''They never skip...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('They skip breakfast never.',FALSE,0),('They skip never breakfast.',FALSE,1),('They never is skip breakfast.',FALSE,2),('They never skip breakfast.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-34678676E1BFCC23955B',m.id,l.id,'Choose the normal placement of "often" in the sentence: She reads books.','medium','Dalam gaya netral, ''often'' lazim ditempatkan sebelum main verb: ''She often reads...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('She reads often books.',FALSE,0),('She often is reads books.',FALSE,1),('She often reads books.',TRUE,2),('She reads books often.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D7A0EE563B29E66451A3',m.id,l.id,'Choose the normal placement of "usually" in the sentence: We meet on Fridays.','medium','Dalam gaya netral, ''usually'' lazim ditempatkan sebelum main verb: ''We usually meet...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('We meet usually on Fridays.',FALSE,0),('We usually is meet on Fridays.',FALSE,1),('We usually meet on Fridays.',TRUE,2),('We meet on Fridays usually.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9F1A5022B90AB085EF1',m.id,l.id,'Choose the normal placement of "always" in the sentence: He checks his email.','easy','Dalam gaya netral, ''always'' lazim ditempatkan sebelum main verb: ''He always checks...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('He checks always his email.',FALSE,0),('He always is checks his email.',FALSE,1),('He always checks his email.',TRUE,2),('He checks his email always.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9CB4404EC763397B1E3D',m.id,l.id,'Choose the normal placement of "sometimes" in the sentence: I cook dinner.','medium','Dalam gaya netral, ''sometimes'' lazim ditempatkan sebelum main verb: ''I sometimes cook...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I cook sometimes dinner.',FALSE,0),('I sometimes is cook dinner.',FALSE,1),('I sometimes cook dinner.',TRUE,2),('I cook dinner sometimes.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E1A39838B51D57AA572B',m.id,l.id,'Choose the normal placement of "never" in the sentence: The students cheat.','hard','Dalam gaya netral, ''never'' lazim ditempatkan sebelum main verb: ''The students never cheat...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('The students never cheat.',TRUE,0),('The students cheat never.',FALSE,1),('The students cheat never .',FALSE,2),('The students never is cheat.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3C5BCD4BF82222E0DB9F',m.id,l.id,'Choose the normal placement of "rarely" in the sentence: My sister takes a taxi.','easy','Dalam gaya netral, ''rarely'' lazim ditempatkan sebelum main verb: ''My sister rarely takes...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My sister takes a taxi rarely.',FALSE,0),('My sister takes rarely a taxi.',FALSE,1),('My sister rarely is takes a taxi.',FALSE,2),('My sister rarely takes a taxi.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9FB4727AB7C1882ECB3C',m.id,l.id,'Choose the normal placement of "often" in the sentence: My friends go hiking.','easy','Dalam gaya netral, ''often'' lazim ditempatkan sebelum main verb: ''My friends often go...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('My friends go often hiking.',FALSE,0),('My friends often is go hiking.',FALSE,1),('My friends often go hiking.',TRUE,2),('My friends go hiking often.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F92A9FE0A1C7156FF11E',m.id,l.id,'Choose the normal placement of "usually" in the sentence: You start early.','easy','Dalam gaya netral, ''usually'' lazim ditempatkan sebelum main verb: ''You usually start...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('You usually start early.',TRUE,0),('You start early usually.',FALSE,1),('You start usually early.',FALSE,2),('You usually is start early.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-498A952E3D518932C43F',m.id,l.id,'Choose the normal placement of "always" in the sentence: We brush our teeth.','hard','Dalam gaya netral, ''always'' lazim ditempatkan sebelum main verb: ''We always brush...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('We brush always our teeth.',FALSE,0),('We always is brush our teeth.',FALSE,1),('We always brush our teeth.',TRUE,2),('We brush our teeth always.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2FFFBAEC5F2296D7C3E6',m.id,l.id,'Choose the normal placement of "never" in the sentence: He drives fast.','hard','Dalam gaya netral, ''never'' lazim ditempatkan sebelum main verb: ''He never drives...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('He never drives fast.',TRUE,0),('He drives fast never.',FALSE,1),('He drives never fast.',FALSE,2),('He never is drives fast.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5DC7841B8ED9E67351A1',m.id,l.id,'Choose the normal placement of "sometimes" in the sentence: They play chess.','hard','Dalam gaya netral, ''sometimes'' lazim ditempatkan sebelum main verb: ''They sometimes play...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('They play chess sometimes.',FALSE,0),('They play sometimes chess.',FALSE,1),('They sometimes is play chess.',FALSE,2),('They sometimes play chess.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C5C5859F877B6769CC63',m.id,l.id,'Choose the normal placement of "rarely" in the sentence: She eats dessert.','medium','Dalam gaya netral, ''rarely'' lazim ditempatkan sebelum main verb: ''She rarely eats...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('She eats dessert rarely.',FALSE,0),('She eats rarely dessert.',FALSE,1),('She rarely is eats dessert.',FALSE,2),('She rarely eats dessert.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6E249017B991DFD1AFC3',m.id,l.id,'Choose the normal placement of "often" in the sentence: I study English.','easy','Dalam gaya netral, ''often'' lazim ditempatkan sebelum main verb: ''I often study...''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='frequency-adverbs' WHERE m.slug='simple-present'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('I study English often.',FALSE,0),('I study often English.',FALSE,1),('I often is study English.',FALSE,2),('I often study English.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B0C2566C7190587AEA5',m.id,l.id,'The keys are _____ the drawer. (inside)','medium','In digunakan untuk sesuatu di dalam wadah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('over',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E703F041336F902EB68E',m.id,l.id,'The notebook is _____ the table. (touching the surface)','medium','On menunjukkan posisi menempel permukaan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',FALSE,0),('on',TRUE,1),('in',FALSE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9142A87797F908557C71',m.id,l.id,'The cat is _____ the bed. (below it)','medium','Under menandakan lokasi di bawah benda lain.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('over',FALSE,0),('above',FALSE,1),('beside',FALSE,2),('under',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F3A94B75C9C436C0095',m.id,l.id,'The bakery is _____ the bank and the library.','easy','Between menyatakan posisi di antara dua lokasi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('through',FALSE,1),('into',FALSE,2),('between',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9A15E7F24526E916BB84',m.id,l.id,'She stood _____ a group of students.','hard','Among menunjukkan berada di tengah kelompok.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('onto',FALSE,1),('among',TRUE,2),('between',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F5A6BEA17040F683ED4B',m.id,l.id,'The bus stop is _____ the school. (directly across the street)','medium','Opposite berarti tepat berhadapan/di seberang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('opposite',TRUE,1),('inside',FALSE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-93B7C3E4FE8E25CA757E',m.id,l.id,'Sit _____ me. (immediately at my side)','hard','Beside berarti di samping.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beside',TRUE,0),('inside',FALSE,1),('across',FALSE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F8E789DD5544DFAAC43F',m.id,l.id,'The picture is hanging _____ the wall.','easy','On dipakai untuk gambar yang menempel dinding.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',FALSE,0),('on',TRUE,1),('in',FALSE,2),('beneath',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D85535CAE15388D5F8C0',m.id,l.id,'The plane is flying _____ the clouds. (higher than them)','easy','Above menunjukkan posisi lebih tinggi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('inside',FALSE,0),('between',FALSE,1),('above',TRUE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F7ECC07F8CCD1E590990',m.id,l.id,'The shoes are _____ the door. (on the back side)','hard','Behind berarti di belakang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('before',FALSE,0),('above',FALSE,1),('on',FALSE,2),('behind',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DAA2EB76A62036CB023F',m.id,l.id,'There is a small shop _____ my house. (close to it)','hard','Near menunjukkan jarak dekat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('across',FALSE,0),('through',FALSE,1),('near',TRUE,2),('into',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8D38A4705FE08C6E530E',m.id,l.id,'The pen is _____ the bag. (within it)','hard','Inside berarti di dalam.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('inside',TRUE,0),('over',FALSE,1),('above',FALSE,2),('beside',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-259BDE9C0B4DC7DE91A0',m.id,l.id,'The dog is sleeping _____ the tree. (beneath its branches)','hard','Under menunjukkan posisi di bawah pohon.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',TRUE,0),('over',FALSE,1),('above',FALSE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C671B98939F98C9B3BC8',m.id,l.id,'The lamp is _____ the desk. (fixed on its surface)','medium','On untuk permukaan meja.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('through',FALSE,0),('on',TRUE,1),('in',FALSE,2),('around',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73601D2417D2E32A5C23',m.id,l.id,'The school is _____ the hospital and the post office.','medium','Between untuk posisi di tengah dua tempat tertentu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',TRUE,0),('among',FALSE,1),('behind',FALSE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F93B1973873C304B6606',m.id,l.id,'The teacher is standing _____ the class. (at the front)','easy','In front of berarti berada di depan kelas.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('behind',FALSE,0),('under',FALSE,1),('inside',FALSE,2),('in front of',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F70F0D7A07739D18D29',m.id,l.id,'The river flows _____ the village. (in the space all around its edges)','hard','Around menyatakan mengelilingi sesuatu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('inside',FALSE,0),('under',FALSE,1),('through',FALSE,2),('around',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6EE02AE0B368C7951D33',m.id,l.id,'A bridge is _____ the river. (spanning it)','medium','Over dapat bermakna melintang di atas sungai.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('over',TRUE,0),('into',FALSE,1),('inside',FALSE,2),('beneath',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C415AEB95CDFF1A7792A',m.id,l.id,'The children are sitting _____ the floor.','easy','On menunjukkan kontak dengan permukaan lantai.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',FALSE,0),('on',TRUE,1),('under',FALSE,2),('above',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28AF3793F841B4CD3835',m.id,l.id,'The restaurant is _____ the cinema. (right next to it)','hard','Next to berarti tepat di samping.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('through',FALSE,0),('along',FALSE,1),('into',FALSE,2),('next to',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-817124D3AB0EDA93C89F',m.id,l.id,'The dog hid _____ the sofa. (at its back)','medium','Behind menunjukkan sisi belakang sofa.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('before',FALSE,0),('above',FALSE,1),('inside',FALSE,2),('behind',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2BC51F2B4C41726EC5DE',m.id,l.id,'The bus is waiting _____ the station. (specific location)','hard','At digunakan untuk titik lokasi tertentu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('into',FALSE,1),('through',FALSE,2),('at',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8F4204F66507817F8487',m.id,l.id,'The family lives _____ Jakarta. (within the city)','medium','In digunakan untuk kota sebagai wilayah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('through',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8E47E7D9F5F9EBB45BEE',m.id,l.id,'A clock hangs _____ the doorway. (higher than it)','easy','Above berarti lebih tinggi dari pintu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',FALSE,0),('above',TRUE,1),('under',FALSE,2),('inside',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-53EC242AE2923CC3DDC9',m.id,l.id,'The shop is _____ the corner of the street. (located there)','easy','On the corner menyebut posisi toko di sudut jalan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='place-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',FALSE,0),('into',FALSE,1),('on',TRUE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-931EFE90D02D0EB9B9D6',m.id,l.id,'Complete the time expression: Our meeting takes place _____ 7 a.m..','hard','''7 a.m.'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',TRUE,0),('in',FALSE,1),('on',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CE253571083D8FFD42F8',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Monday.','easy','''Monday'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('on',TRUE,1),('in',FALSE,2),('at',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-33F075A2D21AAA352E9F',m.id,l.id,'Complete the time expression: Our meeting takes place _____ March.','easy','''March'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BC9DF4D6831EB39693FB',m.id,l.id,'Complete the time expression: Our meeting takes place _____ 2026.','medium','''2026'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B47665962E0B1CD0CE39',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Friday evening.','hard','''Friday evening'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('on',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-60DC6F310CD699635799',m.id,l.id,'Complete the time expression: Our meeting takes place _____ noon.','medium','''noon'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('at',TRUE,1),('in',FALSE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E5F27D86F8EC1EA402A',m.id,l.id,'Complete the time expression: Our meeting takes place _____ midnight.','hard','''midnight'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',TRUE,0),('in',FALSE,1),('on',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F3F1013272648DAF9825',m.id,l.id,'Complete the time expression: Our meeting takes place _____ July 4th.','hard','''July 4th'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('on',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6AAADA824AB5AB4F41C8',m.id,l.id,'Complete the time expression: Our meeting takes place _____ winter.','medium','''winter'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-37A2287F94F0E0C57F56',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Sunday.','hard','''Sunday'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DA72851C93C894D7F75F',m.id,l.id,'Complete the time expression: Our meeting takes place _____ the morning.','hard','''the morning'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4171F5EF4E69C56A8202',m.id,l.id,'Complete the time expression: Our meeting takes place _____ the evening.','easy','''the evening'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('at',FALSE,1),('for',FALSE,2),('in',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EFBA14A7801BAAD9CCC9',m.id,l.id,'Complete the time expression: Our meeting takes place _____ night.','hard','''night'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('on',FALSE,1),('for',FALSE,2),('at',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F902358C1316E59B8E2F',m.id,l.id,'Complete the time expression: Our meeting takes place _____ my birthday.','hard','''my birthday'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-24D86BD0BCAA58F032B0',m.id,l.id,'Complete the time expression: Our meeting takes place _____ September.','hard','''September'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-89066EF269E9807E9F54',m.id,l.id,'Complete the time expression: Our meeting takes place _____ the afternoon.','medium','''the afternoon'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-676257796E521E056F85',m.id,l.id,'Complete the time expression: Our meeting takes place _____ 12:30 p.m..','hard','''12:30 p.m.'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('at',TRUE,1),('in',FALSE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-675FF764FF5743BF7F6F',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Christmas Day.','easy','''Christmas Day'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-40B54B24D63D9F9A8BE0',m.id,l.id,'Complete the time expression: Our meeting takes place _____ 1997.','easy','''1997'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',TRUE,0),('on',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8015C4C8F6152BEA3B03',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Saturday morning.','medium','''Saturday morning'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-91838372703DDE3BCB65',m.id,l.id,'Complete the time expression: Our meeting takes place _____ spring.','medium','''spring'' dalam konteks ini memakai preposition ''in''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('for',FALSE,1),('in',TRUE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-93A26DE8F4D288BCEB2A',m.id,l.id,'Complete the time expression: Our meeting takes place _____ the weekend (British English).','medium','''the weekend (British English)'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',TRUE,0),('in',FALSE,1),('on',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8BCF790BA058D77B9DBE',m.id,l.id,'Complete the time expression: Our meeting takes place _____ Thursday.','medium','''Thursday'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('at',FALSE,1),('for',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-82702F2AFE44B0B744F2',m.id,l.id,'Complete the time expression: Our meeting takes place _____ 8 o’clock.','easy','''8 o’clock'' dalam konteks ini memakai preposition ''at''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('for',FALSE,1),('at',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B7E2DEE06F2AD5A1DD77',m.id,l.id,'Complete the time expression: Our meeting takes place _____ October 18th.','hard','''October 18th'' dalam konteks ini memakai preposition ''on''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',TRUE,0),('in',FALSE,1),('at',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-25FD86C4CCEF869A4C11',m.id,l.id,'Please go _____ the station. (destination)','hard','To menunjukkan tujuan perjalanan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('to',TRUE,0),('into',FALSE,1),('through',FALSE,2),('from',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28E65F5DF399C5EBA751',m.id,l.id,'They travelled _____ Jakarta to Bali.','easy','From menunjukkan titik asal perjalanan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('from',TRUE,1),('into',FALSE,2),('on',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-12861F87D6B5163F8D87',m.id,l.id,'The child walked _____ the classroom from the corridor.','easy','Into menunjukkan perpindahan ke dalam ruangan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('at',FALSE,1),('under',FALSE,2),('into',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BED004EB82CA3725F32',m.id,l.id,'We drove _____ a long tunnel. (through its interior)','medium','Through berarti melintasi bagian dalam.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('over',FALSE,0),('along',FALSE,1),('through',TRUE,2),('across',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B132DB49F55BD656F62E',m.id,l.id,'Walk _____ the street carefully. (from one side to the other)','easy','Across menunjukkan menyeberangi jalan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('through',FALSE,0),('across',TRUE,1),('along',FALSE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B253219D06368DA15E68',m.id,l.id,'We walked _____ the beach for an hour. (following its length)','hard','Along berarti mengikuti jalur memanjang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('across',FALSE,0),('along',TRUE,1),('into',FALSE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DD8829AEFEAA909A831A',m.id,l.id,'The boy jumped _____ the pool. (entering the water)','hard','Into dipakai untuk gerakan masuk ke air.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',FALSE,0),('from',FALSE,1),('into',TRUE,2),('in',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-61B85263D1BD92E5CE81',m.id,l.id,'She stepped _____ the car. (exiting)','hard','Out of menunjukkan keluar dari kendaraan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('into',FALSE,0),('through',FALSE,1),('over',FALSE,2),('out of',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-688EEBAB27C14C0DFC2E',m.id,l.id,'Go _____ the bridge to reach the town. (from one end to the other)','easy','Across menggambarkan menyeberangi jembatan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('into',FALSE,1),('on top of',FALSE,2),('across',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5896DAA691FA16150396',m.id,l.id,'The tourists walked _____ the museum. (moving inside it)','easy','Through menunjukkan gerakan melintasi bagian dalam.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('across',FALSE,0),('onto',FALSE,1),('through',TRUE,2),('above',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73A51F5FD67A86152840',m.id,l.id,'Please move _____ the exit. (in that direction)','hard','Towards bermakna menuju arah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('from',FALSE,0),('under',FALSE,1),('inside',FALSE,2),('towards',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CCD75B06B2B170B7E987',m.id,l.id,'He ran _____ the stairs to the second floor.','hard','Up menunjukkan gerakan ke atas tangga.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('into',FALSE,0),('across',FALSE,1),('up',TRUE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F17016F3D160FEDF3E32',m.id,l.id,'She walked _____ the stairs to the lobby.','hard','Down berarti bergerak turun.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('over',FALSE,0),('across',FALSE,1),('onto',FALSE,2),('down',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D8ECD70592396ADF3DFF',m.id,l.id,'The cat leapt _____ the table. (ending on its surface)','medium','Onto menyatakan gerakan ke atas permukaan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('from',FALSE,0),('onto',TRUE,1),('into',FALSE,2),('out of',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B42FBFC6A8A57E545968',m.id,l.id,'The cyclist rode _____ the park. (from one side to the other inside it)','easy','Through menunjukkan melintasi interior taman.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('onto',FALSE,0),('off',FALSE,1),('through',TRUE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DB8E6F96C2D22B1B9836',m.id,l.id,'The bus came _____ the garage. (starting point)','easy','From menunjukkan asal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('onto',FALSE,0),('throughout',FALSE,1),('from',TRUE,2),('into',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CED46111AB6216C8EF08',m.id,l.id,'We walked _____ the road to the other side.','hard','Across berarti menyeberang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beside',FALSE,0),('across',TRUE,1),('along',FALSE,2),('down',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-46276B92B489341CFC83',m.id,l.id,'They travelled _____ the river by boat. (following its length)','medium','Along menunjukkan gerakan sejajar jalur sungai.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('into',FALSE,0),('onto',FALSE,1),('along',TRUE,2),('under',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6DAB4018CACCCE5A16DD',m.id,l.id,'The bird flew _____ the open window. (entering the house)','easy','Through cocok ketika melewati sebuah bukaan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('through',TRUE,0),('onto',FALSE,1),('under',FALSE,2),('across from',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-97CBDCD8344CC6027EB3',m.id,l.id,'The driver turned _____ the main road. (entering it)','medium','Turn onto berarti berbelok dan masuk ke jalan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('onto',TRUE,0),('under',FALSE,1),('inside',FALSE,2),('across',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6D48406D5212A03AA0AA',m.id,l.id,'The children walked _____ the playground gate. (entering)','easy','Through untuk melewati pintu atau gerbang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('off',FALSE,0),('through',TRUE,1),('over',FALSE,2),('beneath',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F496325E65DBB1C461B3',m.id,l.id,'She walked _____ the room when the meeting ended.','easy','Out of menunjukkan gerakan keluar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('onto',FALSE,0),('throughout',FALSE,1),('out of',TRUE,2),('into',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D342616A9CEEA91A6EDB',m.id,l.id,'Please come _____ my office after lunch.','medium','To menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('under',FALSE,1),('to',TRUE,2),('from',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DA7AADF58CF10D8596E6',m.id,l.id,'The plane flew _____ the mountain. (higher than it)','hard','Over menyatakan melintas di atas gunung.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('over',TRUE,1),('into',FALSE,2),('across',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D49EFC62D3386AD81DBE',m.id,l.id,'After class, I go _____.','medium','Go home memakai home sebagai kata keterangan arah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='movement-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('into home',FALSE,0),('at home',FALSE,1),('home',TRUE,2),('to home',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-76438101D7575469D2B9',m.id,l.id,'I studied English _____ two hours yesterday.','hard','For diikuti durasi dua jam.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',FALSE,0),('for',TRUE,1),('since',FALSE,2),('during',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A3243FEB32453D92911',m.id,l.id,'She has lived here _____ 2020.','hard','Since diikuti titik awal tahun 2020.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',FALSE,0),('until',FALSE,1),('since',TRUE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F18DE92AA777E870B5D6',m.id,l.id,'Nobody spoke _____ the exam. (while the event took place)','easy','During diikuti suatu peristiwa.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('until',FALSE,1),('during',TRUE,2),('since',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-69321F799CB076AA4874',m.id,l.id,'The shop stays open _____ 9 p.m. (up to that time)','hard','Until menunjukkan batas akhir waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('until',TRUE,1),('since',FALSE,2),('during',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-48FDED89A8383F725B01',m.id,l.id,'He waited _____ thirty minutes.','hard','Thirty minutes adalah durasi, maka for.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',FALSE,0),('for',TRUE,1),('since',FALSE,2),('during',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-336869E38D1FB375F9ED',m.id,l.id,'They have known each other _____ Monday. (starting then)','easy','Monday sebagai titik awal memakai since.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('during',FALSE,1),('until',FALSE,2),('since',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DBFB8E04F4C028808457',m.id,l.id,'We met _____ the conference. (while it happened)','medium','During the conference adalah selama acara berlangsung.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',TRUE,0),('for',FALSE,1),('since',FALSE,2),('until',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C70A2BBF20D0D69E9520',m.id,l.id,'Stay here _____ I come back.','easy','Until diikuti klausa batas waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',FALSE,0),('for',FALSE,1),('since',FALSE,2),('until',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-54AE2DAA84F85A8D1351',m.id,l.id,'She worked there _____ five years.','hard','Five years adalah lama durasi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',FALSE,0),('until',FALSE,1),('for',TRUE,2),('since',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7886DCEE7C56483FA085',m.id,l.id,'We have been friends _____ childhood.','easy','Childhood menjadi titik awal hubungan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',FALSE,0),('until',FALSE,1),('since',TRUE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6CF8113E2F00F390931D',m.id,l.id,'The lights went out _____ the storm.','hard','During menunjukkan peristiwa saat badai.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('since',FALSE,0),('until',FALSE,1),('during',TRUE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-92F5B86472F11FFC89CE',m.id,l.id,'The library closes _____ six. (continuing open up to six)','hard','At digunakan untuk menunjuk waktu penutupan tepat pukul enam.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('at',TRUE,0),('since',FALSE,1),('during',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C4A8B166204CB1DAE5E3',m.id,l.id,'He has waited _____ 8 a.m. (starting at 8)','hard','Since menunjukkan waktu mulai.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('during',FALSE,0),('until',FALSE,1),('since',TRUE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8BBE50FCC0EE613ECC1A',m.id,l.id,'We talked _____ an hour.','medium','An hour merupakan durasi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',TRUE,0),('since',FALSE,1),('during',FALSE,2),('until',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E4C3C89B546AC8C7911',m.id,l.id,'She stayed silent _____ the interview.','hard','During + event: interview.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',FALSE,0),('during',TRUE,1),('since',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FCE4814F954D21C3C93A',m.id,l.id,'Please finish this report _____ Friday. (deadline, no later)','medium','By menunjukkan tenggat paling lambat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',FALSE,0),('for',FALSE,1),('since',FALSE,2),('by',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-23D10AA0CCDF279955B9',m.id,l.id,'The children played _____ the afternoon. (throughout that period)','medium','Throughout mengacu ke keseluruhan periode.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('throughout',TRUE,0),('since',FALSE,1),('until',FALSE,2),('by',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-11813631220026E03715',m.id,l.id,'I have been awake _____ midnight. (from that point)','hard','Since midnight menyatakan titik awal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',FALSE,0),('since',TRUE,1),('during',FALSE,2),('for',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F69801372BD1E48B4CF8',m.id,l.id,'She had no phone signal _____ the flight.','medium','During menunjukkan kejadian selama penerbangan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('since',FALSE,1),('until',FALSE,2),('during',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D54D379F82554E44ECA1',m.id,l.id,'He stayed with us _____ three days.','medium','For diikuti lama tiga hari.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('since',FALSE,0),('until',FALSE,1),('by',FALSE,2),('for',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C6D4365BA22C4907D2A3',m.id,l.id,'We have lived in Jakarta _____ 2019.','medium','Since diikuti tahun sebagai awal.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('for',FALSE,0),('during',FALSE,1),('until',FALSE,2),('since',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-65A14B2812C90892763F',m.id,l.id,'I will wait _____ you are ready.','medium','Until diikuti kondisi saat menunggu berakhir.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('until',TRUE,0),('during',FALSE,1),('for',FALSE,2),('since',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A79F8E1B1B036C168A9D',m.id,l.id,'The workers rested _____ the lunch break.','medium','During diikuti periode istirahat sebagai event.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('since',FALSE,0),('for',FALSE,1),('until',FALSE,2),('during',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9340D4B741714C1062D4',m.id,l.id,'The project continued _____ six months.','easy','For diikuti durasi enam bulan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('since',FALSE,0),('during',FALSE,1),('by',FALSE,2),('for',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B30F776484013DC7B48B',m.id,l.id,'You must arrive _____ 7 a.m. at the latest.','easy','By menyatakan batas waktu kedatangan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='duration-prepositions' WHERE m.slug='prepositions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('by',TRUE,0),('until',FALSE,1),('since',FALSE,2),('during',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C16017FA4BDEA62680D2',m.id,l.id,'Choose the connector expressing addition: She reads books, _____ she writes stories.','easy','''and'' dalam contoh ini menyatakan penambahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('so that',FALSE,1),('and',TRUE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FBC36D9D30B8575A5F7F',m.id,l.id,'Choose the connector expressing addition: I like tea, _____ I enjoy coffee.','medium','''and'' dalam contoh ini menyatakan penambahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',FALSE,0),('and',TRUE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CAF8518BF4BA700AA5B9',m.id,l.id,'Choose the connector expressing addition: The class studies grammar, _____ the class practices spelling.','easy','''and'' dalam contoh ini menyatakan penambahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('so that',FALSE,2),('and',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7739FE937C78AC8B0AAC',m.id,l.id,'Choose the connector expressing addition: The boy opened the door, _____ the girl entered.','easy','''and'' dalam contoh ini menyatakan penambahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('so that',FALSE,2),('and',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A1243D19716AA12364B0',m.id,l.id,'Choose the connector expressing addition: He cleaned the room, _____ he washed the dishes.','medium','''and'' dalam contoh ini menyatakan penambahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',FALSE,0),('and',TRUE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9D253DF18663317E9F6',m.id,l.id,'Choose the connector expressing reason: I stayed at home _____ I felt sick.','hard','''because'' dalam contoh ini menyatakan alasan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and',FALSE,0),('so',FALSE,1),('so that',FALSE,2),('because',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6600B9D7BDBC6349004D',m.id,l.id,'Choose the connector expressing reason: She was late _____ the bus broke down.','easy','''because'' dalam contoh ini menyatakan alasan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and',FALSE,0),('so',FALSE,1),('so that',FALSE,2),('because',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6B37FB025CC096208AC5',m.id,l.id,'Choose the connector expressing reason: We used an umbrella _____ it was raining.','medium','''because'' dalam contoh ini menyatakan alasan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('so that',FALSE,1),('because',TRUE,2),('and',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1C0D82908145B41B9C07',m.id,l.id,'Choose the connector expressing reason: He studied hard _____ he wanted to pass.','easy','''because'' dalam contoh ini menyatakan alasan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',TRUE,0),('and',FALSE,1),('so',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B5340F1365423A90CC4F',m.id,l.id,'Choose the connector expressing reason: They went inside _____ the weather was cold.','easy','''because'' dalam contoh ini menyatakan alasan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and',FALSE,0),('so',FALSE,1),('so that',FALSE,2),('because',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A093D57B0CE035AC9C0A',m.id,l.id,'Choose the connector expressing result: It rained heavily, _____ the match was cancelled.','hard','''so'' dalam contoh ini menyatakan akibat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and',FALSE,0),('because',FALSE,1),('so that',FALSE,2),('so',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-02818DD89B0D79EF8E13',m.id,l.id,'Choose the connector expressing result: She missed the bus, _____ she arrived late.','easy','''so'' dalam contoh ini menyatakan akibat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',TRUE,0),('and',FALSE,1),('because',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-681E4AB9B9994EF85D18',m.id,l.id,'Choose the connector expressing result: He trained every day, _____ he became stronger.','medium','''so'' dalam contoh ini menyatakan akibat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',FALSE,0),('so',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D9719F5AD5A563C67B91',m.id,l.id,'Choose the connector expressing result: The bag was too heavy, _____ I asked for help.','easy','''so'' dalam contoh ini menyatakan akibat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so that',FALSE,1),('so',TRUE,2),('and',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E13B4404D2CDB4225231',m.id,l.id,'Choose the connector expressing result: The shop was closed, _____ we returned home.','hard','''so'' dalam contoh ini menyatakan akibat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',TRUE,0),('and',FALSE,1),('because',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-17999A94D9E0B41C333D',m.id,l.id,'Choose the connector expressing purpose: Please speak slowly _____ everyone can understand you.','medium','''so that'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',TRUE,0),('and',FALSE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0570B7E46D7FF2D88E07',m.id,l.id,'Choose the connector expressing purpose: She saved money _____ she could buy a bike.','medium','''so that'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',TRUE,0),('and',FALSE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D885D4E49B2006040D8E',m.id,l.id,'Choose the connector expressing purpose: I wrote the address clearly _____ the driver could find us.','hard','''so that'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',TRUE,0),('and',FALSE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-83445B250117F88F78B4',m.id,l.id,'Choose the connector expressing purpose: He set an alarm _____ he would wake up early.','medium','''so that'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('so that',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D338F2681F9E987FC08',m.id,l.id,'Choose the connector expressing purpose: We brought water _____ we would not get thirsty.','hard','''so that'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('so that',TRUE,2),('and',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-79398C457F1F37FED770',m.id,l.id,'Choose an infinitive expression of purpose: She wakes up early _____ catch the bus.','hard','''in order to'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('in order to',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C979F05A3186D28DFDD5',m.id,l.id,'Choose an infinitive expression of purpose: I work hard _____ support my family.','easy','''in order to'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('in order to',TRUE,2),('and',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-42C68C39F93A186973B2',m.id,l.id,'Choose an infinitive expression of purpose: He studies vocabulary _____ improve his English.','medium','''in order to'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('in order to',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73DA95B97636A7C561CB',m.id,l.id,'Choose an infinitive expression of purpose: We exercise _____ stay healthy.','hard','''in order to'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('in order to',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7E7884C59807362527B2',m.id,l.id,'Choose an infinitive expression of purpose: They went to the station _____ buy tickets.','medium','''in order to'' dalam contoh ini menyatakan tujuan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='addition-reason' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('in order to',TRUE,1),('and',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58E60B77EF79DCA771AD',m.id,l.id,'Complete using a coordinating contrast word: The test was difficult, _____ I passed it.','easy','But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('and',FALSE,2),('but',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F92319FE0603110C3887',m.id,l.id,'Complete using a subordinating concession: _____ the test was difficult, I passed it.','hard','Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('But',FALSE,0),('Therefore',FALSE,1),('Although',TRUE,2),('However',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D3214D03FEA9F1CF5CC4',m.id,l.id,'Complete using a sentence-level transition: The test was difficult. _____, I passed it.','medium','However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Although',FALSE,0),('Because',FALSE,1),('But',FALSE,2),('However',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CE78850D01CC2DCD42B3',m.id,l.id,'Choose the stronger concession linker: _____ the test was difficult, I passed it.','hard','Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('In order to',FALSE,0),('Even though',TRUE,1),('So that',FALSE,2),('Because of',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C2843BE546FF3BFD4D61',m.id,l.id,'Complete using a coordinating contrast word: She is young, _____ she is very experienced.','medium','But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and',FALSE,0),('but',TRUE,1),('because',FALSE,2),('so',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C112C4C9D19136502207',m.id,l.id,'Complete using a subordinating concession: _____ she is young, she is very experienced.','hard','Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Therefore',FALSE,0),('Although',TRUE,1),('However',FALSE,2),('But',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BABD440238A2E931C2A0',m.id,l.id,'Complete using a sentence-level transition: She is young. _____, she is very experienced.','hard','However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because',FALSE,0),('But',FALSE,1),('However',TRUE,2),('Although',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1CFB13A6EF8BFA172CDF',m.id,l.id,'Choose the stronger concession linker: _____ she is young, she is very experienced.','easy','Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because of',FALSE,0),('In order to',FALSE,1),('Even though',TRUE,2),('So that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-843C708E16C69A622576',m.id,l.id,'Complete using a coordinating contrast word: The food was expensive, _____ it was delicious.','medium','But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('and',FALSE,1),('but',TRUE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-20747B8FB5BC8D048038',m.id,l.id,'Complete using a subordinating concession: _____ the food was expensive, it was delicious.','medium','Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',FALSE,0),('But',FALSE,1),('Therefore',FALSE,2),('Although',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4C1E90A8A6804A0C2EC7',m.id,l.id,'Complete using a sentence-level transition: The food was expensive. _____, it was delicious.','hard','However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',TRUE,0),('Although',FALSE,1),('Because',FALSE,2),('But',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6566C7DA35258FD3E27E',m.id,l.id,'Choose the stronger concession linker: _____ the food was expensive, it was delicious.','easy','Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because of',FALSE,0),('In order to',FALSE,1),('Even though',TRUE,2),('So that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-40F5A94ABD12F0C51D69',m.id,l.id,'Complete using a coordinating contrast word: He was tired, _____ he finished the race.','hard','But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so',FALSE,0),('and',FALSE,1),('but',TRUE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1A9A501B21AD467D59B9',m.id,l.id,'Complete using a subordinating concession: _____ he was tired, he finished the race.','hard','Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',FALSE,0),('But',FALSE,1),('Therefore',FALSE,2),('Although',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6AA0D51C981FB868FE1C',m.id,l.id,'Complete using a sentence-level transition: He was tired. _____, he finished the race.','easy','However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',TRUE,0),('Although',FALSE,1),('Because',FALSE,2),('But',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8264F3113B6680DC3883',m.id,l.id,'Choose the stronger concession linker: _____ he was tired, he finished the race.','hard','Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('In order to',FALSE,0),('Even though',TRUE,1),('So that',FALSE,2),('Because of',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6CF0ADFF8E15C7326F0C',m.id,l.id,'Complete using a coordinating contrast word: It was raining, _____ we went outside.','medium','But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so',FALSE,1),('and',FALSE,2),('but',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BB8D52317F9CED5CED5',m.id,l.id,'Complete using a subordinating concession: _____ it was raining, we went outside.','medium','Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',FALSE,0),('But',FALSE,1),('Therefore',FALSE,2),('Although',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-037B31DCEF7379367E09',m.id,l.id,'Complete using a sentence-level transition: It was raining. _____, we went outside.','medium','However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('However',TRUE,0),('Although',FALSE,1),('Because',FALSE,2),('But',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B87CD0733CEA432971E3',m.id,l.id,'Choose the stronger concession linker: _____ it was raining, we went outside.','easy','Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('So that',FALSE,0),('Because of',FALSE,1),('In order to',FALSE,2),('Even though',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-65FD6509A477BFE76BC0',m.id,l.id,'Complete a comparison of contrasting facts: I drink tea, _____ my sister drinks coffee.','easy','Whereas dipakai untuk mengontraskan dua fakta yang berbeda.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and then',FALSE,0),('whereas',TRUE,1),('because',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6C24F7EB9D4ECD37C71B',m.id,l.id,'Complete a comparison of contrasting facts: Rina enjoys reading, _____ Dina prefers swimming.','easy','Whereas dipakai untuk mengontraskan dua fakta yang berbeda.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('so that',FALSE,1),('and then',FALSE,2),('whereas',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BEC7E6B10E0831A2D5DA',m.id,l.id,'Complete a comparison of contrasting facts: My father works mornings, _____ my mother works nights.','hard','Whereas dipakai untuk mengontraskan dua fakta yang berbeda.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and then',FALSE,0),('whereas',TRUE,1),('because',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8619FF4D82E3A44ABAFA',m.id,l.id,'Complete a comparison of contrasting facts: The north is cool, _____ the south is warmer.','medium','Whereas dipakai untuk mengontraskan dua fakta yang berbeda.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('and then',FALSE,0),('whereas',TRUE,1),('because',FALSE,2),('so that',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9537B260F60C0F8428B',m.id,l.id,'Complete a comparison of contrasting facts: He likes cities, _____ she prefers villages.','hard','Whereas dipakai untuk mengontraskan dua fakta yang berbeda.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='contrast-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('so that',FALSE,0),('and then',FALSE,1),('whereas',TRUE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E6510673EB44D56B9C84',m.id,l.id,'Complete the real future condition: _____ it rains, we will stay home.','hard','If memperkenalkan syarat atau kemungkinan realistis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('as if',FALSE,1),('whether',FALSE,2),('If',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F84A53D1005217AD4B97',m.id,l.id,'Complete the real future condition: _____ you study hard, you will improve.','hard','If memperkenalkan syarat atau kemungkinan realistis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('If',TRUE,1),('Unless',FALSE,2),('as if',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7865DCE15B1C0A0B5047',m.id,l.id,'Complete the real future condition: _____ she arrives early, we can start.','hard','If memperkenalkan syarat atau kemungkinan realistis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('If',TRUE,1),('Unless',FALSE,2),('as if',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-07299119F8CC1D5BDE1E',m.id,l.id,'Complete the real future condition: _____ he calls tonight, I will answer.','hard','If memperkenalkan syarat atau kemungkinan realistis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('If',TRUE,1),('Unless',FALSE,2),('as if',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9BDF46D3CA4FCADA0907',m.id,l.id,'Complete the real future condition: _____ the bus is late, we will take a taxi.','hard','If memperkenalkan syarat atau kemungkinan realistis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('as if',FALSE,1),('whether',FALSE,2),('If',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D418175C0DA68A7BDA72',m.id,l.id,'Complete using “if not”: _____ you practice, you will not improve.','hard','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',TRUE,0),('If',FALSE,1),('as if',FALSE,2),('whether',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D635CA1EC40E13507A0C',m.id,l.id,'Complete using “if not”: _____ she hurries, she will miss the bus.','easy','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('as if',FALSE,0),('whether',FALSE,1),('Unless',TRUE,2),('If',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1B4F894BF67A8D81109E',m.id,l.id,'Complete using “if not”: _____ it stops raining, we cannot leave.','hard','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',FALSE,0),('as if',FALSE,1),('whether',FALSE,2),('Unless',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AB308854331AF561AA61',m.id,l.id,'Complete using “if not”: _____ he apologizes, I will not forgive him.','hard','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',TRUE,0),('If',FALSE,1),('as if',FALSE,2),('whether',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-56D9DE0F8A2B25B254FE',m.id,l.id,'Complete using “if not”: _____ they invite us, we will not go.','easy','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',FALSE,0),('as if',FALSE,1),('whether',FALSE,2),('Unless',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-31BCD5CA5141C29AEC1A',m.id,l.id,'Complete the “seolah-olah” expression: He talks _____ he knows everything.','hard','As if bermakna seolah-olah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('whether',FALSE,1),('as if',TRUE,2),('If',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ACE69E052EFC86157572',m.id,l.id,'Complete the “seolah-olah” expression: She looks _____ she has seen a ghost.','easy','As if bermakna seolah-olah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('as if',TRUE,1),('If',FALSE,2),('Unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ECF61D4B7BE1AE7D0842',m.id,l.id,'Complete the “seolah-olah” expression: The child smiles _____ nothing happened.','hard','As if bermakna seolah-olah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',FALSE,0),('Unless',FALSE,1),('whether',FALSE,2),('as if',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C43AD2C7979E8F2EC0CB',m.id,l.id,'Complete the “seolah-olah” expression: They act _____ they own the place.','easy','As if bermakna seolah-olah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',FALSE,0),('Unless',FALSE,1),('whether',FALSE,2),('as if',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-90935DA8495F8D2CF644',m.id,l.id,'Complete the “seolah-olah” expression: He spends money _____ he is a millionaire.','hard','As if bermakna seolah-olah.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('as if',TRUE,0),('If',FALSE,1),('Unless',FALSE,2),('whether',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7286EAAE3E0C6B0B6D32',m.id,l.id,'Complete a general truth: _____ you heat ice, it melts.','easy','If juga digunakan untuk fakta umum atau zero conditional.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('as if',FALSE,0),('whether',FALSE,1),('If',TRUE,2),('Unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0CADE7A5B1A81BA72C31',m.id,l.id,'Complete a general truth: _____ you mix red and blue, you get purple.','hard','If juga digunakan untuk fakta umum atau zero conditional.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('If',TRUE,1),('Unless',FALSE,2),('as if',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4FF8181425769F00B37E',m.id,l.id,'Complete a general truth: _____ you cool water enough, it freezes.','hard','If juga digunakan untuk fakta umum atau zero conditional.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',TRUE,0),('Unless',FALSE,1),('as if',FALSE,2),('whether',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B3C39955FA80B993A28',m.id,l.id,'Complete a general truth: _____ plants get sunlight, they can grow.','medium','If juga digunakan untuk fakta umum atau zero conditional.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('whether',FALSE,0),('If',TRUE,1),('Unless',FALSE,2),('as if',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8B5EAA4883E777104F51',m.id,l.id,'Complete a general truth: _____ you press the switch, the lamp turns on.','hard','If juga digunakan untuk fakta umum atau zero conditional.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('If',TRUE,0),('Unless',FALSE,1),('as if',FALSE,2),('whether',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-793BCEA92DCEF00A0F55',m.id,l.id,'Complete an embedded yes/no question: I do not know _____ he will attend.','easy','Whether menandai pertanyaan tidak langsung atau alternatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('as if',FALSE,0),('whether',TRUE,1),('If',FALSE,2),('Unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-80FB01D2CED070B4D584',m.id,l.id,'Complete an embedded yes/no question: Please tell me _____ you agree.','medium','Whether menandai pertanyaan tidak langsung atau alternatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('as if',FALSE,1),('whether',TRUE,2),('If',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C61F9F862CCCFFF84561',m.id,l.id,'Complete an embedded yes/no question: She asked _____ we were ready.','medium','Whether menandai pertanyaan tidak langsung atau alternatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('as if',FALSE,1),('whether',TRUE,2),('If',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-76A0FC2DE35E9B2384DA',m.id,l.id,'Complete an embedded yes/no question: We are unsure _____ the shop is open.','medium','Whether menandai pertanyaan tidak langsung atau alternatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('as if',FALSE,0),('whether',TRUE,1),('If',FALSE,2),('Unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-50944DF220795F704933',m.id,l.id,'Complete an embedded yes/no question: I wonder _____ they need help.','easy','Whether menandai pertanyaan tidak langsung atau alternatif.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='condition-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('as if',FALSE,1),('whether',TRUE,2),('If',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-716F48B354A6BC355061',m.id,l.id,'Choose the time linker meaning "ketika": _____ you arrive home, call me.','hard','When menghubungkan dua kejadian berdasarkan waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because',FALSE,0),('Although',FALSE,1),('Unless',FALSE,2),('When',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AE0F79FC4AD5FE2571B8',m.id,l.id,'Choose "segera setelah": _____ you arrive home, call me.','hard','As soon as berarti segera setelah kejadian pertama.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('As soon as',TRUE,0),('Even though',FALSE,1),('Because of',FALSE,2),('In order to',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0775DE719C641D6718B1',m.id,l.id,'Choose the time linker meaning "ketika": _____ the class starts, please take your seat.','medium','When menghubungkan dua kejadian berdasarkan waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('When',TRUE,1),('Because',FALSE,2),('Although',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-98AFAD9241E48D0FFB0F',m.id,l.id,'Choose "segera setelah": _____ the class starts, please take your seat.','hard','As soon as berarti segera setelah kejadian pertama.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because of',FALSE,0),('In order to',FALSE,1),('As soon as',TRUE,2),('Even though',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1810AAFE04FF88601446',m.id,l.id,'Choose the time linker meaning "ketika": _____ the train arrives, we will board.','hard','When menghubungkan dua kejadian berdasarkan waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Although',FALSE,0),('Unless',FALSE,1),('When',TRUE,2),('Because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1CE8D4BA2C2516211CE8',m.id,l.id,'Choose "segera setelah": _____ the train arrives, we will board.','medium','As soon as berarti segera setelah kejadian pertama.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because of',FALSE,0),('In order to',FALSE,1),('As soon as',TRUE,2),('Even though',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-40B9FCAED5F86CD894F9',m.id,l.id,'Choose the time linker meaning "ketika": _____ you finish the exam, hand in your work.','hard','When menghubungkan dua kejadian berdasarkan waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Although',FALSE,0),('Unless',FALSE,1),('When',TRUE,2),('Because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-972F31C984AC86143D56',m.id,l.id,'Choose "segera setelah": _____ you finish the exam, hand in your work.','hard','As soon as berarti segera setelah kejadian pertama.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('In order to',FALSE,0),('As soon as',TRUE,1),('Even though',FALSE,2),('Because of',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5633A4F51B83ED1C5D4D',m.id,l.id,'Choose the time linker meaning "ketika": _____ he gets here, we will leave.','easy','When menghubungkan dua kejadian berdasarkan waktu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Unless',FALSE,0),('When',TRUE,1),('Because',FALSE,2),('Although',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A1B966EAAA2A4FFF56EA',m.id,l.id,'Choose "segera setelah": _____ he gets here, we will leave.','easy','As soon as berarti segera setelah kejadian pertama.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Because of',FALSE,0),('In order to',FALSE,1),('As soon as',TRUE,2),('Even though',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7D8F3502178B4D3B7431',m.id,l.id,'Choose “sebelum”: Wash your hands _____ you eat.','medium','Before mengurutkan tindakan pertama sebelum tindakan kedua.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('although',FALSE,1),('before',TRUE,2),('after',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9ED000645F2722E1C0B3',m.id,l.id,'Choose “sebelum”: Check the address _____ you leave.','easy','Before mengurutkan tindakan pertama sebelum tindakan kedua.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('before',TRUE,0),('after',FALSE,1),('because',FALSE,2),('although',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8B64CD3919A40A3BC781',m.id,l.id,'Choose “sebelum”: Lock the door _____ you go out.','easy','Before mengurutkan tindakan pertama sebelum tindakan kedua.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('although',FALSE,0),('before',TRUE,1),('after',FALSE,2),('because',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9507E6A7201C0F8A22E9',m.id,l.id,'Choose “sebelum”: Review the material _____ you take the exam.','easy','Before mengurutkan tindakan pertama sebelum tindakan kedua.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('after',FALSE,0),('because',FALSE,1),('although',FALSE,2),('before',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-20A9ADCF4832BA281AF6',m.id,l.id,'Choose “sebelum”: Save your work _____ you shut down the computer.','easy','Before mengurutkan tindakan pertama sebelum tindakan kedua.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('after',FALSE,0),('because',FALSE,1),('although',FALSE,2),('before',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A7FBFCF4C27ABFB4C57',m.id,l.id,'Choose “setelah”: We went home _____ the movie ended.','easy','After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('before',FALSE,0),('although',FALSE,1),('unless',FALSE,2),('after',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F7EBFCB7F51036201D56',m.id,l.id,'Choose “setelah”: She rested _____ she finished work.','hard','After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('before',FALSE,0),('although',FALSE,1),('unless',FALSE,2),('after',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5E42BD7E270843D7B5D0',m.id,l.id,'Choose “setelah”: He called his mother _____ he arrived.','hard','After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('although',FALSE,0),('unless',FALSE,1),('after',TRUE,2),('before',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D648E63A906991F1D7ED',m.id,l.id,'Choose “setelah”: They celebrated _____ they won.','hard','After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('although',FALSE,0),('unless',FALSE,1),('after',TRUE,2),('before',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-238A03A061C771DDCBCB',m.id,l.id,'Choose “setelah”: I had lunch _____ the meeting finished.','easy','After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('after',TRUE,0),('before',FALSE,1),('although',FALSE,2),('unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5718605438AD58615659',m.id,l.id,'Choose “sementara” for two overlapping actions: I was reading _____ my sister was cooking.','easy','While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('while',TRUE,0),('until',FALSE,1),('because',FALSE,2),('unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FD4F4E7C051033F675C3',m.id,l.id,'Choose “sementara” for two overlapping actions: He cleaned the kitchen _____ she washed clothes.','easy','While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('while',TRUE,0),('until',FALSE,1),('because',FALSE,2),('unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-611A90C049AD79267744',m.id,l.id,'Choose “sementara” for two overlapping actions: We were waiting _____ the rain was falling.','easy','While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('while',TRUE,0),('until',FALSE,1),('because',FALSE,2),('unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-03F3DAFE2ED691136BF7',m.id,l.id,'Choose “sementara” for two overlapping actions: The students were studying _____ the teacher was preparing questions.','medium','While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('because',FALSE,0),('unless',FALSE,1),('while',TRUE,2),('until',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-74C71678B3187E534D21',m.id,l.id,'Choose “sementara” for two overlapping actions: She played piano _____ he sang.','medium','While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='time-conjunctions' WHERE m.slug='conjunctions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('while',TRUE,0),('until',FALSE,1),('because',FALSE,2),('unless',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-988102060455CB2ED400',m.id,l.id,'Choose the adjective after the linking verb: The room is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''beautiful'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more beautifully',FALSE,0),('beautifulness',FALSE,1),('beautiful',TRUE,2),('beautifully',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5E54470CE0D5ECDD2252',m.id,l.id,'Choose the adjective after the linking verb: The test is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''easy'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('easy',TRUE,0),('easily',FALSE,1),('more easily',FALSE,2),('easyness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-589028F9D817B054E4B7',m.id,l.id,'Choose the adjective after the linking verb: Her father is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''patient'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('patientness',FALSE,0),('patient',TRUE,1),('patiently',FALSE,2),('more patiently',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BD4CF970DE6D27AF003D',m.id,l.id,'Choose the adjective after the linking verb: The mountain is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''high'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('high',TRUE,0),('highly',FALSE,1),('more highly',FALSE,2),('highness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C3E53EAA82805E84F067',m.id,l.id,'Choose the adjective after the linking verb: The baby is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''happy'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more happily',FALSE,0),('happyness',FALSE,1),('happy',TRUE,2),('happily',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-356330451A1C99068B23',m.id,l.id,'Choose the adjective after the linking verb: His answer is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''correct'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('correctness',FALSE,0),('correct',TRUE,1),('correctly',FALSE,2),('more correctly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-137DC42F8D6A9B369BFF',m.id,l.id,'Choose the adjective after the linking verb: The weather is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''cold'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('coldly',FALSE,0),('more coldly',FALSE,1),('coldness',FALSE,2),('cold',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2B6C7473BB29FEAD3ECF',m.id,l.id,'Choose the adjective after the linking verb: The driver is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''careful'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carefully',FALSE,0),('more carefully',FALSE,1),('carefulness',FALSE,2),('careful',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3010208F79484CC8B6A4',m.id,l.id,'Choose the adjective after the linking verb: The library is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''quiet'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quietly',FALSE,0),('more quietly',FALSE,1),('quietness',FALSE,2),('quiet',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0386F9A09E3614CBA82E',m.id,l.id,'Choose the adjective after the linking verb: The water is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''clean'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('clean',TRUE,0),('cleanly',FALSE,1),('more cleanly',FALSE,2),('cleanness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5CA0905649436B931D19',m.id,l.id,'Choose the adjective after the linking verb: The story is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''interesting'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more interestingly',FALSE,0),('interestingness',FALSE,1),('interesting',TRUE,2),('interestingly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-34857B1FF1B79B9B4B4A',m.id,l.id,'Choose the adjective after the linking verb: The bus is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''slow'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('slowly',FALSE,0),('more slowly',FALSE,1),('slowness',FALSE,2),('slow',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F0A27A6E68E6670B4C2',m.id,l.id,'Choose the adjective after the linking verb: The teacher is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''friendly'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more friendlily',FALSE,0),('friendlyness',FALSE,1),('friendly',TRUE,2),('friendlily',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C09721500B29DB424ABA',m.id,l.id,'Choose the adjective after the linking verb: The table is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''heavy'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('heavy',TRUE,0),('heavily',FALSE,1),('more heavily',FALSE,2),('heavyness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B70389005CBA9A74DD71',m.id,l.id,'Choose the adjective after the linking verb: The dog is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''brave'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('brave',TRUE,0),('bravely',FALSE,1),('more bravely',FALSE,2),('braveness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-96B3AEDBC9901A05A79F',m.id,l.id,'Choose the adjective after the linking verb: The exam is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''difficult'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('difficultly',FALSE,0),('more difficultly',FALSE,1),('difficultness',FALSE,2),('difficult',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F4AA243062C4ADED01B2',m.id,l.id,'Choose the adjective after the linking verb: The child is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''sad'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sad',TRUE,0),('sadly',FALSE,1),('more sadly',FALSE,2),('sadness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-47E24C98832CFF78A141',m.id,l.id,'Choose the adjective after the linking verb: The athlete is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''strong'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('strong',TRUE,0),('strongly',FALSE,1),('more strongly',FALSE,2),('strongness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE9DC037B04ED6081E07',m.id,l.id,'Choose the adjective after the linking verb: The food is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''delicious'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('deliciously',FALSE,0),('more deliciously',FALSE,1),('deliciousness',FALSE,2),('delicious',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B4B555A91EAAF6E78D8F',m.id,l.id,'Choose the adjective after the linking verb: The street is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''wide'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wideness',FALSE,0),('wide',TRUE,1),('widely',FALSE,2),('more widely',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5C9EF07DD16E3E5CBF5A',m.id,l.id,'Choose the adjective after the linking verb: The house is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''large'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('largeness',FALSE,0),('large',TRUE,1),('largely',FALSE,2),('more largely',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BCC02AB425E1A3853145',m.id,l.id,'Choose the adjective after the linking verb: The lesson is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''useful'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('useful',TRUE,0),('usefully',FALSE,1),('more usefully',FALSE,2),('usefulness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2DC7994B5336CBE92309',m.id,l.id,'Choose the adjective after the linking verb: The office is _____.','easy','Setelah to be yang mendeskripsikan subjek gunakan adjective ''comfortable'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('comfortably',FALSE,0),('more comfortably',FALSE,1),('comfortableness',FALSE,2),('comfortable',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2BD7DB343FF37DAA2786',m.id,l.id,'Choose the adjective after the linking verb: The plan is _____.','medium','Setelah to be yang mendeskripsikan subjek gunakan adjective ''perfect'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('perfect',TRUE,0),('perfectly',FALSE,1),('more perfectly',FALSE,2),('perfectness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A8E3911FC34572892F32',m.id,l.id,'Choose the adjective after the linking verb: The person is _____.','hard','Setelah to be yang mendeskripsikan subjek gunakan adjective ''gentle'', bukan adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-basics' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gently',FALSE,0),('more gently',FALSE,1),('gentleness',FALSE,2),('gentle',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD95DAAE05E21BBAE194',m.id,l.id,'Choose the standard adverb of manner derived from ''careful''.','easy','Adverb cara dari adjective ''careful'' adalah ''carefully''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carefulness',FALSE,0),('carefuler',FALSE,1),('carefully',TRUE,2),('careful',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0AE04A2A1901B9C48FF8',m.id,l.id,'Choose the standard adverb of manner derived from ''quick''.','hard','Adverb cara dari adjective ''quick'' adalah ''quickly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quickness',FALSE,0),('quicker',FALSE,1),('quickly',TRUE,2),('quick',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-781D31CB4BBDF9D5B869',m.id,l.id,'Choose the standard adverb of manner derived from ''beautiful''.','easy','Adverb cara dari adjective ''beautiful'' adalah ''beautifully''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beautiful',FALSE,0),('beautifulness',FALSE,1),('beautifuler',FALSE,2),('beautifully',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-96A4070FD9BC6DFD0D0F',m.id,l.id,'Choose the standard adverb of manner derived from ''happy''.','hard','Adverb cara dari adjective ''happy'' adalah ''happily''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('happy',FALSE,0),('happyly',FALSE,1),('happyness',FALSE,2),('happily',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A55FA36AD0A15263B99B',m.id,l.id,'Choose the standard adverb of manner derived from ''gentle''.','medium','Adverb cara dari adjective ''gentle'' adalah ''gently''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gentlely',FALSE,0),('gentleness',FALSE,1),('gently',TRUE,2),('gentle',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE770C2BEA010BD429C2',m.id,l.id,'Choose the standard adverb of manner derived from ''clear''.','hard','Adverb cara dari adjective ''clear'' adalah ''clearly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('clear',FALSE,0),('clearness',FALSE,1),('clearer',FALSE,2),('clearly',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-71825B391388B9240A2A',m.id,l.id,'Choose the standard adverb of manner derived from ''honest''.','medium','Adverb cara dari adjective ''honest'' adalah ''honestly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('honester',FALSE,0),('honestly',TRUE,1),('honest',FALSE,2),('honestness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AD259A368B9C7F17410E',m.id,l.id,'Choose the standard adverb of manner derived from ''easy''.','medium','Adverb cara dari adjective ''easy'' adalah ''easily''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('easyly',FALSE,0),('easyness',FALSE,1),('easily',TRUE,2),('easy',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2A261959E76F043D064B',m.id,l.id,'Choose the standard adverb of manner derived from ''lazy''.','hard','Adverb cara dari adjective ''lazy'' adalah ''lazily''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lazyness',FALSE,0),('lazily',TRUE,1),('lazy',FALSE,2),('lazyly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F1AB4C02B2159D47233F',m.id,l.id,'Choose the standard adverb of manner derived from ''patient''.','medium','Adverb cara dari adjective ''patient'' adalah ''patiently''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('patientness',FALSE,0),('patienter',FALSE,1),('patiently',TRUE,2),('patient',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A1A20A6DDB0B3E1898C',m.id,l.id,'Choose the standard adverb of manner derived from ''sad''.','easy','Adverb cara dari adjective ''sad'' adalah ''sadly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sadness',FALSE,0),('sader',FALSE,1),('sadly',TRUE,2),('sad',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-961A018D1572C0BEA2B4',m.id,l.id,'Choose the standard adverb of manner derived from ''foolish''.','medium','Adverb cara dari adjective ''foolish'' adalah ''foolishly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('foolisher',FALSE,0),('foolishly',TRUE,1),('foolish',FALSE,2),('foolishness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5924B36F51BAA0980064',m.id,l.id,'Choose the standard adverb of manner derived from ''brave''.','easy','Adverb cara dari adjective ''brave'' adalah ''bravely''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('brave',FALSE,0),('braveness',FALSE,1),('braveer',FALSE,2),('bravely',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9BFD6B0A099C4BE87E4',m.id,l.id,'Choose the standard adverb of manner derived from ''busy''.','easy','Adverb cara dari adjective ''busy'' adalah ''busily''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('busily',TRUE,0),('busy',FALSE,1),('busyly',FALSE,2),('busyness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D258259211943F488DAC',m.id,l.id,'Choose the standard adverb of manner derived from ''clean''.','easy','Adverb cara dari adjective ''clean'' adalah ''cleanly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cleanness',FALSE,0),('cleaner',FALSE,1),('cleanly',TRUE,2),('clean',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C7D657DC18EB4B6C5647',m.id,l.id,'Choose the standard adverb of manner derived from ''correct''.','medium','Adverb cara dari adjective ''correct'' adalah ''correctly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('correctly',TRUE,0),('correct',FALSE,1),('correctness',FALSE,2),('correcter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-49781E2D999A0126A49B',m.id,l.id,'Choose the standard adverb of manner derived from ''comfortable''.','medium','Adverb cara dari adjective ''comfortable'' adalah ''comfortably''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('comfortableness',FALSE,0),('comfortably',TRUE,1),('comfortable',FALSE,2),('comfortablely',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-83693D6D18131E3D9CC3',m.id,l.id,'Choose the standard adverb of manner derived from ''fluent''.','hard','Adverb cara dari adjective ''fluent'' adalah ''fluently''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fluenter',FALSE,0),('fluently',TRUE,1),('fluent',FALSE,2),('fluentness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-848D0D7FA965B34FBEF0',m.id,l.id,'Choose the standard adverb of manner derived from ''strong''.','easy','Adverb cara dari adjective ''strong'' adalah ''strongly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('strong',FALSE,0),('strongness',FALSE,1),('stronger',FALSE,2),('strongly',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3950D4193C97EF67B6DF',m.id,l.id,'Choose the standard adverb of manner derived from ''perfect''.','medium','Adverb cara dari adjective ''perfect'' adalah ''perfectly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('perfecter',FALSE,0),('perfectly',TRUE,1),('perfect',FALSE,2),('perfectness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4D07C8A475C6E964579D',m.id,l.id,'Choose the standard adverb of manner derived from ''slow''.','easy','Adverb cara dari adjective ''slow'' adalah ''slowly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('slowly',TRUE,0),('slow',FALSE,1),('slowness',FALSE,2),('slower',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F96F43DC973EEBE28F9D',m.id,l.id,'Choose the standard adverb of manner derived from ''quiet''.','hard','Adverb cara dari adjective ''quiet'' adalah ''quietly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quietly',TRUE,0),('quiet',FALSE,1),('quietness',FALSE,2),('quieter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-21444773E8EF6A982110',m.id,l.id,'Choose the standard adverb of manner derived from ''polite''.','easy','Adverb cara dari adjective ''polite'' adalah ''politely''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('polite',FALSE,0),('politeness',FALSE,1),('politeer',FALSE,2),('politely',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-64D164659C7FB48D8760',m.id,l.id,'Choose the standard adverb of manner derived from ''careless''.','medium','Adverb cara dari adjective ''careless'' adalah ''carelessly''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carelesser',FALSE,0),('carelessly',TRUE,1),('careless',FALSE,2),('carelessness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6A52009453FEE0A227DE',m.id,l.id,'Choose the standard adverb of manner derived from ''serious''.','easy','Adverb cara dari adjective ''serious'' adalah ''seriously''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adverbs-ly' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('seriously',TRUE,0),('serious',FALSE,1),('seriousness',FALSE,2),('seriouser',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E853F141077860A10DF0',m.id,l.id,'Choose the correct word: She sings _____. (adverb from good)','easy','Good → well sebagai adverb cara.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('better',FALSE,0),('well',TRUE,1),('good',FALSE,2),('goodly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C4FF28861F561AAA03E7',m.id,l.id,'Choose the correct word: He runs very _____. (speed)','medium','Fast menjadi adverb tanpa -ly.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fasterly',FALSE,0),('fastness',FALSE,1),('fast',TRUE,2),('fastly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3C14B2EFBA6FD139F76B',m.id,l.id,'Choose the correct word: They work _____ every day. (with effort)','hard','Work hard berarti bekerja keras.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hardly',FALSE,0),('hardlyly',FALSE,1),('hardness',FALSE,2),('hard',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-80A09239C2B17B58E961',m.id,l.id,'Choose the correct word: We arrived _____. (after the expected time)','easy','Late berarti terlambat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lateness',FALSE,0),('late',TRUE,1),('lately',FALSE,2),('latest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-929402DFB49EF44EAF88',m.id,l.id,'Choose the correct word: I wake up _____. (before usual time)','easy','Early bisa menjadi adjective dan adverb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('earlily',FALSE,0),('earliestly',FALSE,1),('earliness',FALSE,2),('early',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5EA71B66A5275DF92D5F',m.id,l.id,'Choose the correct word: He can speak English _____. (with good ability)','easy','Well adalah adverb dari good.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('goodly',FALSE,0),('goodness',FALSE,1),('well',TRUE,2),('good',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-783D241356A42903B093',m.id,l.id,'Choose the correct word: The athlete moves _____. (quickly)','easy','Fast dapat berfungsi sebagai adverb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fastly',FALSE,0),('fastness',FALSE,1),('fastestly',FALSE,2),('fast',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3AB0D0A55D7B3CD98DB7',m.id,l.id,'Choose the correct word: She studied _____ for the exam. (with effort)','medium','Study hard bermakna belajar giat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hardlyer',FALSE,0),('hard',TRUE,1),('hardly',FALSE,2),('hardlyness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ABEC318718DE66BA698B',m.id,l.id,'Choose the correct word: He has _____ slept this week. (almost not at all)','easy','Hardly berbeda makna dari hard: hampir tidak.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hard',FALSE,0),('hardest',FALSE,1),('hardness',FALSE,2),('hardly',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9F965B8BDA710266E23D',m.id,l.id,'Choose the correct word: I have been very busy _____. (recently)','easy','Lately bermakna akhir-akhir ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('late',FALSE,0),('latest',FALSE,1),('laterly',FALSE,2),('lately',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B57B1E178C11BCE4DF6C',m.id,l.id,'Choose the correct word: He plays the piano _____. (skillfully)','easy','Well menerangkan cara bermain piano.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('good',FALSE,0),('goodly',FALSE,1),('wellly',FALSE,2),('well',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD6A311E2C954D37A7FB',m.id,l.id,'Choose the correct word: The train travels _____. (speedily)','medium','Fast tetap fast sebagai adverb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fastness',FALSE,0),('fastestly',FALSE,1),('fast',TRUE,2),('fastly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6CFBCF4ED69DC07B3659',m.id,l.id,'Choose the correct word: The team trained _____. (with great effort)','hard','Hard bermakna sungguh-sungguh.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hardlyness',FALSE,0),('hardily',FALSE,1),('hard',TRUE,2),('hardly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD365AB7CDD55636183C',m.id,l.id,'Choose the correct word: She came _____. (not on time)','easy','Late berarti terlambat, bukan lately.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lately',FALSE,0),('lateness',FALSE,1),('latestly',FALSE,2),('late',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A430FF203037B8B9C321',m.id,l.id,'Choose the correct word: The children got up _____. (before usual time)','medium','Early juga dapat menjelaskan waktu tindakan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('early',TRUE,0),('earlily',FALSE,1),('earlierly',FALSE,2),('earness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-45DB9ED65C0A6D87CDBD',m.id,l.id,'Choose the correct word: We _____ know each other. (almost not)','medium','Hardly bermakna hampir tidak.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hardest',FALSE,0),('hardness',FALSE,1),('hardly',TRUE,2),('hard',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5E106723989AC96F2D3B',m.id,l.id,'Choose the correct word: She has visited us _____. (recently)','easy','Lately menyatakan beberapa waktu belakangan ini.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('late',FALSE,0),('laterly',FALSE,1),('latest',FALSE,2),('lately',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4CE228F2CC4D620A1674',m.id,l.id,'Choose the correct word: I feel _____. (healthy)','hard','Well dapat berfungsi sebagai adjective berarti sehat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wellly',FALSE,0),('goodness',FALSE,1),('well',TRUE,2),('goodly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EFABA90C225DB0F38CE6',m.id,l.id,'Choose the correct word: You did very _____ on the test. (good performance)','easy','Do well menunjukkan performa baik.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('well',TRUE,0),('good',FALSE,1),('goodly',FALSE,2),('betterly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1E9D85ED8476800B4647',m.id,l.id,'Choose the correct word: We left _____. (not after the scheduled time)','hard','Early dapat menerangkan waktu keberangkatan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('earliness',FALSE,0),('early',TRUE,1),('earlily',FALSE,2),('earliestly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-35A8FD550EC946EF488F',m.id,l.id,'Choose the correct word: The workers pushed _____. (with force)','hard','Hard berarti dengan kuat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hardness',FALSE,0),('hard',TRUE,1),('hardly',FALSE,2),('hardlyly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EF6F05838FC616E88079',m.id,l.id,'Choose the correct word: The shop closed _____. (later than normal)','medium','Late dipakai untuk waktu tutup terlambat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lately',FALSE,0),('lateness',FALSE,1),('laterly',FALSE,2),('late',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CFE35FB32DFF22A05DCF',m.id,l.id,'Choose the correct word: The rabbit moves _____. (rapidly)','hard','Fast menjadi adverb tanpa -ly.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fastly',FALSE,0),('fastness',FALSE,1),('fasterly',FALSE,2),('fast',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-45D652424E4B1ABC4226',m.id,l.id,'Choose the correct word: I can _____ hear you. (almost not)','medium','Hardly adalah adverb yang berarti hampir tidak.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('harder',FALSE,0),('hardness',FALSE,1),('hardly',TRUE,2),('hard',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-36D95A1602FCF75D0B13',m.id,l.id,'Choose the correct word: The student writes _____. (good quality)','easy','Write well menjelaskan cara menulis.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-adverbs' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('goodly',FALSE,0),('wellness',FALSE,1),('well',TRUE,2),('good',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-167923D95B11051F8756',m.id,l.id,'Choose the adjective: The driver is _____.','easy','''careful'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more carefully',FALSE,0),('careful',TRUE,1),('carefully',FALSE,2),('carefulness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-26988FECA24BA231DB58',m.id,l.id,'Choose the manner adverb: The driver drives _____.','medium','''carefully'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('carefully',TRUE,0),('careful',FALSE,1),('carefulness',FALSE,2),('most careful',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8CEB29ADB81F169957D0',m.id,l.id,'Choose the adjective: Her response was _____.','easy','''quick'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more quickly',FALSE,0),('quick',TRUE,1),('quickly',FALSE,2),('quickness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-36A2CC3F540FA77A5B8D',m.id,l.id,'Choose the manner adverb: She responded _____.','medium','''quickly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quick',FALSE,0),('quickness',FALSE,1),('most quick',FALSE,2),('quickly',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-29BA0D52BF3A47B8DC3B',m.id,l.id,'Choose the adjective: The child is _____.','easy','''happy'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('happyness',FALSE,0),('happyly',FALSE,1),('happy',TRUE,2),('happily',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A1BD6C2F51BA4C2B1026',m.id,l.id,'Choose the manner adverb: The child smiled _____.','hard','''happily'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('happy',FALSE,0),('happyness',FALSE,1),('most happy',FALSE,2),('happily',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EEA3DB1B0A6DEB158B72',m.id,l.id,'Choose the adjective: The nurse is _____.','easy','''patient'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('patiently',FALSE,0),('patientness',FALSE,1),('more patiently',FALSE,2),('patient',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0315857D3C61BF35463F',m.id,l.id,'Choose the manner adverb: The nurse waited _____.','hard','''patiently'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most patient',FALSE,0),('patiently',TRUE,1),('patient',FALSE,2),('patientness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2A54A9BCBB871B0B487D',m.id,l.id,'Choose the adjective: The library is _____.','easy','''quiet'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quiet',TRUE,0),('quietly',FALSE,1),('quietness',FALSE,2),('more quietly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3DFE23DEE1B118EFDD6E',m.id,l.id,'Choose the manner adverb: The students worked _____.','hard','''quietly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('quietness',FALSE,0),('most quiet',FALSE,1),('quietly',TRUE,2),('quiet',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4A3FA28B2BD3CFDA5A48',m.id,l.id,'Choose the adjective: The painting is _____.','medium','''beautiful'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beautifully',FALSE,0),('beautifulness',FALSE,1),('more beautifully',FALSE,2),('beautiful',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8C31A297D1108F16D710',m.id,l.id,'Choose the manner adverb: The artist painted _____.','easy','''beautifully'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('beautiful',FALSE,0),('beautifulness',FALSE,1),('most beautiful',FALSE,2),('beautifully',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F0157981DADEF0758B2',m.id,l.id,'Choose the adjective: His explanation is _____.','medium','''clear'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('clear',TRUE,0),('clearly',FALSE,1),('clearness',FALSE,2),('more clearly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-98A497666FA23903261B',m.id,l.id,'Choose the manner adverb: He explained it _____.','easy','''clearly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('clearness',FALSE,0),('most clear',FALSE,1),('clearly',TRUE,2),('clear',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-56ABF6F686769989F739',m.id,l.id,'Choose the adjective: The train is _____.','hard','''slow'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('slowness',FALSE,0),('more slowly',FALSE,1),('slow',TRUE,2),('slowly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-968CD35553AB2156FAFC',m.id,l.id,'Choose the manner adverb: The train moves _____.','medium','''slowly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most slow',FALSE,0),('slowly',TRUE,1),('slow',FALSE,2),('slowness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A2543692E9BFFC8E3FA5',m.id,l.id,'Choose the adjective: The boy looks _____.','hard','''sad'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sadness',FALSE,0),('more sadly',FALSE,1),('sad',TRUE,2),('sadly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8604F5A0526E7F29F922',m.id,l.id,'Choose the manner adverb: The boy spoke _____.','easy','''sadly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('sadly',TRUE,0),('sad',FALSE,1),('sadness',FALSE,2),('most sad',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A4FAA59E7DABC0F2063F',m.id,l.id,'Choose the adjective: The speaker is _____.','medium','''fluent'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fluentness',FALSE,0),('more fluently',FALSE,1),('fluent',TRUE,2),('fluently',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0832DDB27761C9F76E6E',m.id,l.id,'Choose the manner adverb: The speaker spoke _____.','medium','''fluently'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fluentness',FALSE,0),('most fluent',FALSE,1),('fluently',TRUE,2),('fluent',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8E72E760B4C82F8102BD',m.id,l.id,'Choose the adjective: The test was _____.','medium','''easy'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('easy',TRUE,0),('easily',FALSE,1),('easyness',FALSE,2),('easyly',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4665F0AD304BA5E4D0A1',m.id,l.id,'Choose the manner adverb: He finished the test _____.','easy','''easily'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most easy',FALSE,0),('easily',TRUE,1),('easy',FALSE,2),('easyness',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-864E70B729D87AECCB24',m.id,l.id,'Choose the adjective: The answer is _____.','easy','''correct'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('correctly',FALSE,0),('correctness',FALSE,1),('more correctly',FALSE,2),('correct',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-09AD21A230AAF64AB603',m.id,l.id,'Choose the manner adverb: She answered _____.','medium','''correctly'' menerangkan cara suatu tindakan dilakukan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('correctness',FALSE,0),('most correct',FALSE,1),('correctly',TRUE,2),('correct',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4251C527CDADEFFDB3D4',m.id,l.id,'Choose the adjective: The firefighter was _____.','easy','''brave'' mendeskripsikan subjek setelah linking verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='adjective-adverb-context' WHERE m.slug='adjective-adverb'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('bravely',FALSE,0),('braveness',FALSE,1),('more bravely',FALSE,2),('brave',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-04C7065E25C4A930C3F5',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: tall)','easy','Struktur kesetaraan adalah as + adjective dasar (tall) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('taller',FALSE,0),('tallest',FALSE,1),('tall',TRUE,2),('more tall',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FF1915983C995576F53D',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: short)','hard','Struktur kesetaraan adalah as + adjective dasar (short) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('short',TRUE,0),('more short',FALSE,1),('shorter',FALSE,2),('shortest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8B423CC721756DAB841C',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: old)','medium','Struktur kesetaraan adalah as + adjective dasar (old) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more old',FALSE,0),('older',FALSE,1),('oldest',FALSE,2),('old',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A3181A6ABB0B198C1961',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: young)','easy','Struktur kesetaraan adalah as + adjective dasar (young) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('younger',FALSE,0),('youngest',FALSE,1),('young',TRUE,2),('more young',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A34F6016CF6ABF9199DB',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: high)','medium','Struktur kesetaraan adalah as + adjective dasar (high) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('higher',FALSE,0),('highest',FALSE,1),('high',TRUE,2),('more high',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F38771A60087F1893177',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: low)','easy','Struktur kesetaraan adalah as + adjective dasar (low) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lower',FALSE,0),('lowest',FALSE,1),('low',TRUE,2),('more low',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1CCEF8F5C5B08FB0D091',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: long)','hard','Struktur kesetaraan adalah as + adjective dasar (long) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('longest',FALSE,0),('long',TRUE,1),('more long',FALSE,2),('longer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-052E1DA6402C071E7A34',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: wide)','medium','Struktur kesetaraan adalah as + adjective dasar (wide) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wideer',FALSE,0),('wideest',FALSE,1),('wide',TRUE,2),('more wide',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CE3F54BC1C36C023F35B',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: small)','easy','Struktur kesetaraan adalah as + adjective dasar (small) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('small',TRUE,0),('more small',FALSE,1),('smaller',FALSE,2),('smallest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4EEB95D2393B5A276CA5',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: big)','hard','Struktur kesetaraan adalah as + adjective dasar (big) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('biger',FALSE,0),('bigest',FALSE,1),('big',TRUE,2),('more big',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B1358D74BDAD110AE167',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: heavy)','hard','Struktur kesetaraan adalah as + adjective dasar (heavy) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('heavy',TRUE,0),('more heavy',FALSE,1),('heavyer',FALSE,2),('heavyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B747A48D46954CB1148B',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: light)','medium','Struktur kesetaraan adalah as + adjective dasar (light) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lightest',FALSE,0),('light',TRUE,1),('more light',FALSE,2),('lighter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-829707615D903542236C',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: cheap)','hard','Struktur kesetaraan adalah as + adjective dasar (cheap) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cheapest',FALSE,0),('cheap',TRUE,1),('more cheap',FALSE,2),('cheaper',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-42836A9F95609D3BFE62',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: expensive)','hard','Struktur kesetaraan adalah as + adjective dasar (expensive) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more expensive',FALSE,0),('expensiveer',FALSE,1),('expensiveest',FALSE,2),('expensive',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6CE2205793C655B81B86',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: fast)','hard','Struktur kesetaraan adalah as + adjective dasar (fast) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more fast',FALSE,0),('faster',FALSE,1),('fastest',FALSE,2),('fast',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28C8DF32F22F7BEE8F22',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: slow)','hard','Struktur kesetaraan adalah as + adjective dasar (slow) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('slower',FALSE,0),('slowest',FALSE,1),('slow',TRUE,2),('more slow',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6D19FE1F657613CAF58C',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: beautiful)','hard','Struktur kesetaraan adalah as + adjective dasar (beautiful) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more beautiful',FALSE,0),('beautifuler',FALSE,1),('beautifulest',FALSE,2),('beautiful',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B0236373AFA2E8FC606D',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: careful)','hard','Struktur kesetaraan adalah as + adjective dasar (careful) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more careful',FALSE,0),('carefuler',FALSE,1),('carefulest',FALSE,2),('careful',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-58304A1D8A3CCE668010',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: friendly)','hard','Struktur kesetaraan adalah as + adjective dasar (friendly) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('friendlyest',FALSE,0),('friendly',TRUE,1),('more friendly',FALSE,2),('friendlyer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4291A0B75B4A251ED971',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: strong)','medium','Struktur kesetaraan adalah as + adjective dasar (strong) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more strong',FALSE,0),('stronger',FALSE,1),('strongest',FALSE,2),('strong',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7F9348E9CD6E681C6C97',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: weak)','easy','Struktur kesetaraan adalah as + adjective dasar (weak) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('weakest',FALSE,0),('weak',TRUE,1),('more weak',FALSE,2),('weaker',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-63BB1437836066BACE7A',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: easy)','hard','Struktur kesetaraan adalah as + adjective dasar (easy) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more easy',FALSE,0),('easyer',FALSE,1),('easyest',FALSE,2),('easy',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2A697123270A697D2BA0',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: difficult)','easy','Struktur kesetaraan adalah as + adjective dasar (difficult) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more difficult',FALSE,0),('difficulter',FALSE,1),('difficultest',FALSE,2),('difficult',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8E5252AEA74677BB8A4F',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: useful)','easy','Struktur kesetaraan adalah as + adjective dasar (useful) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('usefuler',FALSE,0),('usefulest',FALSE,1),('useful',TRUE,2),('more useful',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D5BC4818761BE0843810',m.id,l.id,'Complete an equality comparison: This object is as _____ as that object. (adjective: important)','easy','Struktur kesetaraan adalah as + adjective dasar (important) + as, bukan comparative/superlative.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='positive-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('important',TRUE,0),('more important',FALSE,1),('importanter',FALSE,2),('importantest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5B6B822DAA32585FC6EB',m.id,l.id,'Choose the comparative form of ''cheap'' (before ''than'').','medium','Bentuk comparative untuk ''cheap'' adalah ''cheaper'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most cheap',FALSE,0),('cheaper',TRUE,1),('cheapest',FALSE,2),('more cheap',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-234BA1C8B3F4C5099DB1',m.id,l.id,'Choose the comparative form of ''great'' (before ''than'').','hard','Bentuk comparative untuk ''great'' adalah ''greater'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('greater',TRUE,0),('greatest',FALSE,1),('more great',FALSE,2),('most great',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD10609A777F6A5C4B8A',m.id,l.id,'Choose the comparative form of ''tall'' (before ''than'').','easy','Bentuk comparative untuk ''tall'' adalah ''taller'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more tall',FALSE,0),('most tall',FALSE,1),('taller',TRUE,2),('tallest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E18756AA372F836D7E71',m.id,l.id,'Choose the comparative form of ''high'' (before ''than'').','easy','Bentuk comparative untuk ''high'' adalah ''higher'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more high',FALSE,0),('most high',FALSE,1),('higher',TRUE,2),('highest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1A0F06A067FBE016F3EE',m.id,l.id,'Choose the comparative form of ''kind'' (before ''than'').','easy','Bentuk comparative untuk ''kind'' adalah ''kinder'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('kinder',TRUE,0),('kindest',FALSE,1),('more kind',FALSE,2),('most kind',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8DB95675BFDE7BFD7617',m.id,l.id,'Choose the comparative form of ''big'' (before ''than'').','easy','Bentuk comparative untuk ''big'' adalah ''bigger'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more big',FALSE,0),('bigger',TRUE,1),('biger',FALSE,2),('bigest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0D37BCC742C404844AA0',m.id,l.id,'Choose the comparative form of ''hot'' (before ''than'').','hard','Bentuk comparative untuk ''hot'' adalah ''hotter'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('hoter',FALSE,0),('hotest',FALSE,1),('more hot',FALSE,2),('hotter',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E337B53AE83CBE6C8ED7',m.id,l.id,'Choose the comparative form of ''wet'' (before ''than'').','hard','Bentuk comparative untuk ''wet'' adalah ''wetter'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wetest',FALSE,0),('more wet',FALSE,1),('wetter',TRUE,2),('weter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-72A0BACD1225690A629C',m.id,l.id,'Choose the comparative form of ''thin'' (before ''than'').','hard','Bentuk comparative untuk ''thin'' adalah ''thinner'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more thin',FALSE,0),('thinner',TRUE,1),('thiner',FALSE,2),('thinest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EFF5E1BBFC8429DC7016',m.id,l.id,'Choose the comparative form of ''fit'' (before ''than'').','easy','Bentuk comparative untuk ''fit'' adalah ''fitter'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fiter',FALSE,0),('fitest',FALSE,1),('more fit',FALSE,2),('fitter',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BB5004198E25FD6E7669',m.id,l.id,'Choose the comparative form of ''happy'' (before ''than'').','hard','Bentuk comparative untuk ''happy'' adalah ''happier'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more happy',FALSE,0),('happier',TRUE,1),('happyer',FALSE,2),('happyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D950C97E2771E6FCC10D',m.id,l.id,'Choose the comparative form of ''lucky'' (before ''than'').','medium','Bentuk comparative untuk ''lucky'' adalah ''luckier'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('luckyest',FALSE,0),('more lucky',FALSE,1),('luckier',TRUE,2),('luckyer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CA2C6C80CBEE9C3F5FAD',m.id,l.id,'Choose the comparative form of ''pretty'' (before ''than'').','easy','Bentuk comparative untuk ''pretty'' adalah ''prettier'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('prettier',TRUE,0),('prettyer',FALSE,1),('prettyest',FALSE,2),('more pretty',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CDDCC592E9B85C590B03',m.id,l.id,'Choose the comparative form of ''lazy'' (before ''than'').','medium','Bentuk comparative untuk ''lazy'' adalah ''lazier'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lazyest',FALSE,0),('more lazy',FALSE,1),('lazier',TRUE,2),('lazyer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3063F89F399C3DAFF92A',m.id,l.id,'Choose the comparative form of ''busy'' (before ''than'').','hard','Bentuk comparative untuk ''busy'' adalah ''busier'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('busyer',FALSE,0),('busyest',FALSE,1),('more busy',FALSE,2),('busier',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9D5D8C6FB2F1960CFBD9',m.id,l.id,'Choose the comparative form of ''clever'' (before ''than'').','hard','Bentuk comparative untuk ''clever'' adalah ''cleverer'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('cleverest',FALSE,0),('more clever',FALSE,1),('most clever',FALSE,2),('cleverer',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8C8FE3E31A0873A2641B',m.id,l.id,'Choose the comparative form of ''narrow'' (before ''than'').','hard','Bentuk comparative untuk ''narrow'' adalah ''narrower'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('narrowest',FALSE,0),('more narrow',FALSE,1),('most narrow',FALSE,2),('narrower',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BAEE5F4F7028519C7E74',m.id,l.id,'Choose the comparative form of ''slow'' (before ''than'').','hard','Bentuk comparative untuk ''slow'' adalah ''slower'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('slowest',FALSE,0),('more slow',FALSE,1),('most slow',FALSE,2),('slower',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DFF40E97FEB5D988FA52',m.id,l.id,'Choose the comparative form of ''wise'' (before ''than'').','hard','Bentuk comparative untuk ''wise'' adalah ''wiser'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wiseer',FALSE,0),('wiseest',FALSE,1),('more wise',FALSE,2),('wiser',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6662212C048E283030FD',m.id,l.id,'Choose the comparative form of ''brave'' (before ''than'').','easy','Bentuk comparative untuk ''brave'' adalah ''braver'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('braver',TRUE,0),('braveer',FALSE,1),('braveest',FALSE,2),('more brave',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B44E1308112CFD40FF99',m.id,l.id,'Choose the comparative form of ''fine'' (before ''than'').','easy','Bentuk comparative untuk ''fine'' adalah ''finer'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('finer',TRUE,0),('fineer',FALSE,1),('fineest',FALSE,2),('more fine',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D999BECBC1BF4CB55447',m.id,l.id,'Choose the comparative form of ''large'' (before ''than'').','hard','Bentuk comparative untuk ''large'' adalah ''larger'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('largeer',FALSE,0),('largeest',FALSE,1),('more large',FALSE,2),('larger',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-129F2AF9E332C3CFA1B8',m.id,l.id,'Choose the comparative form of ''nice'' (before ''than'').','medium','Bentuk comparative untuk ''nice'' adalah ''nicer'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more nice',FALSE,0),('nicer',TRUE,1),('niceer',FALSE,2),('niceest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DACC232F93DA90F5E4A9',m.id,l.id,'Choose the comparative form of ''famous'' (before ''than'').','medium','Bentuk comparative untuk ''famous'' adalah ''more famous'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('famouser',FALSE,0),('famousest',FALSE,1),('most famous',FALSE,2),('more famous',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7E329451F6C46E69B5BA',m.id,l.id,'Choose the comparative form of ''expensive'' (before ''than'').','easy','Bentuk comparative untuk ''expensive'' adalah ''more expensive'' sebelum than.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='comparative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most expensive',FALSE,0),('more expensive',TRUE,1),('expensiveer',FALSE,2),('expensiveest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-74ACACDD1AEF7E97990E',m.id,l.id,'Choose the superlative form of ''cheap'' (used after ''the'').','hard','Bentuk superlative untuk ''cheap'' adalah ''cheapest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more cheap',FALSE,0),('cheapest',TRUE,1),('cheaper',FALSE,2),('most cheap',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3F8293EE7856D3069BBF',m.id,l.id,'Choose the superlative form of ''great'' (used after ''the'').','easy','Bentuk superlative untuk ''great'' adalah ''greatest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most great',FALSE,0),('more great',FALSE,1),('greatest',TRUE,2),('greater',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D5AB1FF482C4BC937632',m.id,l.id,'Choose the superlative form of ''tall'' (used after ''the'').','medium','Bentuk superlative untuk ''tall'' adalah ''tallest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('tallest',TRUE,0),('taller',FALSE,1),('most tall',FALSE,2),('more tall',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-52639422FF90FC2AE86A',m.id,l.id,'Choose the superlative form of ''high'' (used after ''the'').','easy','Bentuk superlative untuk ''high'' adalah ''highest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most high',FALSE,0),('more high',FALSE,1),('highest',TRUE,2),('higher',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D72AA5C5DCEB7961A9FC',m.id,l.id,'Choose the superlative form of ''kind'' (used after ''the'').','medium','Bentuk superlative untuk ''kind'' adalah ''kindest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more kind',FALSE,0),('kindest',TRUE,1),('kinder',FALSE,2),('most kind',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A475B59EBB7FF9685527',m.id,l.id,'Choose the superlative form of ''big'' (used after ''the'').','medium','Bentuk superlative untuk ''big'' adalah ''biggest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('biger',FALSE,0),('most big',FALSE,1),('biggest',TRUE,2),('bigest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EE1A0E6D061F4567BE78',m.id,l.id,'Choose the superlative form of ''hot'' (used after ''the'').','hard','Bentuk superlative untuk ''hot'' adalah ''hottest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most hot',FALSE,0),('hottest',TRUE,1),('hotest',FALSE,2),('hoter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6761599325856E65D386',m.id,l.id,'Choose the superlative form of ''wet'' (used after ''the'').','easy','Bentuk superlative untuk ''wet'' adalah ''wettest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('wetest',FALSE,0),('weter',FALSE,1),('most wet',FALSE,2),('wettest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A0AFB946811874FD2F33',m.id,l.id,'Choose the superlative form of ''thin'' (used after ''the'').','easy','Bentuk superlative untuk ''thin'' adalah ''thinnest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('thiner',FALSE,0),('most thin',FALSE,1),('thinnest',TRUE,2),('thinest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B259BC93A4511F6F7CCD',m.id,l.id,'Choose the superlative form of ''fit'' (used after ''the'').','easy','Bentuk superlative untuk ''fit'' adalah ''fittest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fitest',FALSE,0),('fiter',FALSE,1),('most fit',FALSE,2),('fittest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1C8B88FB46EDBB0859A0',m.id,l.id,'Choose the superlative form of ''happy'' (used after ''the'').','medium','Bentuk superlative untuk ''happy'' adalah ''happiest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('happyest',FALSE,0),('happyer',FALSE,1),('most happy',FALSE,2),('happiest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-41533C136B7B8D7C352F',m.id,l.id,'Choose the superlative form of ''lucky'' (used after ''the'').','easy','Bentuk superlative untuk ''lucky'' adalah ''luckiest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('luckyest',FALSE,0),('luckyer',FALSE,1),('most lucky',FALSE,2),('luckiest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-376715F2C814A147F8C6',m.id,l.id,'Choose the superlative form of ''pretty'' (used after ''the'').','hard','Bentuk superlative untuk ''pretty'' adalah ''prettiest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('prettyer',FALSE,0),('most pretty',FALSE,1),('prettiest',TRUE,2),('prettyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-96D6E74EEFF6E90F7BF3',m.id,l.id,'Choose the superlative form of ''lazy'' (used after ''the'').','medium','Bentuk superlative untuk ''lazy'' adalah ''laziest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lazyer',FALSE,0),('most lazy',FALSE,1),('laziest',TRUE,2),('lazyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5D216D320AF0A38066EC',m.id,l.id,'Choose the superlative form of ''busy'' (used after ''the'').','medium','Bentuk superlative untuk ''busy'' adalah ''busiest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('busyer',FALSE,0),('most busy',FALSE,1),('busiest',TRUE,2),('busyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F145E5C9EEC2FEC8412C',m.id,l.id,'Choose the superlative form of ''clever'' (used after ''the'').','medium','Bentuk superlative untuk ''clever'' adalah ''cleverest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more clever',FALSE,0),('cleverest',TRUE,1),('cleverer',FALSE,2),('most clever',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6229F344074F376CF271',m.id,l.id,'Choose the superlative form of ''narrow'' (used after ''the'').','easy','Bentuk superlative untuk ''narrow'' adalah ''narrowest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('narrowest',TRUE,0),('narrower',FALSE,1),('most narrow',FALSE,2),('more narrow',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F56F8E6534A06DCF84E3',m.id,l.id,'Choose the superlative form of ''slow'' (used after ''the'').','easy','Bentuk superlative untuk ''slow'' adalah ''slowest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more slow',FALSE,0),('slowest',TRUE,1),('slower',FALSE,2),('most slow',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C9E534C9AC2C41F1EAFA',m.id,l.id,'Choose the superlative form of ''wise'' (used after ''the'').','easy','Bentuk superlative untuk ''wise'' adalah ''wisest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most wise',FALSE,0),('wisest',TRUE,1),('wiseest',FALSE,2),('wiseer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B6FBAE3957DEE6A5A00B',m.id,l.id,'Choose the superlative form of ''brave'' (used after ''the'').','hard','Bentuk superlative untuk ''brave'' adalah ''bravest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most brave',FALSE,0),('bravest',TRUE,1),('braveest',FALSE,2),('braveer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-95BEED7363E2BC363DB1',m.id,l.id,'Choose the superlative form of ''fine'' (used after ''the'').','easy','Bentuk superlative untuk ''fine'' adalah ''finest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('fineest',FALSE,0),('fineer',FALSE,1),('most fine',FALSE,2),('finest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D1ACE63B0A4BBF9D900F',m.id,l.id,'Choose the superlative form of ''large'' (used after ''the'').','medium','Bentuk superlative untuk ''large'' adalah ''largest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('largeest',FALSE,0),('largeer',FALSE,1),('most large',FALSE,2),('largest',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AB1944A80042BA5470D2',m.id,l.id,'Choose the superlative form of ''nice'' (used after ''the'').','easy','Bentuk superlative untuk ''nice'' adalah ''nicest'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('nicest',TRUE,0),('niceest',FALSE,1),('niceer',FALSE,2),('most nice',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1CB45DFB9F5B8CC5BD95',m.id,l.id,'Choose the superlative form of ''famous'' (used after ''the'').','hard','Bentuk superlative untuk ''famous'' adalah ''most famous'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('famousest',FALSE,0),('famouser',FALSE,1),('more famous',FALSE,2),('most famous',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E44C270515E64FA88580',m.id,l.id,'Choose the superlative form of ''expensive'' (used after ''the'').','easy','Bentuk superlative untuk ''expensive'' adalah ''most expensive'' dan biasanya didahului the.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='superlative-forms' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more expensive',FALSE,0),('most expensive',TRUE,1),('expensiveest',FALSE,2),('expensiveer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE10C682A32F01565680',m.id,l.id,'Choose the comparative for ''good''.','easy','''good'' memiliki comparative ''better'' dan superlative ''best''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gooder',FALSE,0),('more good',FALSE,1),('better',TRUE,2),('best',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4839DF53B632A7B69364',m.id,l.id,'Choose the superlative for ''good''.','hard','''good'' memiliki superlative ''best''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('better',FALSE,0),('goodest',FALSE,1),('most good',FALSE,2),('best',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F956939BFF28AD1C6B84',m.id,l.id,'Choose the comparative for ''bad''.','medium','''bad'' memiliki comparative ''worse'' dan superlative ''worst''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('worst',FALSE,0),('bader',FALSE,1),('more bad',FALSE,2),('worse',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7AF3EDE4F64371816004',m.id,l.id,'Choose the superlative for ''bad''.','easy','''bad'' memiliki superlative ''worst''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('worst',TRUE,0),('worse',FALSE,1),('badest',FALSE,2),('most bad',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4697D1042AD2393E208A',m.id,l.id,'Choose the comparative for ''many''.','hard','''many'' memiliki comparative ''more'' dan superlative ''most''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more',TRUE,0),('most',FALSE,1),('manyer',FALSE,2),('manyest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-ADDAB3D882239CF72AF9',m.id,l.id,'Choose the superlative for ''many''.','medium','''many'' memiliki superlative ''most''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most',TRUE,0),('more',FALSE,1),('manyest',FALSE,2),('manyer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A3611FA74A9FB8BA6DC0',m.id,l.id,'Choose the comparative for ''much''.','easy','''much'' memiliki comparative ''more'' dan superlative ''most''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most',FALSE,0),('mucher',FALSE,1),('muchest',FALSE,2),('more',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2795108AFC71F92DF996',m.id,l.id,'Choose the superlative for ''much''.','hard','''much'' memiliki superlative ''most''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('muchest',FALSE,0),('mucher',FALSE,1),('most',TRUE,2),('more',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C6AEA5EB2D7E038ABBBD',m.id,l.id,'Choose the comparative for ''little''.','easy','''little'' memiliki comparative ''less'' dan superlative ''least''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('least',FALSE,0),('littleer',FALSE,1),('more little',FALSE,2),('less',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4D4D0A157495C80F4F67',m.id,l.id,'Choose the superlative for ''little''.','easy','''little'' memiliki superlative ''least''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most little',FALSE,0),('least',TRUE,1),('less',FALSE,2),('littleest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6337C90584656B8C8760',m.id,l.id,'Choose the comparative for ''far''.','easy','''far'' memiliki comparative ''farther'' dan superlative ''farthest''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('more far',FALSE,0),('farther',TRUE,1),('farthest',FALSE,2),('farer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-61AEB3D59653BBE51778',m.id,l.id,'Choose the superlative for ''far''.','medium','''far'' memiliki superlative ''farthest''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most far',FALSE,0),('farthest',TRUE,1),('farther',FALSE,2),('farest',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9290DBA14EE8367026E0',m.id,l.id,'Complete: This test is _____ than the previous one. (good)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('goodest',FALSE,0),('better',TRUE,1),('best',FALSE,2),('gooder',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-41C48468855EBEDA1DD2',m.id,l.id,'Complete: He is the _____ player on the team. (good)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('best',TRUE,0),('better',FALSE,1),('gooder',FALSE,2),('more good',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3B9527A636F9DE79971A',m.id,l.id,'Complete: The weather is _____ today than yesterday. (bad)','medium','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('badder',FALSE,0),('baddest',FALSE,1),('worse',TRUE,2),('worst',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EC43ED1AA6A83C370F07',m.id,l.id,'Complete: This is the _____ storm this month. (bad)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('badder',FALSE,0),('most worse',FALSE,1),('worst',TRUE,2),('worse',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1F180F8A53A2E979235F',m.id,l.id,'Complete: We need _____ chairs than before. (many)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('manyer',FALSE,0),('muchest',FALSE,1),('more',TRUE,2),('most',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-DD6A5B8529C0C197680F',m.id,l.id,'Complete: The class with the _____ students wins. (many)','medium','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('mucher',FALSE,0),('most',TRUE,1),('more',FALSE,2),('manyer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E0FB115CC57DAFE3B4A',m.id,l.id,'Complete: We have _____ time than yesterday. (little)','medium','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('littlest',FALSE,0),('less',TRUE,1),('least',FALSE,2),('littler',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1331AEDEF38E428D8599',m.id,l.id,'Complete: This is the _____ expensive item on the list. (little)','medium','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('little',FALSE,0),('littler',FALSE,1),('least',TRUE,2),('less',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-305575B7AFB8BD4C583E',m.id,l.id,'Complete: My hometown is _____ from here than yours. (far)','easy','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('farthest',FALSE,0),('farer',FALSE,1),('most far',FALSE,2),('farther',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2F9931E4EE50BE134040',m.id,l.id,'Complete: Which station is the _____ from the airport? (far)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('farthest',TRUE,0),('farther',FALSE,1),('more far',FALSE,2),('farer',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B29981274BEAF18F300C',m.id,l.id,'Complete: She has _____ experience than he does. (much)','easy','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most',FALSE,0),('muchs',FALSE,1),('mucher',FALSE,2),('more',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5EFC9870F296ADF0DF02',m.id,l.id,'Complete: This shop has the _____ variety. (much)','medium','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('most',TRUE,0),('more',FALSE,1),('muchest',FALSE,2),('mucher',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9544C167AC2F2DADBBA',m.id,l.id,'Complete: His score is _____ than mine. (good)','hard','Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='irregular-comparison' WHERE m.slug='degrees-comparison'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('gooder',FALSE,0),('more good',FALSE,1),('better',TRUE,2),('best',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5D26101E040C1440C1FE',m.id,l.id,'Choose the best English expression for: persimpangan','medium','''persimpangan'' dalam konteks materi ini diterjemahkan menjadi ''intersection''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('roundabout',FALSE,0),('traffic lights',FALSE,1),('intersection',TRUE,2),('T-junction',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BD526A5E9D1319A6FA2A',m.id,l.id,'What is the Indonesian meaning of ''intersection''?','medium','Dalam konteks materi, ''intersection'' bermakna ''persimpangan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('penyeberangan pejalan kaki',FALSE,0),('lurus ke depan',FALSE,1),('persimpangan',TRUE,2),('bundaran',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-222D1F38E794E48C38A5',m.id,l.id,'Choose the best English expression for: pertigaan','easy','''pertigaan'' dalam konteks materi ini diterjemahkan menjadi ''T-junction''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('T-junction',TRUE,0),('roundabout',FALSE,1),('traffic lights',FALSE,2),('pedestrian crossing',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-14E880681A82B0970A45',m.id,l.id,'What is the Indonesian meaning of ''T-junction''?','easy','Dalam konteks materi, ''T-junction'' bermakna ''pertigaan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('pertigaan',TRUE,0),('lampu lalu lintas',FALSE,1),('perempatan',FALSE,2),('di sebelah kiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E753D37F57C521EAD32',m.id,l.id,'Choose the best English expression for: bundaran','medium','''bundaran'' dalam konteks materi ini diterjemahkan menjadi ''roundabout''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('traffic lights',FALSE,0),('pedestrian crossing',FALSE,1),('crossroads',FALSE,2),('roundabout',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE978B4FE8AFA96DF2F7',m.id,l.id,'What is the Indonesian meaning of ''roundabout''?','medium','Dalam konteks materi, ''roundabout'' bermakna ''bundaran''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('penyeberangan pejalan kaki',FALSE,0),('lurus ke depan',FALSE,1),('di sebelah kanan',FALSE,2),('bundaran',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CB0EF6517175B5DE9FCF',m.id,l.id,'Choose the best English expression for: lampu lalu lintas','easy','''lampu lalu lintas'' dalam konteks materi ini diterjemahkan menjadi ''traffic lights''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('straight ahead',FALSE,0),('traffic lights',TRUE,1),('pedestrian crossing',FALSE,2),('crossroads',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-9CA333B938EE125BEC43',m.id,l.id,'What is the Indonesian meaning of ''traffic lights''?','medium','Dalam konteks materi, ''traffic lights'' bermakna ''lampu lalu lintas''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('berhadapan di seberang',FALSE,0),('lampu lalu lintas',TRUE,1),('perempatan',FALSE,2),('di sebelah kiri',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1F2B7C3EBDF5ECCCF997',m.id,l.id,'Choose the best English expression for: penyeberangan pejalan kaki','medium','''penyeberangan pejalan kaki'' dalam konteks materi ini diterjemahkan menjadi ''pedestrian crossing''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('straight ahead',FALSE,0),('on the left',FALSE,1),('pedestrian crossing',TRUE,2),('crossroads',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-998DDEE265E0CFF3A6A8',m.id,l.id,'What is the Indonesian meaning of ''pedestrian crossing''?','medium','Dalam konteks materi, ''pedestrian crossing'' bermakna ''penyeberangan pejalan kaki''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('di sebelah kanan',FALSE,0),('tepat di samping',FALSE,1),('penyeberangan pejalan kaki',TRUE,2),('lurus ke depan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FA758EAA53922FE07C34',m.id,l.id,'Choose the best English expression for: perempatan','hard','''perempatan'' dalam konteks materi ini diterjemahkan menjadi ''crossroads''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on the left',FALSE,0),('on the right',FALSE,1),('crossroads',TRUE,2),('straight ahead',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-59085D985570A8774D62',m.id,l.id,'What is the Indonesian meaning of ''crossroads''?','medium','Dalam konteks materi, ''crossroads'' bermakna ''perempatan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('perempatan',TRUE,0),('di sebelah kiri',FALSE,1),('berhadapan di seberang',FALSE,2),('dekat',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-848B07DCF93485C4F1C3',m.id,l.id,'Choose the best English expression for: lurus ke depan','easy','''lurus ke depan'' dalam konteks materi ini diterjemahkan menjadi ''straight ahead''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('straight ahead',TRUE,0),('on the left',FALSE,1),('on the right',FALSE,2),('opposite',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-27CDFCD8E0E3B3CA7425',m.id,l.id,'What is the Indonesian meaning of ''straight ahead''?','medium','Dalam konteks materi, ''straight ahead'' bermakna ''lurus ke depan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('lurus ke depan',TRUE,0),('di sebelah kanan',FALSE,1),('tepat di samping',FALSE,2),('di belakang',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8F0E199687BB9F3C1A73',m.id,l.id,'Choose the best English expression for: di sebelah kiri','medium','''di sebelah kiri'' dalam konteks materi ini diterjemahkan menjadi ''on the left''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('opposite',FALSE,0),('next to',FALSE,1),('on the left',TRUE,2),('on the right',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-339315B3B42ADB33DB9D',m.id,l.id,'What is the Indonesian meaning of ''on the left''?','easy','Dalam konteks materi, ''on the left'' bermakna ''di sebelah kiri''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('berhadapan di seberang',FALSE,0),('dekat',FALSE,1),('di depan',FALSE,2),('di sebelah kiri',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EF11D84F13DB59583787',m.id,l.id,'Choose the best English expression for: di sebelah kanan','medium','''di sebelah kanan'' dalam konteks materi ini diterjemahkan menjadi ''on the right''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('opposite',FALSE,0),('next to',FALSE,1),('near',FALSE,2),('on the right',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B41758DC92DE591167C3',m.id,l.id,'What is the Indonesian meaning of ''on the right''?','easy','Dalam konteks materi, ''on the right'' bermakna ''di sebelah kanan''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('di sebelah kanan',TRUE,0),('tepat di samping',FALSE,1),('di belakang',FALSE,2),('di antara dua lokasi',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A34111892EFF6864487C',m.id,l.id,'Choose the best English expression for: berhadapan di seberang','medium','''berhadapan di seberang'' dalam konteks materi ini diterjemahkan menjadi ''opposite''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('behind',FALSE,0),('opposite',TRUE,1),('next to',FALSE,2),('near',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3EC46A0EB5B697DCC1A1',m.id,l.id,'What is the Indonesian meaning of ''opposite''?','hard','Dalam konteks materi, ''opposite'' bermakna ''berhadapan di seberang''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('di depan',FALSE,0),('persimpangan',FALSE,1),('berhadapan di seberang',TRUE,2),('dekat',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0C4F291C9855A8F2AEBD',m.id,l.id,'Choose the best English expression for: tepat di samping','hard','''tepat di samping'' dalam konteks materi ini diterjemahkan menjadi ''next to''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('next to',TRUE,0),('near',FALSE,1),('behind',FALSE,2),('in front of',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8587F7B67780C991BB66',m.id,l.id,'What is the Indonesian meaning of ''next to''?','hard','Dalam konteks materi, ''next to'' bermakna ''tepat di samping''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('di antara dua lokasi',FALSE,0),('pertigaan',FALSE,1),('tepat di samping',TRUE,2),('di belakang',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-868F8EF3C541DCC6BE54',m.id,l.id,'Choose the best English expression for: dekat','hard','''dekat'' dalam konteks materi ini diterjemahkan menjadi ''near''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('behind',FALSE,0),('in front of',FALSE,1),('between',FALSE,2),('near',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5998734554DE2865E842',m.id,l.id,'What is the Indonesian meaning of ''near''?','easy','Dalam konteks materi, ''near'' bermakna ''dekat''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('bundaran',FALSE,0),('dekat',TRUE,1),('di depan',FALSE,2),('persimpangan',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-16ABE4044CCC8036E6BD',m.id,l.id,'Choose the best English expression for: di belakang','easy','''di belakang'' dalam konteks materi ini diterjemahkan menjadi ''behind''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='direction-vocabulary' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('behind',TRUE,0),('in front of',FALSE,1),('between',FALSE,2),('intersection',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A81B092877A264F924AA',m.id,l.id,'Choose the best English expression for: Jalan lurus ke depan.','easy','''Jalan lurus ke depan.'' dalam konteks materi ini diterjemahkan menjadi ''Go straight ahead.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Go straight ahead.',TRUE,0),('Turn left at the lights.',FALSE,1),('Turn right at the junction.',FALSE,2),('Cross the road carefully.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F0FB50FD71D2A9CD8E2D',m.id,l.id,'What is the Indonesian meaning of ''Go straight ahead.''?','medium','Dalam konteks materi, ''Go straight ahead.'' bermakna ''Jalan lurus ke depan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Putar balik di tempat yang diizinkan.',FALSE,0),('Jalan lurus ke depan.',TRUE,1),('Belok kanan di persimpangan.',FALSE,2),('Berjalan melewati bank.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B01261836D35CAC54283',m.id,l.id,'Choose the best English expression for: Belok kiri di lampu lalu lintas.','easy','''Belok kiri di lampu lalu lintas.'' dalam konteks materi ini diterjemahkan menjadi ''Turn left at the lights.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Turn right at the junction.',FALSE,0),('Cross the road carefully.',FALSE,1),('Walk past the bank.',FALSE,2),('Turn left at the lights.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EECFC5A14BDFF5E55F15',m.id,l.id,'What is the Indonesian meaning of ''Turn left at the lights.''?','medium','Dalam konteks materi, ''Turn left at the lights.'' bermakna ''Belok kiri di lampu lalu lintas.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berhenti di persimpangan.',FALSE,0),('Belok kiri di lampu lalu lintas.',TRUE,1),('Seberangi jalan dengan hati-hati.',FALSE,2),('Ambil jalan keluar kedua.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7D38F823D5DB391E5D58',m.id,l.id,'Choose the best English expression for: Belok kanan di persimpangan.','easy','''Belok kanan di persimpangan.'' dalam konteks materi ini diterjemahkan menjadi ''Turn right at the junction.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Cross the road carefully.',FALSE,0),('Walk past the bank.',FALSE,1),('Take the second exit.',FALSE,2),('Turn right at the junction.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB5B5FCA5A699E1696AD',m.id,l.id,'What is the Indonesian meaning of ''Turn right at the junction.''?','easy','Dalam konteks materi, ''Turn right at the junction.'' bermakna ''Belok kanan di persimpangan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Putar balik di tempat yang diizinkan.',FALSE,0),('Terus berjalan sepanjang jalan ini.',FALSE,1),('Belok kanan di persimpangan.',TRUE,2),('Berjalan melewati bank.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-01B94595BA0F960E56BA',m.id,l.id,'Choose the best English expression for: Seberangi jalan dengan hati-hati.','hard','''Seberangi jalan dengan hati-hati.'' dalam konteks materi ini diterjemahkan menjadi ''Cross the road carefully.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Make a U-turn where permitted.',FALSE,0),('Cross the road carefully.',TRUE,1),('Walk past the bank.',FALSE,2),('Take the second exit.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BDBC6E1ADF97A7AE4AF9',m.id,l.id,'What is the Indonesian meaning of ''Cross the road carefully.''?','medium','Dalam konteks materi, ''Cross the road carefully.'' bermakna ''Seberangi jalan dengan hati-hati.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berhenti di persimpangan.',FALSE,0),('Lanjutkan sampai lampu lalu lintas.',FALSE,1),('Seberangi jalan dengan hati-hati.',TRUE,2),('Ambil jalan keluar kedua.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-B0A781A00927F667053F',m.id,l.id,'Choose the best English expression for: Berjalan melewati bank.','medium','''Berjalan melewati bank.'' dalam konteks materi ini diterjemahkan menjadi ''Walk past the bank.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Walk past the bank.',TRUE,0),('Take the second exit.',FALSE,1),('Make a U-turn where permitted.',FALSE,2),('Stop at the intersection.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-45C6CBD8FFDB02E2C318',m.id,l.id,'What is the Indonesian meaning of ''Walk past the bank.''?','easy','Dalam konteks materi, ''Walk past the bank.'' bermakna ''Berjalan melewati bank.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berjalan melewati bank.',TRUE,0),('Putar balik di tempat yang diizinkan.',FALSE,1),('Terus berjalan sepanjang jalan ini.',FALSE,2),('Lewati jembatan.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-11B272EE42C243133EBB',m.id,l.id,'Choose the best English expression for: Ambil jalan keluar kedua.','medium','''Ambil jalan keluar kedua.'' dalam konteks materi ini diterjemahkan menjadi ''Take the second exit.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Stop at the intersection.',FALSE,0),('Keep walking along this street.',FALSE,1),('Take the second exit.',TRUE,2),('Make a U-turn where permitted.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AC875D0D2780AA8EFACD',m.id,l.id,'What is the Indonesian meaning of ''Take the second exit.''?','hard','Dalam konteks materi, ''Take the second exit.'' bermakna ''Ambil jalan keluar kedua.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berjalan melewati bagian dalam taman.',FALSE,0),('Ambil jalan keluar kedua.',TRUE,1),('Berhenti di persimpangan.',FALSE,2),('Lanjutkan sampai lampu lalu lintas.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EC953E89F629858E535E',m.id,l.id,'Choose the best English expression for: Putar balik di tempat yang diizinkan.','medium','''Putar balik di tempat yang diizinkan.'' dalam konteks materi ini diterjemahkan menjadi ''Make a U-turn where permitted.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Continue until the traffic lights.',FALSE,0),('Make a U-turn where permitted.',TRUE,1),('Stop at the intersection.',FALSE,2),('Keep walking along this street.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-96B5DA48CD92F553FF29',m.id,l.id,'What is the Indonesian meaning of ''Make a U-turn where permitted.''?','medium','Dalam konteks materi, ''Make a U-turn where permitted.'' bermakna ''Putar balik di tempat yang diizinkan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Putar balik di tempat yang diizinkan.',TRUE,0),('Terus berjalan sepanjang jalan ini.',FALSE,1),('Lewati jembatan.',FALSE,2),('Ambil jalan pertama di sebelah kiri.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-115CEA52D9A4040BC204',m.id,l.id,'Choose the best English expression for: Berhenti di persimpangan.','easy','''Berhenti di persimpangan.'' dalam konteks materi ini diterjemahkan menjadi ''Stop at the intersection.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Continue until the traffic lights.',FALSE,0),('Go over the bridge.',FALSE,1),('Stop at the intersection.',TRUE,2),('Keep walking along this street.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D9A99C9B39366EF715AE',m.id,l.id,'What is the Indonesian meaning of ''Stop at the intersection.''?','easy','Dalam konteks materi, ''Stop at the intersection.'' bermakna ''Berhenti di persimpangan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Lanjutkan sampai lampu lalu lintas.',FALSE,0),('Berjalan melewati bagian dalam taman.',FALSE,1),('Ikuti rambu menuju rumah sakit.',FALSE,2),('Berhenti di persimpangan.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F9C54B3853528A5553CF',m.id,l.id,'Choose the best English expression for: Terus berjalan sepanjang jalan ini.','medium','''Terus berjalan sepanjang jalan ini.'' dalam konteks materi ini diterjemahkan menjadi ''Keep walking along this street.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Keep walking along this street.',TRUE,0),('Continue until the traffic lights.',FALSE,1),('Go over the bridge.',FALSE,2),('Walk through the park.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-90796391B9CD706384E9',m.id,l.id,'What is the Indonesian meaning of ''Keep walking along this street.''?','medium','Dalam konteks materi, ''Keep walking along this street.'' bermakna ''Terus berjalan sepanjang jalan ini.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berbalik arah lalu jalan lurus.',FALSE,0),('Terus berjalan sepanjang jalan ini.',TRUE,1),('Lewati jembatan.',FALSE,2),('Ambil jalan pertama di sebelah kiri.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E5255C57D4241A1E56B8',m.id,l.id,'Choose the best English expression for: Lanjutkan sampai lampu lalu lintas.','medium','''Lanjutkan sampai lampu lalu lintas.'' dalam konteks materi ini diterjemahkan menjadi ''Continue until the traffic lights.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Go over the bridge.',FALSE,0),('Walk through the park.',FALSE,1),('Take the first street on your left.',FALSE,2),('Continue until the traffic lights.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CD83B1E274286CEAB77F',m.id,l.id,'What is the Indonesian meaning of ''Continue until the traffic lights.''?','easy','Dalam konteks materi, ''Continue until the traffic lights.'' bermakna ''Lanjutkan sampai lampu lalu lintas.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Ikuti rambu menuju rumah sakit.',FALSE,0),('Jalan lurus ke depan.',FALSE,1),('Lanjutkan sampai lampu lalu lintas.',TRUE,2),('Berjalan melewati bagian dalam taman.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6F4A5FC65C64D28C3A80',m.id,l.id,'Choose the best English expression for: Lewati jembatan.','hard','''Lewati jembatan.'' dalam konteks materi ini diterjemahkan menjadi ''Go over the bridge.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Take the first street on your left.',FALSE,0),('Follow the signs to the hospital.',FALSE,1),('Go over the bridge.',TRUE,2),('Walk through the park.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5B6BF274E206A084C5FB',m.id,l.id,'What is the Indonesian meaning of ''Go over the bridge.''?','hard','Dalam konteks materi, ''Go over the bridge.'' bermakna ''Lewati jembatan.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Lewati jembatan.',TRUE,0),('Ambil jalan pertama di sebelah kiri.',FALSE,1),('Berbalik arah lalu jalan lurus.',FALSE,2),('Belok kiri di lampu lalu lintas.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-CF844ACFB95255F2B8A0',m.id,l.id,'Choose the best English expression for: Berjalan melewati bagian dalam taman.','easy','''Berjalan melewati bagian dalam taman.'' dalam konteks materi ini diterjemahkan menjadi ''Walk through the park.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Take the first street on your left.',FALSE,0),('Follow the signs to the hospital.',FALSE,1),('Turn back and go straight.',FALSE,2),('Walk through the park.',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-467D1FCC5CC9615E5C96',m.id,l.id,'What is the Indonesian meaning of ''Walk through the park.''?','medium','Dalam konteks materi, ''Walk through the park.'' bermakna ''Berjalan melewati bagian dalam taman.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Berjalan melewati bagian dalam taman.',TRUE,0),('Ikuti rambu menuju rumah sakit.',FALSE,1),('Jalan lurus ke depan.',FALSE,2),('Belok kanan di persimpangan.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3109B2FD938A722E2457',m.id,l.id,'Choose the best English expression for: Ambil jalan pertama di sebelah kiri.','medium','''Ambil jalan pertama di sebelah kiri.'' dalam konteks materi ini diterjemahkan menjadi ''Take the first street on your left.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='giving-instructions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Go straight ahead.',FALSE,0),('Take the first street on your left.',TRUE,1),('Follow the signs to the hospital.',FALSE,2),('Turn back and go straight.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4E101AA8334FA710E590',m.id,l.id,'Choose the best English expression for: Di mana rumah sakit terdekat?','medium','''Di mana rumah sakit terdekat?'' dalam konteks materi ini diterjemahkan menjadi ''Where is the nearest hospital?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Where is the nearest hospital?',TRUE,0),('Could you show me the way?',FALSE,1),('How do I get to the station?',FALSE,2),('Is there a bank near here?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F576864B049CF6A275F3',m.id,l.id,'What is the Indonesian meaning of ''Where is the nearest hospital?''?','medium','Dalam konteks materi, ''Where is the nearest hospital?'' bermakna ''Di mana rumah sakit terdekat?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bagaimana cara menuju stasiun?',FALSE,0),('Bisa tolong ulangi?',FALSE,1),('Bisakah saya berjalan kaki ke sana?',FALSE,2),('Di mana rumah sakit terdekat?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1D3F2C680F972EA64FBD',m.id,l.id,'Choose the best English expression for: Bisakah Anda menunjukkan jalannya?','easy','''Bisakah Anda menunjukkan jalannya?'' dalam konteks materi ini diterjemahkan menjadi ''Could you show me the way?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Could you show me the way?',TRUE,0),('How do I get to the station?',FALSE,1),('Is there a bank near here?',FALSE,2),('Could you repeat that, please?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-077BBC6AD7E142835073',m.id,l.id,'What is the Indonesian meaning of ''Could you show me the way?''?','medium','Dalam konteks materi, ''Could you show me the way?'' bermakna ''Bisakah Anda menunjukkan jalannya?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Apakah jauh dari sini?',FALSE,0),('Ke arah mana perpustakaan?',FALSE,1),('Bisakah Anda menunjukkan jalannya?',TRUE,2),('Apakah ada bank di dekat sini?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-C0661E2EDE355BE1EDBA',m.id,l.id,'Choose the best English expression for: Bagaimana cara menuju stasiun?','easy','''Bagaimana cara menuju stasiun?'' dalam konteks materi ini diterjemahkan menjadi ''How do I get to the station?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Could you repeat that, please?',FALSE,0),('Is it far from here?',FALSE,1),('How do I get to the station?',TRUE,2),('Is there a bank near here?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-285F2DB22BD568C029C2',m.id,l.id,'What is the Indonesian meaning of ''How do I get to the station?''?','easy','Dalam konteks materi, ''How do I get to the station?'' bermakna ''Bagaimana cara menuju stasiun?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bisakah saya berjalan kaki ke sana?',FALSE,0),('Terima kasih atas bantuan Anda.',FALSE,1),('Bagaimana cara menuju stasiun?',TRUE,2),('Bisa tolong ulangi?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-0A63A8401C0802C34C7E',m.id,l.id,'Choose the best English expression for: Apakah ada bank di dekat sini?','hard','''Apakah ada bank di dekat sini?'' dalam konteks materi ini diterjemahkan menjadi ''Is there a bank near here?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Is there a bank near here?',TRUE,0),('Could you repeat that, please?',FALSE,1),('Is it far from here?',FALSE,2),('Can I walk there?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-73B3B061293616620A66',m.id,l.id,'What is the Indonesian meaning of ''Is there a bank near here?''?','hard','Dalam konteks materi, ''Is there a bank near here?'' bermakna ''Apakah ada bank di dekat sini?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Sama-sama.',FALSE,0),('Apakah ada bank di dekat sini?',TRUE,1),('Apakah jauh dari sini?',FALSE,2),('Ke arah mana perpustakaan?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BE0E28862793E3FB1C86',m.id,l.id,'Choose the best English expression for: Bisa tolong ulangi?','medium','''Bisa tolong ulangi?'' dalam konteks materi ini diterjemahkan menjadi ''Could you repeat that, please?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Can I walk there?',FALSE,0),('Which way is the library?',FALSE,1),('Could you repeat that, please?',TRUE,2),('Is it far from here?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FED007621804D0D39A23',m.id,l.id,'What is the Indonesian meaning of ''Could you repeat that, please?''?','easy','Dalam konteks materi, ''Could you repeat that, please?'' bermakna ''Bisa tolong ulangi?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Terima kasih atas bantuan Anda.',FALSE,0),('Permisi, boleh saya bertanya?',FALSE,1),('Bisa tolong ulangi?',TRUE,2),('Bisakah saya berjalan kaki ke sana?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BD59622AD304C672CAC',m.id,l.id,'Choose the best English expression for: Apakah jauh dari sini?','medium','''Apakah jauh dari sini?'' dalam konteks materi ini diterjemahkan menjadi ''Is it far from here?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Which way is the library?',FALSE,0),('Thank you for your help.',FALSE,1),('Is it far from here?',TRUE,2),('Can I walk there?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BDB68581023DDF0B25AF',m.id,l.id,'What is the Indonesian meaning of ''Is it far from here?''?','easy','Dalam konteks materi, ''Is it far from here?'' bermakna ''Apakah jauh dari sini?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Apakah di kiri atau di kanan?',FALSE,0),('Apakah jauh dari sini?',TRUE,1),('Ke arah mana perpustakaan?',FALSE,2),('Sama-sama.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4BC49C5083C7D2B08158',m.id,l.id,'Choose the best English expression for: Bisakah saya berjalan kaki ke sana?','hard','''Bisakah saya berjalan kaki ke sana?'' dalam konteks materi ini diterjemahkan menjadi ''Can I walk there?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Can I walk there?',TRUE,0),('Which way is the library?',FALSE,1),('Thank you for your help.',FALSE,2),('You''re welcome.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-F2E1D8BE863D930AF918',m.id,l.id,'What is the Indonesian meaning of ''Can I walk there?''?','medium','Dalam konteks materi, ''Can I walk there?'' bermakna ''Bisakah saya berjalan kaki ke sana?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Permisi, boleh saya bertanya?',FALSE,0),('Di mana halte bus?',FALSE,1),('Bisakah saya berjalan kaki ke sana?',TRUE,2),('Terima kasih atas bantuan Anda.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-FE2CDBF14D9DD4A4F9AD',m.id,l.id,'Choose the best English expression for: Ke arah mana perpustakaan?','medium','''Ke arah mana perpustakaan?'' dalam konteks materi ini diterjemahkan menjadi ''Which way is the library?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Excuse me, may I ask a question?',FALSE,0),('Which way is the library?',TRUE,1),('Thank you for your help.',FALSE,2),('You''re welcome.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-28398D403F1A14E8FC9D',m.id,l.id,'What is the Indonesian meaning of ''Which way is the library?''?','hard','Dalam konteks materi, ''Which way is the library?'' bermakna ''Ke arah mana perpustakaan?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Ke arah mana perpustakaan?',TRUE,0),('Sama-sama.',FALSE,1),('Apakah di kiri atau di kanan?',FALSE,2),('Bisa bicara lebih pelan?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-7A486144A6B0F522DD08',m.id,l.id,'Choose the best English expression for: Terima kasih atas bantuan Anda.','easy','''Terima kasih atas bantuan Anda.'' dalam konteks materi ini diterjemahkan menjadi ''Thank you for your help.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Thank you for your help.',TRUE,0),('You''re welcome.',FALSE,1),('Excuse me, may I ask a question?',FALSE,2),('Is it on the left or right?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D2137F7AB0F4D350948C',m.id,l.id,'What is the Indonesian meaning of ''Thank you for your help.''?','easy','Dalam konteks materi, ''Thank you for your help.'' bermakna ''Terima kasih atas bantuan Anda.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Di mana halte bus?',FALSE,0),('Seberapa jauh museum itu?',FALSE,1),('Terima kasih atas bantuan Anda.',TRUE,2),('Permisi, boleh saya bertanya?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-00B03EC8DAF43E445E5B',m.id,l.id,'Choose the best English expression for: Sama-sama.','medium','''Sama-sama.'' dalam konteks materi ini diterjemahkan menjadi ''You''re welcome.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('You''re welcome.',TRUE,0),('Excuse me, may I ask a question?',FALSE,1),('Is it on the left or right?',FALSE,2),('Where is the bus stop?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-59544A5C47510B13F005',m.id,l.id,'What is the Indonesian meaning of ''You''re welcome.''?','hard','Dalam konteks materi, ''You''re welcome.'' bermakna ''Sama-sama.''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Sama-sama.',TRUE,0),('Apakah di kiri atau di kanan?',FALSE,1),('Bisa bicara lebih pelan?',FALSE,2),('Di mana rumah sakit terdekat?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D406B73B48B53CDBDBDF',m.id,l.id,'Choose the best English expression for: Permisi, boleh saya bertanya?','medium','''Permisi, boleh saya bertanya?'' dalam konteks materi ini diterjemahkan menjadi ''Excuse me, may I ask a question?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Is it on the left or right?',FALSE,0),('Where is the bus stop?',FALSE,1),('Could you speak more slowly?',FALSE,2),('Excuse me, may I ask a question?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-1204162AE3E176F0400C',m.id,l.id,'What is the Indonesian meaning of ''Excuse me, may I ask a question?''?','easy','Dalam konteks materi, ''Excuse me, may I ask a question?'' bermakna ''Permisi, boleh saya bertanya?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Seberapa jauh museum itu?',FALSE,0),('Bisakah Anda menunjukkan jalannya?',FALSE,1),('Permisi, boleh saya bertanya?',TRUE,2),('Di mana halte bus?',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EA539D0B23B3394B5205',m.id,l.id,'Choose the best English expression for: Apakah di kiri atau di kanan?','medium','''Apakah di kiri atau di kanan?'' dalam konteks materi ini diterjemahkan menjadi ''Is it on the left or right?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Where is the bus stop?',FALSE,0),('Could you speak more slowly?',FALSE,1),('How far is the museum?',FALSE,2),('Is it on the left or right?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-57F1E29F2A987B832A7B',m.id,l.id,'What is the Indonesian meaning of ''Is it on the left or right?''?','medium','Dalam konteks materi, ''Is it on the left or right?'' bermakna ''Apakah di kiri atau di kanan?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Bisa bicara lebih pelan?',FALSE,0),('Di mana rumah sakit terdekat?',FALSE,1),('Bagaimana cara menuju stasiun?',FALSE,2),('Apakah di kiri atau di kanan?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8902840BA206274437F8',m.id,l.id,'Choose the best English expression for: Di mana halte bus?','hard','''Di mana halte bus?'' dalam konteks materi ini diterjemahkan menjadi ''Where is the bus stop?''.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='asking-directions' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Could you speak more slowly?',FALSE,0),('How far is the museum?',FALSE,1),('Where is the nearest hospital?',FALSE,2),('Where is the bus stop?',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-52495872F864BAE34B16',m.id,l.id,'A: Where is the hospital? B: Go straight and _____ at the traffic lights. (left direction)','hard','Turn left adalah perintah untuk belok kiri.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('turn inside',FALSE,0),('turn under',FALSE,1),('turn left',TRUE,2),('turn up',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-75274557CCDDB02F29DB',m.id,l.id,'A: Which side is the bank? B: It is _____ your right.','easy','On your right adalah ekspresi posisi alami.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('in',FALSE,0),('through',FALSE,1),('under',FALSE,2),('on',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-47B037A4037116B56B4A',m.id,l.id,'A: Thank you! B: _____','medium','You''re welcome adalah jawaban sopan untuk terima kasih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('You''re welcome.',TRUE,0),('Where are you?',FALSE,1),('Turn back now.',FALSE,2),('It''s a lamp.',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-295827A975F3FB01C6BF',m.id,l.id,'A: Excuse me, _____ is the station? B: Next to the market.','easy','Where menanyakan lokasi.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('when',FALSE,0),('where',TRUE,1),('who',FALSE,2),('whose',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3523F83021582940954D',m.id,l.id,'A: How do I get to the library? B: _____ ahead for two blocks.','medium','Go straight ahead berarti terus lurus.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Go straight',TRUE,0),('Go left in',FALSE,1),('Sit down',FALSE,2),('Take asleep',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-2E85D25E547ABE5B5DE8',m.id,l.id,'A: Is the café far? B: No, it is _____ the bank.','medium','Next to menerangkan lokasi tepat di samping.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('over across',FALSE,0),('into',FALSE,1),('next to',TRUE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-EB1EFC846384F8694824',m.id,l.id,'A: Where is the supermarket? B: It is _____ the bank and the library.','hard','Between menghubungkan dua landmark.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('between',TRUE,0),('among',FALSE,1),('above',FALSE,2),('through',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-343C9D3C87ECDB72D5EF',m.id,l.id,'A: Which direction should I take? B: _____ at the T-junction.','hard','Turn right memberi instruksi berbelok kanan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Turn right',TRUE,0),('Turn above',FALSE,1),('Turn below',FALSE,2),('Turn inside',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4A5A3A11E9433D34D44A',m.id,l.id,'A: What should I do at the roundabout? B: Take the _____ exit.','hard','Second adalah bilangan ordinal untuk urutan pintu keluar.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('double',FALSE,0),('second',TRUE,1),('two',FALSE,2),('twice',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-8CA1637FF9407F7C8B10',m.id,l.id,'A: How can I reach the school? B: Walk _____ the bridge to the other side.','easy','Across menunjukkan menyeberang.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('into',FALSE,0),('beneath',FALSE,1),('inside',FALSE,2),('across',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-4516BAB54E47FF5204BE',m.id,l.id,'A: Is the post office nearby? B: Yes, it is just _____ the corner.','easy','Around the corner berarti dekat setelah berbelok sudut.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('through',FALSE,0),('around',TRUE,1),('into',FALSE,2),('beneath',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-BCEED0CDFE52BB9D571D',m.id,l.id,'A: Could you tell me _____ the museum is?','hard','Dalam indirect question, where the museum is memiliki urutan subject-verb.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('why',FALSE,0),('where',TRUE,1),('whose',FALSE,2),('whom',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A50723D9CB78EF9F51C1',m.id,l.id,'A: Could you show me the _____ to the hotel?','medium','Show me the way berarti menunjukkan rute.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('weight',FALSE,0),('way',TRUE,1),('week',FALSE,2),('weather',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-076F059B26008A5FE844',m.id,l.id,'A: Is it on the right? B: No, it''s on the _____.','medium','Left adalah lawan right.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('up',FALSE,0),('down',FALSE,1),('through',FALSE,2),('left',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-6CF85B4A20A3D92FB7B2',m.id,l.id,'A: Can you repeat that? B: Sure, _____ left at the light.','easy','Imperative menggunakan bentuk dasar turn.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('turns',FALSE,0),('turning',FALSE,1),('turn',TRUE,2),('turned',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-A804BDA30283FE92FD57',m.id,l.id,'A: What is ahead? B: You will see the traffic _____.','hard','Traffic lights berarti lampu lalu lintas.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('rivers',FALSE,0),('stairs',FALSE,1),('chairs',FALSE,2),('lights',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-3D30CB9D1E0CB8E44992',m.id,l.id,'A: Do we cross the road? B: Yes, use the pedestrian _____.','medium','Pedestrian crossing adalah penyeberangan pejalan kaki.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('bedroom',FALSE,0),('crossing',TRUE,1),('ceiling',FALSE,2),('counter',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-56996584EDE4E0B3E9DD',m.id,l.id,'A: What do I do next? B: Walk _____ the bank, then turn right.','medium','Walk past menunjukkan bergerak melewati bank.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('past',TRUE,0),('inside',FALSE,1),('under',FALSE,2),('above',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-AF17A8C105E7A727356A',m.id,l.id,'A: Is the pharmacy opposite the hospital? B: Yes, it is _____ the street.','medium','Across the street berarti di seberang jalan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('below',FALSE,0),('across',TRUE,1),('inside',FALSE,2),('between',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-326562C02083A1B86DC8',m.id,l.id,'A: I am lost. Can you _____ me?','medium','Setelah can gunakan bentuk dasar help.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('help',TRUE,0),('helps',FALSE,1),('helping',FALSE,2),('helped',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-5F9742B53760215520E5',m.id,l.id,'A: Is the café near the park? B: Yes, it is _____ to the park.','hard','Next to adalah ungkapan tetap untuk bersebelahan.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('under',FALSE,0),('next',TRUE,1),('through',FALSE,2),('out',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-774723312C6C4EBEE4B0',m.id,l.id,'A: How far is it? B: It''s within walking _____.','easy','Within walking distance artinya cukup dekat untuk berjalan kaki.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('corner',FALSE,0),('distance',TRUE,1),('hour',FALSE,2),('direction',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-E948C59987E6083D21B1',m.id,l.id,'A: Where should I stop? B: _____ at the pedestrian crossing.','hard','Imperative menggunakan verb dasar Stop.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('Stopped',FALSE,0),('Stop',TRUE,1),('Stops',FALSE,2),('Stopping',FALSE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D799731B8F26A41B4B6D',m.id,l.id,'A: Is there a shortcut? B: Go _____ the park instead of around it.','easy','Through the park berarti melewati interior taman.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('on',FALSE,0),('beneath',FALSE,1),('above',FALSE,2),('through',TRUE,3)) v(body,correct,idx);
WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT 'EXP-D5116B3B8C119160328F',m.id,l.id,'A: Thank you for the directions. B: My _____.','hard','My pleasure merupakan jawaban sopan setelah berterima kasih.'
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug='directions-dialogues' WHERE m.slug='giving-directions'
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES ('station',FALSE,0),('left',FALSE,1),('bridge',FALSE,2),('pleasure',TRUE,3)) v(body,correct,idx);
COMMIT;
