#!/usr/bin/env python3
"""Generate educationally reviewed course expansion data and idempotent PostgreSQL seed.
Run from project root: python3 scripts/build-expanded.py
"""
from pathlib import Path
from collections import defaultdict, Counter
import json, re, random, hashlib
ROOT=Path(__file__).resolve().parents[1]
LESSONS={}
QUESTIONS=[]

def lesson(module,slug,title,summary,body):
    assert module not in ('pronouns',)
    assert len(body)>=280,(module,slug,len(body))
    LESSONS.setdefault(module,[]).append(dict(module_slug=module,slug=slug,title=title,summary=summary,body_md=body.strip()))

def q(module,slug,stem,correct,wrongs,explain):
    assert len(wrongs)==3,(module,slug,stem,wrongs)
    opts=[str(correct)]+[str(x) for x in wrongs]
    assert len({x.strip().casefold() for x in opts})==4, (module,slug,stem,opts)
    assert len(str(stem).strip())>=10,(module,slug,stem)
    assert len(explain)>=15,(module,slug,stem,explain)
    QUESTIONS.append(dict(module_slug=module,lesson_slug=slug,stem=str(stem).strip(),correct=str(correct),wrongs=[str(x) for x in wrongs],explanation=explain))

# --- Lessons: content transcribed/adapted from the supplied handouts, with corrections where needed ---
lesson('alphabet-spelling','letter-names','English Alphabet A–Z','Pelafalan nama huruf, bukan bunyi huruf di dalam kata.', '''
# English Alphabet: A–Z
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

**Latihan:** SPELL: **B-A-G**, **C-A-T**, **E-X-A-M**. Ucapkan perlahan dulu, lalu naikkan kecepatan.
''')
lesson('alphabet-spelling','spelling-words','Spelling Words','Mengeja kata dari huruf menggunakan pelafalan alfabet Inggris.', '''
# Spelling Words
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

Coba eja nama kota, nama keluarga, dan kata benda di sekitarmu. Gunakan alfabet Inggris, bukan nama huruf Indonesia.
''')
lesson('alphabet-spelling','decode-spelling','Decode Letter Names','Mengubah rangkaian nama huruf menjadi kata yang benar.', '''
# Decode Letter Names
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

**Penting:** ejaan adalah bentuk tertulis. Jangan mengira bunyi kata selalu sama dengan nama setiap hurufnya.
''')
lesson('alphabet-spelling','spelling-context','Spelling in Daily Conversations','Bertanya dan menjawab ejaan pada situasi sehari-hari.', '''
# Spelling in Daily Conversations
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
B: *Yes, that's right.*

## Latihan mandiri
Tulis lima nama benda yang sering kamu pakai. Eja dengan lantang, lalu minta teman mengecek urutan huruf. Untuk email, **at** dibaca untuk @, dan **dot** untuk titik.
''')
lesson('family-vocabulary','family-members','Family Members','Hubungan keluarga inti, keluarga besar, dan kata ganti relasi.', '''
# Family Members
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

**Contoh:** *My uncle is my mother's brother.* (Pamanku adalah saudara laki-laki ibuku.)

**Latihan:** Jelaskan hubungan 4 anggota keluarga tanpa menyebut namanya terlebih dahulu.
''')
lesson('family-vocabulary','extended-family','Extended Family & Life Events','Istilah keluarga besar, mertua, dan status keluarga.', '''
# Extended Family & Life Events
Setiap hubungan perlu ditentukan dari sudut pandang orang yang berbicara.

- **father-in-law / mother-in-law** = ayah mertua / ibu mertua.
- **brother-in-law / sister-in-law** = ipar laki-laki / perempuan.
- **grandchild** = cucu; **grandson** dan **granddaughter** lebih spesifik.
- **widow** = janda karena pasangan meninggal; **widower** = duda karena pasangan meninggal.
- **orphan** = anak yatim/piatu (pengertian dapat berbeda menurut konteks).

## Contoh hubungan
*My wife's father is my father-in-law.*  
*My sister's son is my nephew.*  
*My aunt's daughter is my cousin.*

**Perhatikan:** *single* berarti belum menikah/tidak berpasangan; berbeda dengan *widow/widower* yang berkaitan dengan kematian pasangan.

**Latihan:** Tulis 3 kalimat menggunakan *in-law*, *cousin*, atau *grandchild*.
''')
lesson('family-vocabulary','greetings','Greetings and Leave-taking','Sapaan, perkenalan, menanyakan kabar, dan berpamitan.', '''
# Greetings
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
B: *I'm fine, thank you. And you?*  
A: *I'm doing well. Nice to meet you.*  
B: *Nice to meet you, too.*

**Perhatikan:** *Good evening* dipakai ketika bertemu, sedangkan *Good night* lazim dipakai saat berpisah. *How do you do?* adalah sapaan formal tradisional, bukan pertanyaan tentang cara melakukan sesuatu.
''')
lesson('family-vocabulary','seasons-periods','Seasons & Parts of the Day','Musim dan penamaan bagian hari.', '''
# Seasons & Parts of the Day
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

**Catatan:** kata *season* bisa mengikuti *in* (*in winter*) atau *during* (*during the dry season*). Tidak semua negara memiliki empat musim.
''')
lesson('cardinal-ordinal','cardinal-numbers','Cardinal Numbers','Bilangan pokok untuk menyatakan jumlah.', '''
# Cardinal Numbers
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

**Ingat:** *forty* bukan *fourty*, *fifteen* berbeda dari *fifty*, dan *thirteen* berbeda dari *thirty*.
''')
lesson('cardinal-ordinal','ordinal-numbers','Ordinal Numbers','Bilangan bertingkat untuk urutan dan tanggal.', '''
# Ordinal Numbers
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

**Aturan akhiran:** 1st, 2nd, 3rd, angka lain umumnya *-th*, **kecuali** 11th, 12th, 13th. Angka gabungan mengikuti dua digit terakhir: 21st, 22nd, 23rd, 24th.
''')
lesson('cardinal-ordinal','decimals-years','Decimals, Big Numbers & Years','Pemisah ribuan, desimal, nomor dan penyebutan tahun.', '''
# Decimals, Big Numbers & Years
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

**Catatan:** jangan menghilangkan nol di belakang desimal jika sedang mengeja angka sesuai yang tertulis (mis. 1.20).
''')
lesson('cardinal-ordinal','fractions-math','Fractions & Basic Math','Pecahan dan operasi hitung dalam bahasa Inggris.', '''
# Fractions & Basic Math
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

**Ingat:** ketika pembilang lebih dari satu, penyebut biasanya berbentuk plural: *two thirds*, bukan *two third*. Gunakan kata **equals** atau **is equal to** untuk tanda =.
''')
lesson('telling-time-dates','telling-time','Telling the Time','Membaca jam dengan past, to, quarter, half, dan o’clock.', '''
# Telling the Time
Ada dua gaya populer: gaya digital (*seven ten*) dan gaya percakapan (*ten past seven*).

## Pola
- **07:00** = seven o'clock.
- **07:10** = ten past seven.
- **11:15** = a quarter past eleven.
- **06:30** = half past six.
- **10:45** = a quarter to eleven.
- **08:55** = five to nine.

**Past** digunakan untuk menit 1–30, **to** untuk menit 31–59 dan menyebut jam berikutnya. *Quarter* = 15 menit; *half* = 30 menit.

**AM/PM:** 8:00 a.m. = jam delapan pagi; 8:00 p.m. = jam delapan malam. Pukul 12:00 tengah hari = **noon**, sedangkan 00:00 = **midnight**.

**Pertanyaan:** *What time is it?* → *It's half past eight.*
''')
lesson('telling-time-dates','days-months','Days, Months & Time Expressions','Nama hari, bulan, dan pemakaian preposisi on/in/at.', '''
# Days & Months
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

**Jangan tertukar:** *on March 20th* untuk tanggal lengkap, tetapi *in March* untuk bulan saja.
''')
lesson('telling-time-dates','british-american-dates','British & American Dates','Perbedaan format penulisan dan pembacaan tanggal.', '''
# Dates: British vs American English
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

**Tips:** Untuk dokumen internasional, bentuk ISO **2026-03-20** dapat mengurangi salah tafsir angka tanggal.
''')
lesson('telling-time-dates','time-practice','Telling Time in Context','Membicarakan jadwal, durasi, dan kebiasaan.', '''
# Time in Context
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

**Perhatikan:** *every day* (dua kata) berarti setiap hari; *everyday* (satu kata) adalah adjective seperti *everyday activities*.
''')
lesson('countable-uncountable','countable-vs-uncountable','Countable vs Uncountable','Membedakan benda yang dapat dihitung dan yang diukur.', '''
# Countable vs Uncountable Nouns
**Countable nouns** memiliki satuan individual: *a book, two books, three chairs*. **Uncountable nouns** biasanya diperlakukan sebagai zat, gagasan, atau keseluruhan: *water, rice, information, furniture*.

## Contoh
| Countable | Uncountable |
|---|---|
| book, apple, student, chair | milk, sugar, advice, music |
| tomato, bag, picture, egg | water, furniture, information, homework |

Countable tunggal memakai **a/an** atau penentu lain. Uncountable umumnya tidak memakai **a/an** secara langsung.

❌ *an information* → ✅ *some information* / *a piece of information*.

**Pengecualian konteks:** *coffee* dapat berarti minuman secara umum (uncountable) atau *a coffee* = satu cangkir kopi saat memesan. **Chicken** dapat berarti ayam sebagai hewan (countable) atau daging ayam (uncountable).
''')
lesson('countable-uncountable','a-an','Indefinite Articles A / An','Artikel tunggal berdasarkan bunyi awal kata, bukan sekadar huruf.', '''
# A / An
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

**Ingat:** hindari menggunakan *a/an* langsung dengan *water* atau *furniture* dalam arti umum, tetapi *a bottle of water* benar karena yang dihitung adalah *bottle*.
''')
lesson('countable-uncountable','some-any','Some / Any / Much / Many','Kuantitas dalam kalimat positif, negatif, dan pertanyaan.', '''
# Some, Any, Much, Many
## Ringkasan
- **some**: sejumlah; umum di kalimat positif, juga tawaran dan permintaan.
- **any**: sejumlah/apa pun; sering pada kalimat negatif dan pertanyaan.
- **many**: banyak + kata benda jamak yang dapat dihitung.
- **much**: banyak + kata benda tidak dapat dihitung.

## Contoh
- *We bought some apples.*
- *There isn't any milk.*
- *Are there any chairs?*
- *How many books do you have?*
- *How much water do you drink?*

## Nuansa penting
*Would you like some tea?* benar sebagai tawaran. *Do you have any questions?* benar sebagai pertanyaan umum. Dalam kalimat positif sehari-hari **a lot of** sering terasa lebih alami daripada **much**: *I have a lot of homework*.

**Hindari:** ❌ *many furniture* → ✅ *much furniture* / *a lot of furniture*.
''')
lesson('countable-uncountable','how-much-many','How Much / How Many','Mengajukan pertanyaan tentang jumlah dan ukuran.', '''
# How Much vs How Many
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

**Perhatikan:** *time* dapat berarti waktu secara umum (uncountable, *how much time*), sedangkan *times* bisa berarti kejadian yang dapat dihitung (*how many times?*).
''')
lesson('singular-plural','regular-plurals','Regular Plurals (-s/-es)','Aturan perubahan kata benda menjadi jamak.', '''
# Regular Plurals
Singular berarti satu; plural berarti lebih dari satu. Sebagian besar kata benda membentuk plural dengan **-s**.

- **book → books**, **pen → pens**, **flower → flowers**.
- Kata yang berakhir dengan bunyi sibilan (sering -s, -ss, -sh, -ch, -x, -z) biasanya mendapat **-es**: *bus → buses, box → boxes, watch → watches*.
- Beberapa kata berakhiran **-o** memakai **-es**: *tomato → tomatoes, potato → potatoes*, tetapi *photo → photos, piano → pianos, radio → radios*.

## Contoh
- *This car is expensive.* → *These cars are expensive.*
- *There is one box.* → *There are two boxes.*

**Penting:** plural memengaruhi kata kerja (misal *is → are*) serta determiner (*this → these*). Jangan menganggap semua kata berakhiran -o mendapat -es.
''')
lesson('singular-plural','y-f-fe-plurals','Plural -y, -f, and -fe','Perubahan ejaan dengan -ies dan -ves serta pengecualiannya.', '''
# Plural Nouns: -y, -f, -fe
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

**Latihan:** lihat akhir sebuah kata dahulu, kemudian cek apakah termasuk pengecualian sebelum membentuk pluralnya.
''')
lesson('singular-plural','irregular-plurals','Irregular & Unchanged Plurals','Bentuk jamak tidak beraturan dan bentuk tanpa perubahan.', '''
# Irregular Plural Nouns
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

Hafalkan bentuk tidak beraturan karena tidak selalu dapat diprediksi dari ejaan.
''')
lesson('singular-plural','plural-agreement','Plural in Sentences','Menyesuaikan kata kerja, artikel, dan penunjuk untuk bentuk jamak.', '''
# Plural Agreement in Sentences
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

**Catatan:** *information* tidak menjadi *informations* dan biasanya menggunakan kata kerja tunggal: *The information is useful*.
''')
lesson('simple-present','nominal-simple-present','Nominal Simple Present (am/is/are)','Kalimat nominal menggunakan to be.', '''
# Nominal Simple Present
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

Untuk membicarakan status atau sifat, **jangan** menambahkan *do/does* sebelum *am/is/are* dalam kalimat negatif biasa.
''')
lesson('simple-present','verbal-simple-present','Verbal Simple Present','Kegiatan rutin dan perubahan kata kerja -s/-es.', '''
# Verbal Simple Present
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

**Perhatikan:** kata kerja diberi -s/-es pada **he/she/it**, tetapi setelah *does/doesn't*, kata kerja kembali ke bentuk dasar: *She doesn't go*.
''')
lesson('simple-present','do-does',"Do / Does / Don't / Doesn't",'Membuat kalimat tanya dan negatif verbal.', '''
# Do / Does
Gunakan **do/does** untuk membuat pertanyaan dan negatif **verbal** dalam Simple Present.

| Subject | Auxiliary |
|---|---|
| I, you, we, they | do / don't |
| he, she, it | does / doesn't |

## Pola
- **(?)** *Does she work here?* → *Yes, she does.* / *No, she doesn't.*
- **(-)** *He does not play football.*
- **(?)** *Do they speak English?* → *Yes, they do.*
- **(-)** *We don't eat meat.*

**Penting:** setelah *do/does/don't/doesn't*, gunakan kata kerja dasar (V1).  
❌ *Does she works?* → ✅ *Does she work?*

**Bedakan dengan to be:** *Is she happy?* (bukan *Does she happy?*) karena *happy* adalah adjective, bukan kata kerja tindakan.
''')
lesson('simple-present','frequency-adverbs','Adverbs of Frequency','Posisi always, usually, often, sometimes, rarely, never.', '''
# Adverbs of Frequency
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

**Ingat:** *never* sudah bermakna negatif; hindari *I don't never ...* dalam English standar, gunakan *I never ...*.
''')
lesson('prepositions','place-prepositions','Prepositions of Place','Letak benda dan orang: in, on, at, between, among.', '''
# Prepositions of Place
Prepositions menerangkan hubungan suatu benda atau orang dengan lokasi lain.

- **in**: di dalam *The keys are in the bag.*
- **on**: di atas/menempel permukaan *The book is on the table.*
- **under / beneath**: di bawah *The cat is under the chair.*
- **behind**: di belakang *The shop is behind the school.*
- **between**: di antara dua (atau beberapa yang dipandang satu per satu) *The bank is between the café and the school.*
- **among**: di antara sebuah kelompok *She stood among the students.*
- **next to / beside**: di samping *Sit next to me.*
- **opposite**: berhadapan *The hospital is opposite the post office.*

**Catatan:** *above* menyatakan lebih tinggi tanpa harus bersentuhan; *over* punya banyak makna termasuk di atas dan menutupi/melintasi. Jangan selalu menerjemahkan keduanya menjadi *on*.
''')
lesson('prepositions','time-prepositions','Prepositions of Time (in/on/at)','At untuk jam, on untuk hari/tanggal, in untuk bulan/tahun/periode.', '''
# Prepositions of Time
## At
*at 7 a.m.*, *at noon*, *at midnight*, *at night*.

## On
*on Monday*, *on March 20th*, *on Friday morning*, *on my birthday*.

## In
*in March*, *in 2026*, *in summer*, *in the morning*, *in the afternoon*, *in the evening*.

## Contoh
- *My birthday is on March 20th.*
- *The course begins at ten o'clock.*
- *She was born in 1997.*
- *We usually exercise in the morning.*

**Perhatikan:** *at night* berbeda dengan *in the morning*. Gunakan **on** ketika terdapat hari atau tanggal yang spesifik, walaupun disertai nama bulan.
''')
lesson('prepositions','movement-prepositions','Prepositions of Movement','Dari, menuju, masuk, melewati, dan sepanjang.', '''
# Prepositions of Movement
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

❌ *I go to home.* → ✅ *I go home.* (*home* sering berfungsi sebagai adverb arah tanpa *to*).
''')
lesson('prepositions','duration-prepositions','For / Since / During / Until','Kapan dimulai, berapa lama, dan sampai kapan.', '''
# For, Since, During, Until
- **for + durasi**: *for two hours*, *for three weeks*.
- **since + titik awal waktu**: *since 2020*, *since Monday* (biasanya dalam Perfect tense untuk keadaan yang masih berlangsung).
- **during + peristiwa/periode**: *during the meeting*, *during the holiday*.
- **until / till + akhir waktu**: *until six o'clock*, *until Friday*.

## Contoh
- *I studied for two hours yesterday.*
- *I have lived here since 2020.*
- *Nobody spoke during the exam.*
- *The store is open until nine p.m.*

**Jangan tertukar:** *for 2020* tidak cocok jika yang dimaksud adalah titik awal. *Since two hours* juga tidak tepat untuk durasi (*for two hours*).

**Catatan:** kata **by** sering berarti paling lambat: *Please finish by Friday.* Berbeda dari *until Friday* yang menunjukkan kelanjutan sampai Jumat.
''')
lesson('conjunctions','addition-reason','Addition, Reason & Result','And, because, so, so that dan in order to.', '''
# Conjunctions: Addition, Reason, Result
Kata sambung menghubungkan ide dan menunjukkan hubungan logis.

- **and** = dan: *She reads and writes well.*
- **because** + klausa = karena: *I stayed home because I was sick.*
- **so** = sehingga/jadi: *It was raining, so we stayed home.*
- **so that** + klausa = supaya: *Speak clearly so that everyone can hear.*
- **in order to** + V1 = untuk: *She studies in order to pass the exam.*

## Bandingkan
*I was tired **because** I worked late.* (alasan)  
*I worked late, **so** I was tired.* (akibat)

**Perhatikan:** *because* biasanya diikuti sebuah klausa (subjek + verba); *because of* diikuti noun/frasa benda: *because of the rain*.
''')
lesson('conjunctions','contrast-conjunctions','But / Although / Whereas / However','Menunjukkan pertentangan atau kontras.', '''
# Contrast Conjunctions
- **but**: *The exam was hard, but I passed.*
- **although / though**: *Although the exam was hard, I passed.*
- **whereas**: *I like tea, whereas my sister likes coffee.*
- **even though**: *Even though it was raining, we played.*
- **however**: penghubung wacana, biasanya setelah tanda titik atau titik koma: *It was raining. However, we went out.*

## Penempatan
Klausa yang diawali *although* bisa muncul di awal atau akhir kalimat: *Although he was tired, he studied.* / *He studied although he was tired.*

**Kesalahan umum:** ❌ *Although it was raining, but we went out.* → ✅ *Although it was raining, we went out.*

**Tips:** pilih *whereas* untuk dua fakta yang berbeda; *although* untuk hal yang mengejutkan/kontras dengan hasilnya.
''')
lesson('conjunctions','condition-conjunctions','If / Unless / As If','Kondisi, pengecualian, dan seolah-olah.', '''
# Condition Conjunctions
## If
Menunjukkan syarat: *If it rains, we will stay at home.* (jika hujan, kami akan di rumah).

## Unless
Artinya **if ... not** dalam banyak konteks: *You won't pass unless you study.* (= if you do not study).

## As if
Berarti **seolah-olah**: *He talks as if he knows everything.*

## Conditional sederhana
- *If you heat ice, it melts.* (fakta umum: zero conditional)
- *If she comes tomorrow, I will call you.* (kemungkinan masa depan)

**Perhatikan:** untuk kondisi masa depan yang realistis, setelah *if* biasanya gunakan Simple Present, bukan *will*:  
❌ *If she will come, ...* → ✅ *If she comes, ...*

**Jangan menggandakan negasi:** *unless* sendiri sudah memiliki unsur “jika tidak”.
''')
lesson('conjunctions','time-conjunctions','When / While / Before / After / Until','Mengurutkan kejadian dan waktu kegiatan.', '''
# Time Conjunctions
- **when**: ketika *Call me when you arrive.*
- **while**: sementara/ketika dua peristiwa berlangsung *I listened while she spoke.*
- **before**: sebelum *Wash your hands before you eat.*
- **after**: setelah *We left after the show ended.*
- **until**: sampai *Wait here until I return.*
- **as soon as**: segera setelah *I will call as soon as I get home.*

## Kata sambung vs preposition
**After** dapat diikuti klausa (*after he arrived*) atau noun/gerund (*after lunch*, *after eating*).

**Kesalahan umum:** dalam time clause yang merujuk masa depan, biasanya gunakan Simple Present:  
❌ *I'll call you when I will arrive.*  
✅ *I'll call you when I arrive.*

**Latihan:** buat kalimat dengan kejadian utama + *before/after/when* untuk mengurutkan aktivitas harian.
''')
lesson('adjective-adverb','adjective-basics','Adjectives in Sentences','Kata sifat menjelaskan benda/orang setelah to be atau sebelum noun.', '''
# Adjectives
**Adjective** menjelaskan sifat/keadaan orang, benda, atau situasi. Contohnya: *gentle, strong, happy, careful, beautiful, expensive*.

## Posisi utama
- **sebelum noun**: *a beautiful room*, *a careful driver*.
- **setelah linking verb**: *The room is beautiful*, *He feels tired*, *She looks happy*.

## Contoh
- *The test is easy.*
- *He is a good teacher.*
- *The students are quiet.*

**Kesalahan umum:** ❌ *She is beautifully.* → ✅ *She is beautiful.* Karena setelah **is** di sini menjelaskan subject, kita memakai **adjective**.

**Catatan:** adjective bahasa Inggris umumnya tidak berubah bentuk untuk plural: *one beautiful house / two beautiful houses*.
''')
lesson('adjective-adverb','adverbs-ly','Adverbs of Manner (-ly)','Menggambarkan cara tindakan dilakukan.', '''
# Adverbs of Manner
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

**Catatan:** adverb tidak selalu diakhiri -ly. Lihat submateri irregular adverbs. Hindari mengubah adjective yang menerangkan *be/look/feel* menjadi adverb tanpa alasan.
''')
lesson('adjective-adverb','irregular-adverbs','Irregular Adverbs','Good/well, fast/fast, hard/hard, late/late.', '''
# Irregular / Flat Adverbs
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
- **late** = terlambat; **lately** = akhir-akhir ini (*I've been busy lately*).
- **good** menjelaskan noun; **well** sering menjelaskan verb dan juga bisa berarti sehat dalam konteks tertentu.

❌ *He speaks English good.* → ✅ *He speaks English well.*

**Ingat:** *bad → badly* untuk adverb cara yang biasa; **worse** umumnya bentuk komparatif dari *bad/badly*, bukan padanan adverb dasarnya.
''')
lesson('adjective-adverb','adjective-adverb-context','Choose Adjective or Adverb','Memilih jenis kata sesuai fungsi dalam kalimat.', '''
# Adjective vs Adverb
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

**Latihan:** identifikasi kata yang dideskripsikan sebelum memilih *quick/quickly*, *patient/patiently*, atau *sad/sadly*.
''')
lesson('degrees-comparison','positive-comparison','Positive Degree (as…as)','Menyatakan kualitas yang sama atau tidak sama.', '''
# Positive Degree: as ... as
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

**Latihan:** bandingkan dua benda yang ada di meja atau dua aktivitas yang menurutmu sama sulitnya.
''')
lesson('degrees-comparison','comparative-forms','Comparative Degree','Lebih ... daripada: -er than dan more ... than.', '''
# Comparative Degree
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

❌ *more taller* → ✅ *taller*; ❌ *expensiver* → ✅ *more expensive*.
''')
lesson('degrees-comparison','superlative-forms','Superlative Degree','Paling ... di antara sekelompok: the -est dan the most.', '''
# Superlative Degree
Untuk mengatakan **yang paling ...** dalam sebuah kelompok, gunakan superlative.

## Pola
- **the + adjective-est**: *the tallest, the biggest, the easiest*.
- **the most + adjective**: *the most beautiful, the most expensive*.

## Contoh
- *Rina is the tallest student in the class.*
- *This is the most comfortable room in the hotel.*
- *That was the easiest exam this semester.*

**Perhatikan:** superlative sering memakai **the**, dan frasa pembanding seperti *in the class* atau *of all*. Bentuk ejaan: *big → biggest*, *busy → busiest*.

**Kesalahan umum:** ❌ *the most tallest* → ✅ *the tallest*; ❌ *the beautifulest* → ✅ *the most beautiful*.
''')
lesson('degrees-comparison','irregular-comparison','Irregular Comparatives & Superlatives','Good/better/best, bad/worse/worst, dan perubahan tidak beraturan.', '''
# Irregular Degrees of Comparison
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
❌ *the worstest* → ✅ *the worst*.
''')
lesson('giving-directions','direction-vocabulary','Vocabulary for Directions','Kosakata jalan, simpang, lampu lalu lintas, dan posisi.', '''
# Giving Directions: Vocabulary
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

**Latihan:** cari persimpangan, bundaran, dan lampu lalu lintas di peta sekitar rumahmu, lalu sebutkan istilah Inggrisnya.
''')
lesson('giving-directions','giving-instructions','Giving Directions: Commands','Kalimat perintah untuk menjelaskan jalur.', '''
# Giving Directions: Commands
Gunakan kalimat perintah (**imperative**) dengan kata kerja bentuk dasar.

- **Go straight ahead.** = Jalan terus/lurus.
- **Turn left at the traffic lights.** = Belok kiri di lampu lalu lintas.
- **Turn right at the T-junction.** = Belok kanan di pertigaan.
- **Walk past the bank.** = Lewati bank.
- **Cross the road carefully.** = Seberangi jalan dengan hati-hati.
- **Take the second exit at the roundabout.** = Ambil pintu keluar kedua di bundaran.
- **Make a U-turn where permitted.** = Putar balik di tempat yang diizinkan.

**Tips:** gunakan urutan *First ... Then ... After that ... Finally ...* agar instruksi mudah diikuti. Jangan memberi instruksi berbahaya atau melanggar rambu.
''')
lesson('giving-directions','asking-directions','Asking for Directions Politely','Ungkapan meminta petunjuk jalan dengan sopan.', '''
# Asking for Directions
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

**Ingat:** *Where is the station?* merupakan pertanyaan langsung; setelah *Could you tell me ...* gunakan urutan klausa tak langsung: *... where the station is* (bukan *where is the station*).
''')
lesson('giving-directions','directions-dialogues','Directions in Dialogues','Menggabungkan arah, lokasi, dan pertanyaan.', '''
# Giving Directions in Conversation
Gabungkan kosakata tempat dengan urutan instruksi yang singkat.

## Dialog
A: *Excuse me, could you show me the way to the library?*  
B: *Of course. Go straight ahead until you reach the traffic lights.*  
A: *What should I do at the lights?*  
B: *Turn right, then walk past the bank. The library is on your left.*  
A: *Thank you very much!*  
B: *You're welcome.*

## Menjelaskan lokasi
- *The café is between the bank and the bookstore.*
- *The pharmacy is opposite the hospital.*
- *The station is next to the park.*

## Cara berlatih
Buat peta sederhana berisi 5 tempat, kemudian tulis dua rute berbeda. Gunakan **straight**, **left**, **right**, **past**, **opposite**, dan **between** secara konsisten.
''')
assert len(LESSONS)==12 and all(len(v)==4 for v in LESSONS.values()), {k:len(v) for k,v in LESSONS.items()}
# --- Question-bank helpers ---
def meaning_bank(m,l,text):
    """Each bilingual pair yields a forward and reverse question, giving 25 different Q from >=13 pairs."""
    pairs=[]
    for line in text.strip().splitlines():
        if not line.strip() or line.lstrip().startswith('#'):continue
        en,ind=[x.strip() for x in line.split('|',1)]
        pairs.append((en,ind))
    assert len(pairs)>=13,(m,l,len(pairs))
    assert len(set(x[0].casefold() for x in pairs))==len(pairs),(m,l,'duplicated English')
    assert len(set(x[1].casefold() for x in pairs))==len(pairs),(m,l,'duplicated Indonesian')
    for i,(en,ind) in enumerate(pairs[:13]):
        opts=[pairs[(i+j)%len(pairs)][0] for j in (1,2,3)]
        q(m,l,f"Choose the best English expression for: {ind}",en,opts,
          f"'{ind}' dalam konteks materi ini diterjemahkan menjadi '{en}'.")
        if i<12:
            opts2=[pairs[(i+j)%len(pairs)][1] for j in (2,4,6)]
            q(m,l,f"What is the Indonesian meaning of '{en}'?",ind,opts2,
              f"Dalam konteks materi, '{en}' bermakna '{ind}'.")

def cloze_bank(m,l,items,why=None):
    """Use contextual rows with stem; answer; 3 distractors; explanation. Exactly 25 per topic."""
    parsed=[]
    for line in items.strip().splitlines():
        if not line.strip() or line.lstrip().startswith('#'):continue
        s,a,x,y,z,*ex=[part.strip() for part in line.split('|')]
        if not ex: raise ValueError((m,l,line))
        parsed.append((s,a,[x,y,z],' '.join(ex)))
    assert len(parsed)==25,(m,l,len(parsed))
    for stem,a,wrongs,exp in parsed:q(m,l,stem,a,wrongs,exp)

# Alphabet modules: name mapping, spelling of vocabulary, decoding and communication
names={'A':'ay','B':'bee','C':'see','D':'dee','E':'ee','F':'ef','G':'jee','H':'aitch','I':'eye','J':'jay','K':'kay','L':'el','M':'em','N':'en','O':'oh','P':'pee','Q':'cue','R':'ar','S':'ess','T':'tee','U':'you','V':'vee','W':'double-u','X':'ex','Y':'why','Z':'zee (US)'}
letters=list(names)
for i,c in enumerate(letters[:25]):
  wrong=[names[letters[(i+j)%26]] for j in (3,8,15)]
  q('alphabet-spelling','letter-names',f"What is the name of the letter '{c}' in English?",names[c],wrong,
    f"Huruf {c} dieja '{names[c]}' saat menyebut alfabet (American English).")
words='vessel weather compass galley voyages laundry maps crews messroom visitor bridge cupboard magazine fence biology whiteboard exercise galaxy heat dress theory British everyone mathematics crown'.split()
assert len(words)==25
for i,w in enumerate(words):
  choices=[ '-'.join(x.upper()) for x in [words[(i+j)%25] for j in (3,7,13)]]
  q('alphabet-spelling','spelling-words',f"Which is the correct letter-by-letter spelling of '{w}'?",'-'.join(w.upper()),choices,
    f"Spelling menuliskan setiap huruf secara berurutan: {w.upper()}.")
for i,w in enumerate(words):
  other=[words[(i+j)%25] for j in (3,7,13)]
  q('alphabet-spelling','decode-spelling',f"Which English word is spelled {' – '.join(names[c.upper()] for c in w)}?",w,other,
    f"Nama-nama huruf tersebut membentuk kata '{w}'.")
meaning_bank('alphabet-spelling','spelling-context', '''
How do you spell it?|Bagaimana cara mengejanya?
Could you repeat the last letter?|Bisa ulangi huruf terakhir?
Is that B or D?|Itu huruf B atau D?
Please spell your surname.|Tolong eja nama keluarga Anda.
The first letter is A.|Huruf pertamanya A.
The last letter is Z.|Huruf terakhirnya Z.
Could you say that again?|Bisakah Anda mengatakannya sekali lagi?
How do you spell your name?|Bagaimana cara mengeja namamu?
My name begins with M.|Namaku dimulai dengan M.
That's correct.|Itu benar.
Could you speak slowly?|Bisa bicara pelan-pelan?
I didn't catch that.|Saya tidak menangkap yang Anda katakan.
There are two letters L.|Ada dua huruf L.
It's spelled with a double S.|Kata itu dieja memakai dua huruf S.
Please write it down.|Tolong tuliskan itu.
''')

meaning_bank('family-vocabulary','family-members','''
father|ayah
mother|ibu
son|anak laki-laki
daughter|anak perempuan
brother|saudara laki-laki
sister|saudara perempuan
grandfather|kakek
grandmother|nenek
uncle|paman
aunt|bibi
cousin|sepupu
nephew|keponakan laki-laki
niece|keponakan perempuan
parents|orang tua (ayah dan ibu)
children|anak-anak
''')
meaning_bank('family-vocabulary','extended-family','''
father-in-law|ayah mertua
mother-in-law|ibu mertua
brother-in-law|ipar laki-laki
sister-in-law|ipar perempuan
husband|suami
wife|istri
widower|duda karena pasangan meninggal
widow|janda karena pasangan meninggal
orphan|anak yatim atau piatu
grandchild|cucu
grandson|cucu laki-laki
granddaughter|cucu perempuan
relatives|kerabat
stepfather|ayah tiri
stepmother|ibu tiri
''')
cloze_bank('family-vocabulary','greetings','''
You meet your teacher at 8 a.m. Say:|Good morning.|Good night.|Good evening.|Goodbye.|Morning is the appropriate greeting in the morning.
You greet a friend at 7 p.m. Say:|Good evening.|Good morning.|Good night.|Goodbye.|Good evening is a greeting for the evening.
You are about to sleep. Say:|Good night.|Good morning.|Good afternoon.|Hello.|Good night is used when saying goodbye or going to sleep.
Someone says 'Nice to meet you.' Reply:|Nice to meet you, too.|Good night.|I'm twelve.|I'm hungry.|A natural reciprocal response adds too.
Your friend asks 'How are you?' Reply:|I'm fine, thank you.|At seven.|My name is Rio.|See you yesterday.|How are you asks about your condition.
You meet a new customer at 2 p.m. Say:|Good afternoon.|Good night.|Good morning.|See you.|Afternoon is the appropriate part of the day.
You leave class and plan to meet again. Say:|See you later.|How do you do?|Nice to meet you.|Good morning.|See you later is a farewell.
A: How are you? B: _____|I'm doing well, thanks.|I'm seventeen o'clock.|My father a driver.|At home is.|Answer a greeting with a description of how you are.
A: Hello! B: _____|Hi!|Goodbye yesterday.|I'm the night.|At twelve.|Hi is a normal reply to Hello.
A: Goodbye! B: _____|Goodbye!|Good afternoon at sleep.|I have two.|My cousin.|Goodbye is a polite response to a farewell.
At 11 a.m., you greet someone:|Good morning.|Good night.|Good evening.|See you tomorrow.|11 a.m. is still morning.
You say goodbye at 11 p.m. Say:|Good night.|Good afternoon.|Good morning.|Welcome.|Good night is appropriate when parting late in the day.
Someone says 'Pleased to meet you.' Reply:|Pleased to meet you, too.|How old your name?|No, I am not.|I am from Monday.|Return a polite introduction similarly.
A: Thank you for your help. B: _____|You're welcome.|Good morning tomorrow.|Not yesterday.|I'm seven.|You're welcome acknowledges thanks.
You want a polite opening to a stranger:|Excuse me.|Go away.|Never mind you.|Tomorrow.|Excuse me is a courteous way to get attention.
You greet your classmates as you enter in the morning:|Good morning, everyone.|Good night, everyone.|See you yesterday.|I am noon.|Use Good morning upon arrival in the morning.
A: How do you do? B: _____ (formal traditional greeting)|How do you do?|At six p.m.|I'm going home.|Yesterday was fine.|How do you do is traditionally answered with the same phrase.
Which phrase is normally a farewell, not a meeting greeting?|See you next time.|Good morning.|Hello there.|Nice to meet you.|See you next time implies parting.
You first meet a coworker. You can say:|Nice to meet you.|See you at yesterday.|Goodbye already.|It's midnight yesterday.|Nice to meet you introduces a new acquaintance.
A: See you on Friday! B: _____|See you then!|Good morning last night.|I'm fifteen chairs.|When tomorrow.|See you then acknowledges a planned next meeting.
At noon, a formal greeting could be:|Good afternoon.|Good night.|Good morning tomorrow.|Bye forever.|Noon begins the afternoon in many contexts.
You enter a party in the evening:|Good evening.|Good night.|See you later.|See you tomorrow.|Good evening is used when greeting at evening events.
A: Welcome to our class! B: _____|Thank you!|Good night then.|At Monday.|Never before.|Thank you is a natural response to welcome.
You must leave the meeting. Say:|I have to go now. Goodbye.|I am a morning.|Nice weather slept.|Did before us.|Goodbye is a polite leave-taking expression.
You introduce yourself:|Hello, my name is Dita.|See you last year.|Good night from seven.|I have name yesterday.|Introducing yourself uses My name is.
''')
meaning_bank('family-vocabulary','seasons-periods','''
spring|musim semi
summer|musim panas
autumn|musim gugur (British English)
fall|musim gugur (American English)
winter|musim dingin
rainy season|musim hujan
dry season|musim kemarau
morning|pagi
afternoon|siang hingga sore
evening|sore atau malam awal
night|malam
midnight|tengah malam
noon|tengah hari
sunrise|matahari terbit
sunset|matahari terbenam
''')

# Numeric helpers
small=['zero','one','two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen']
tens=['','','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety']
def saynum(n):
 if n<20:return small[n]
 if n<100:return tens[n//10]+(('-'+small[n%10]) if n%10 else '')
 if n<1000:return saynum(n//100)+' hundred'+(' and '+saynum(n%100) if n%100 else '')
 if n<1000000:return saynum(n//1000)+' thousand'+(' '+saynum(n%1000) if n%1000 else '')
 return saynum(n//1000000)+' million'+(' '+saynum(n%1000000) if n%1000000 else '')
cardinal_nums=[7,13,15,18,21,28,30,40,50,76,85,99,105,117,175,208,315,405,920,1200,2025,2803,50023,251230,1025100]
for i,n in enumerate(cardinal_nums):
 distractors=[saynum(cardinal_nums[(i+j)%25]) for j in (4,9,16)]
 q('cardinal-ordinal','cardinal-numbers',f'Which English number corresponds to {n:,}?',saynum(n),distractors,
   f'{n:,} dibaca {saynum(n)} (gaya dengan and setelah hundred).')
ord_base={1:'first',2:'second',3:'third',4:'fourth',5:'fifth',6:'sixth',7:'seventh',8:'eighth',9:'ninth',10:'tenth',11:'eleventh',12:'twelfth',13:'thirteenth',14:'fourteenth',15:'fifteenth',16:'sixteenth',17:'seventeenth',18:'eighteenth',19:'nineteenth',20:'twentieth',21:'twenty-first',22:'twenty-second',23:'twenty-third',24:'twenty-fourth',25:'twenty-fifth',26:'twenty-sixth',27:'twenty-seventh',28:'twenty-eighth',29:'twenty-ninth',30:'thirtieth',31:'thirty-first'}
ords=[1,2,3,4,5,6,8,9,11,12,13,14,15,20,21,22,23,24,25,26,27,28,29,30,31]
def ord_suffix(n):return 'th' if n%100 in (11,12,13) else {1:'st',2:'nd',3:'rd'}.get(n%10,'th')
for i,n in enumerate(ords):
 q('cardinal-ordinal','ordinal-numbers',f'How do you say the ordinal number {n}{ord_suffix(n)}?',ord_base[n],[ord_base[ords[(i+j)%25]] for j in (3,7,12)],f'{n}{ord_suffix(n)} adalah bilangan tingkat {ord_base[n]}.')
# Numbers as decimal, years and phone codes
numbers_dec=[('1.1','one point one'),('1.23','one point two three'),('23.4034','twenty-three point four zero three four'),('0.045','zero point zero four five'),('0.56','zero point five six'),('7.60','seven point six zero'),('89.99','eighty-nine point nine nine'),('3.4','three point four'),('5.07','five point zero seven'),('99.05','ninety-nine point zero five'),('1.20','one point two zero'),('12.35','twelve point three five'),('75.09','seventy-five point zero nine')]
years=[('1945','nineteen forty-five'),('1902','nineteen oh-two'),('1986','nineteen eighty-six'),('2000','two thousand'),('2001','two thousand and one'),('2005','two thousand and five'),('2010','twenty ten'),('2015','twenty fifteen'),('2020','twenty twenty'),('2026','twenty twenty-six'),('1999','nineteen ninety-nine'),('1888','eighteen eighty-eight')]
all_nums=numbers_dec+years
assert len(all_nums)==25
for i,(x,spoken) in enumerate(all_nums):
 q('cardinal-ordinal','decimals-years',f"How should {'the year' if i>=len(numbers_dec) else 'the decimal number'} {x} be read?",spoken,[all_nums[(i+j)%25][1] for j in (2,7,11)],
 f"{'Tahun' if i>=len(numbers_dec) else 'Bilangan desimal'} {x} dapat dibaca '{spoken}' dalam gaya yang diajarkan.")
# Fractions and operations 25
fractions=[(1,2,'one half'),(1,3,'one third'),(2,3,'two thirds'),(1,4,'one quarter'),(3,4,'three quarters'),(1,5,'one fifth'),(2,5,'two fifths'),(3,5,'three fifths'),(4,5,'four fifths'),(1,6,'one sixth'),(5,6,'five sixths'),(1,8,'one eighth'),(3,8,'three eighths')]
maths=[('7 + 10 = 17','seven plus ten equals seventeen'),('8 + 6 = 14','eight plus six equals fourteen'),('25 ÷ 5 = 5','twenty-five divided by five equals five'),('8 × 3 = 24','eight times three equals twenty-four'),('9 − 4 = 5','nine minus four equals five'),('6 × 7 = 42','six times seven equals forty-two'),('10 − 3 = 7','ten minus three equals seven'),('12 ÷ 4 = 3','twelve divided by four equals three'),('14 + 5 = 19','fourteen plus five equals nineteen'),('5 × 5 = 25','five times five equals twenty-five'),('16 ÷ 2 = 8','sixteen divided by two equals eight'),('15 − 7 = 8','fifteen minus seven equals eight')]
maths_all=[(f'{a}/{b}',s) for a,b,s in fractions]+maths
assert len(maths_all)==25
for i,(x,s) in enumerate(maths_all):
 q('cardinal-ordinal','fractions-math',f'How is this expression read aloud: {x}?',s,[maths_all[(i+j)%25][1] for j in (1,6,13)],f'Ekspresi {x} dibaca {s}.')
# Time & dates
clock_times=[(7,0),(7,10),(5,25),(11,15),(6,30),(10,45),(8,55),(5,35),(9,20),(13,0),(14,29),(15,15),(21,49),(22,17),(23,33),(16,0),(17,5),(19,45),(12,35),(1,0),(2,48),(6,26),(11,38),(10,25),(4,38)]
def clock_english(h,minute):
 h12=h%12 or 12;next_h=(h12%12)+1
 if minute==0:return f"{saynum(h12)} o'clock"
 if minute==15:return f'a quarter past {saynum(h12)}'
 if minute==30:return f'half past {saynum(h12)}'
 if minute==45:return f'a quarter to {saynum(next_h)}'
 if minute<30:return f'{saynum(minute)} past {saynum(h12)}'
 if minute>30:return f'{saynum(60-minute)} to {saynum(next_h)}'
for i,(hh,mm) in enumerate(clock_times):
 phrase=clock_english(hh,mm)
 wrong=list(dict.fromkeys(clock_english(*clock_times[(i+j)%25]) for j in range(1,25) if clock_english(*clock_times[(i+j)%25])!=phrase))[:3]
 q('telling-time-dates','telling-time',f'Which conversational English expression means {hh:02d}:{mm:02d}?',phrase,wrong,f'{hh:02d}:{mm:02d} dibaca {phrase} (format jam 12, tanpa AM/PM).')
meaning_bank('telling-time-dates','days-months','''
Monday|Senin
Tuesday|Selasa
Wednesday|Rabu
Thursday|Kamis
Friday|Jumat
Saturday|Sabtu
Sunday|Minggu
January|Januari
February|Februari
March|Maret
April|April
May|Mei
June|Juni
July|Juli
August|Agustus
September|September
October|Oktober
November|November
December|Desember
''')
months='January February March April May June July August September October November December'.split()
dates=[(20,3,2026),(30,4,2015),(20,7,2009),(29,12,1999),(11,1,1958),(2,10,1776),(17,8,2001),(3,10,2010),(12,7,1876),(31,12,2003),(26,3,1889),(1,4,2009),(10,10,1888),(23,6,2013),(8,8,1959),(30,1,1983),(2,11,1990),(6,4,1856),(21,2,2007),(16,6,2014),(13,3,1986),(4,9,2001),(17,7,1887),(28,4,2014),(2,3,2015)]
assert len(dates)==25
for i,(d,m,y) in enumerate(dates):
 british=f'{d} {months[m-1]} {y}';american=f'{months[m-1]} {d}, {y}'
 if i%2==0:
  q('telling-time-dates','british-american-dates',f'Choose the British written date for {american}.',british,
    [american,f'{m:02d}/{d:02d}/{y}',f'{y} {months[m-1]} {d}'],
    'British English biasanya menulis urutan day–month–year tanpa koma sebelum tahun.')
 else:
  q('telling-time-dates','british-american-dates',f'Choose the American written date for {british}.',american,
    [british,f'{d:02d}/{m:02d}/{y}',f'{y} {months[m-1]} {d}'],
    'American English umumnya menulis month–day, year menggunakan koma sebelum tahun.')
# contexts on / in / at / for / before
contexts=[('Monday','on'),('Tuesday afternoon','on'),('Friday morning','on'),('March 20th','on'),('Christmas Day','on'),('Sunday','on'),('July 4th','on'),('Thursday evening','on'),('September 9th','on'),('Saturday night','on'),('May','in'),('2026','in'),('summer','in'),('winter','in'),('the morning','in'),('the afternoon','in'),('the evening','in'),('October','in'),('1997','in'),('January','in'),('7 a.m.','at'),('noon','at'),('midnight','at'),('10 o’clock','at'),('night','at')]
for i,(part,ans) in enumerate(contexts):
 wrong=[x for x in ['on','in','at','for'] if x!=ans]
 q('telling-time-dates','time-practice',f'Complete the schedule: Our class begins _____ {part}.',ans,wrong,
   f"Untuk ekspresi waktu '{part}' gunakan preposition '{ans}'.")

# Countable/uncountable
countable=['book','apple','chair','student','tomato','pen','umbrella','picture','egg','car','banana','pencil','bottle']
uncount=['water','rice','information','furniture','advice','music','sugar','milk','homework','money','bread','equipment']
for i,n in enumerate(countable+uncount):
 c=n in countable
 q('countable-uncountable','countable-vs-uncountable',f"In its ordinary general meaning, is '{n}' countable or uncountable?",
   'Countable' if c else 'Uncountable', ['Uncountable' if c else 'Countable','Always a verb','Always a pronoun'],
   f"'{n}' secara umum merupakan {'countable noun' if c else 'uncountable noun'} dalam konteks dasar ini.")
article_nouns=[('apple','an'),('book','a'),('egg','an'),('umbrella','an'),('hour','an'),('university','a'),('teacher','a'),('artist','an'),('doctor','a'),('elephant','an'),('honest person','an'),('European country','a'),('engineer','an'),('student','a'),('orange','an'),('computer','a'),('island','an'),('house','a'),('idea','an'),('useful book','a'),('old bike','an'),('young child','a'),('interesting story','an'),('one-way ticket','a'),('English class','an')]
for n,ans in article_nouns:
 q('countable-uncountable','a-an',f"Choose the correct article: She has _____ {n}.",ans,[x for x in ('a','an','some','many') if x!=ans],
 f"'{n}' diawali bunyi {'vokal' if ans=='an' else 'konsonan'}, sehingga memakai '{ans}'.")
cloze_bank('countable-uncountable','some-any','''
There are _____ books on the shelf. (affirmative)|some|much|a|an|Some bisa dipakai bersama plural countable dalam kalimat afirmatif.
There isn't _____ milk in the bottle.|any|many|a|an|Any biasa dipakai dalam kalimat negatif untuk milk.
We have _____ chairs for the guests. (affirmative)|some|much|an|a|Some dapat menerangkan countable plural dalam kalimat afirmatif.
I don't have _____ homework tonight.|any|many|a|an|Homework uncountable; any lazim dipakai dalam kalimat negatif.
_____ people attended the meeting. (a large number)|Many|Much|A|An|People countable plural memakai many.
How _____ rice do you need?|much|many|a|an|Rice uncountable memakai much.
How _____ students are absent today?|many|much|an|a|Students plural countable memakai many.
We need _____ sugar for the cake. (a small unspecified amount)|some|many|an|a|Some dapat dipakai dengan sugar yang uncountable.
Do you have _____ questions?|any|much|an|a|Any umum dalam pertanyaan umum dengan plural countable.
Would you like _____ tea? (an offer)|some|many|a|an|Some sering dipakai dalam tawaran.
There are not _____ oranges left.|any|much|a|an|Any pada kalimat negatif dengan plural countable.
He has _____ friends in London. (a large number)|many|much|an|a|Friends countable plural memakai many.
We don't have _____ information about the event.|any|many|a|an|Information uncountable dan kalimat negatif memakai any.
She drank _____ water after running.|some|many|an|a|Some dapat menunjukkan jumlah tidak pasti dari uncountable water.
How _____ money did you spend?|much|many|a|an|Money uncountable dalam makna umum.
I found _____ apples in the kitchen. (affirmative)|some|much|an|a|Some sesuai untuk plural apples dalam kalimat afirmatif.
He didn't buy _____ bread.|any|many|a|an|Any cocok untuk negatif dan bread uncountable.
How _____ bags do you carry?|many|much|a|an|Bags plural countable memerlukan many.
There is _____ cheese in the fridge. (an unspecified amount)|some|many|a|an|Cheese sebagai zat makanan uncountable memakai some.
We haven't got _____ time.|much|many|a|an|Time dalam makna durasi merupakan uncountable sehingga much tepat.
She has _____ pencils in her case. (several)|some|much|an|a|Pencils plural countable dan jumlah tak tentu menggunakan some.
Is there _____ juice left?|any|many|a|an|Any umum pada pertanyaan tentang sisa juice.
There aren't _____ buses after midnight.|many|much|a|an|Buses dapat dihitung; many cocok untuk sedikit jumlah tersisa dalam negatif.
I have _____ good news for you.|some|many|a|an|News diperlakukan uncountable; some good news benar.
How _____ furniture is in the room?|much|many|a|an|Furniture uncountable sehingga how much benar.
''')
many_nouns=['books','apples','chairs','students','eggs','windows','cars','pencils','people','bananas','bottles','houses','phones']
much_nouns=['milk','sugar','rice','water','money','information','furniture','homework','music','advice','bread','coffee']
for n in many_nouns+much_nouns:
 ans='many' if n in many_nouns else 'much'
 q('countable-uncountable','how-much-many',f'Complete: How _____ {n} do we need?',ans,
  [x for x in ('many','much','a','an') if x!=ans],
  f"Noun '{n}' berbentuk {'plural countable → many' if ans=='many' else 'uncountable → much'}.")

# Singular/plural nouns
regular=['book','pen','hand','flower','roof','bus','box','church','brush','hero','tomato','potato','mosquito','radio','photo','piano','video','watch','dish','class','fox','bench','car','cup','dress']
exceptions={'bus':'buses','box':'boxes','church':'churches','brush':'brushes','hero':'heroes','tomato':'tomatoes','potato':'potatoes','mosquito':'mosquitoes','watch':'watches','dish':'dishes','class':'classes','fox':'foxes','bench':'benches','dress':'dresses'}
for n in regular:
 good=exceptions.get(n,n+'s');alts=[n+'s',n+'es',n[:-1]+'ies' if n.endswith('y') else n+'ies',n+'ses',n+'ies',n[:-1]+'ves' if n.endswith('f') else n+'ves',n]
 wrong=[]
 for a in alts:
  if a!=good and a not in wrong:wrong.append(a)
 assert len(wrong)>=3
 q('singular-plural','regular-plurals',f"Choose the standard plural form of '{n}'.",good,wrong[:3],
 f"Dalam pemakaian umum, bentuk plural dari '{n}' adalah '{good}'.")
yf={'baby':'babies','lady':'ladies','duty':'duties','cherry':'cherries','city':'cities','country':'countries','party':'parties','story':'stories','puppy':'puppies','family':'families','boy':'boys','key':'keys','day':'days','toy':'toys','monkey':'monkeys','knife':'knives','calf':'calves','shelf':'shelves','leaf':'leaves','half':'halves','wolf':'wolves','wife':'wives','chief':'chiefs','proof':'proofs','belief':'beliefs'}
for n,good in yf.items():
 wrong=[f'{n}s',f'{n}es',f'{n[:-1]}ies',f'{n[:-1]}ves',f'{n[:-2]}ves',n]
 wrong=list(dict.fromkeys(x for x in wrong if x!=good))
 assert len(wrong)>=3,(n,good,wrong)
 q('singular-plural','y-f-fe-plurals',f"What is the standard plural of '{n}'?",good,wrong[:3],
 f"'{n}' memiliki bentuk plural '{good}' sesuai aturan ejaan atau pengecualiannya.")
irreg=[('child','children'),('man','men'),('woman','women'),('foot','feet'),('tooth','teeth'),('mouse','mice'),('goose','geese'),('person','people'),('ox','oxen'),('louse','lice'),('sheep','sheep'),('deer','deer'),('fish','fish'),('person (two people)','people'),('child (three of them)','children'),('woman (four of them)','women'),('man (five of them)','men'),('mouse (two animals)','mice'),('foot (both)','feet'),('tooth (many)','teeth'),('goose (a flock)','geese'),('ox (two animals)','oxen'),('sheep (several)','sheep'),('deer (several)','deer'),('louse (many)','lice')]
assert len(irreg)==25
# alternate contextualized queries, answers may repeat across questions but unique stems
for i,(n,good) in enumerate(irreg):
 base=n.split(' (')[0]
 fake=[base+'s',base+'es',base[:-1]+'ies' if base.endswith('y') else base+'ies',base+'en','children','men','women','feet','teeth','mice','geese','oxen']
 wrong=[]
 for x in fake:
  if x!=good and x not in wrong:wrong.append(x)
 q('singular-plural','irregular-plurals',f"What is the standard plural form for '{n}'?",good,wrong[:3],
 f"Kata '{base}' memiliki bentuk jamak '{good}' dalam penggunaan ini.")
# Agreement contexts pairs: singular subjects and plural subjects with correct is/are or has/have
subs=[('The girl','is'),('The girls','are'),('A student','is'),('The students','are'),('This child','is'),('These children','are'),('That apple','is'),('Those apples','are'),('A car','is'),('The cars','are'),('This box','is'),('These boxes','are'),('The man','is'),('The men','are'),('The woman','is'),('The women','are'),('That mouse','is'),('Those mice','are'),('The information','is'),('The furniture','is'),('This book','is'),('These books','are'),('Those sheep','are'),('The teacher','is'),('Our friends','are')]
for i,(subject,answer) in enumerate(subs):
 tail=['ready for class','near the door','in the classroom','very expensive','on the desk'][i%5]
 q('singular-plural','plural-agreement',f'Complete: {subject} _____ {tail}.',answer,
 [x for x in ['is','are','am','be'] if x!=answer],
 f"Subject '{subject}' memerlukan '{answer}' untuk kesesuaian singular/plural pada kalimat ini.")
# Simple Present Tense
nominal_subs=[('I','am'),('He','is'),('She','is'),('It','is'),('You','are'),('We','are'),('They','are'),('My father','is'),('My parents','are'),('The children','are'),('The doctor','is'),('These students','are'),('A cat','is'),('Those books','are'),('The weather','is'),('Our classroom','is'),('Rina','is'),('Rina and Ali','are'),('My brother','is'),('My sisters','are'),('The coffee','is'),('This flower','is'),('Both teachers','are'),('A bicycle','is'),('The furniture','is')]
for i,(subject,a) in enumerate(nominal_subs):
 ending=['happy','at home','ready','very helpful','in the garden'][i%5]
 q('simple-present','nominal-simple-present',f'Complete the nominal sentence: {subject} _____ {ending}.',a,[x for x in ['am','is','are','does'] if x!=a],
 f"Subject '{subject}' cocok dengan bentuk to be '{a}' pada Simple Present nominal.")
# pairs subject and present verb form
verb_forms=[('She','study','studies'),('He','watch','watches'),('They','work','work'),('I','play','play'),('It','run','runs'),('We','go','go'),('My brother','study','studies'),('My parents','cook','cook'),('The train','arrive','arrives'),('The children','read','read'),('You','speak','speak'),('Rina','teach','teaches'),('The dog','bark','barks'),('He','fix','fixes'),('They','wash','wash'),('She','have','has'),('I','have','have'),('My uncle','drive','drives'),('Those birds','fly','fly'),('The baby','cry','cries'),('The teacher','explain','explains'),('We','visit','visit'),('She','carry','carries'),('He','do','does'),('The shop','close','closes')]
for i,(subject,base,a) in enumerate(verb_forms):
 other=[base,base+'s',base+'es',base[:-1]+'ies' if base.endswith('y') else base+'ing',base+'ed','does '+base]
 wr=[]
 for w in other:
  if w!=a and w not in wr:wr.append(w)
 assert len(wr)>=3,(subject,base,a,wr)
 tail=['every day','on Mondays','each morning','every evening','regularly'][i%5]
 q('simple-present','verbal-simple-present',f'Complete: {subject} _____ {tail}. (verb: {base})',a,wr[:3],
 f"Subject '{subject}' memerlukan bentuk Simple Present '{a}' dari kata kerja '{base}'.")
aux_subs=[('she','does'),('he','does'),('it','does'),('they','do'),('we','do'),('you','do'),('I','do'),('your sister','does'),('your brothers','do'),('the teacher','does'),('the students','do'),('your parents','do'),('the bus','does'),('your friend','does'),('those children','do'),('that boy','does'),('your classmates','do'),('the cats','do'),('your mother','does'),('the girl','does'),('your father','does'),('both teachers','do'),('this laptop','does'),('these phones','do'),('the driver','does')]
for i,(subj,a) in enumerate(aux_subs):
 verb=['play football','work here','study English','speak Spanish','live nearby'][i%5]
 q('simple-present','do-does',f'Choose the correct auxiliary for the question: _____ {subj} {verb}?',a,
 [x for x in ['do','does','is','are'] if x!=a],
 f"Pertanyaan verbal Simple Present dengan subjek '{subj}' memakai auxiliary '{a}' dan verb dasar.")
freq=[('She','always','arrives on time'),('They','usually','eat breakfast'),('My brother','often','plays football'),('We','sometimes','visit our grandparents'),('He','rarely','drinks coffee'),('I','never','smoke'),('The children','always','do their homework'),('Rina','usually','studies at night'),('You','often','help your friends'),('My father','sometimes','watches TV'),('Our teacher','rarely','arrives late'),('They','never','skip breakfast'),('She','often','reads books'),('We','usually','meet on Fridays'),('He','always','checks his email'),('I','sometimes','cook dinner'),('The students','never','cheat'),('My sister','rarely','takes a taxi'),('My friends','often','go hiking'),('You','usually','start early'),('We','always','brush our teeth'),('He','never','drives fast'),('They','sometimes','play chess'),('She','rarely','eats dessert'),('I','often','study English')]
for subject,adv,phrase in freq:
 vb=phrase.split(' ')[0];rest=' '.join(phrase.split(' ')[1:]);right=f'{subject} {adv} {phrase}.'
 wrong=[f'{subject} {phrase} {adv}.', f'{subject} {vb} {adv} {rest}.', f'{subject} {adv} is {phrase}.']
 # adverb terminal is possible in some contexts, but exercise asks neutral standard placement
 q('simple-present','frequency-adverbs',f'Choose the normal placement of "{adv}" in the sentence: {subject} {phrase}.',right,wrong,
 f"Dalam gaya netral, '{adv}' lazim ditempatkan sebelum main verb: '{subject} {adv} {vb}...'.")

# Prepositions
cloze_bank('prepositions','place-prepositions','''
The keys are _____ the drawer. (inside)|in|on|at|over|In digunakan untuk sesuatu di dalam wadah.
The notebook is _____ the table. (touching the surface)|on|in|under|between|On menunjukkan posisi menempel permukaan.
The cat is _____ the bed. (below it)|under|over|above|beside|Under menandakan lokasi di bawah benda lain.
The bakery is _____ the bank and the library.|between|under|through|into|Between menyatakan posisi di antara dua lokasi.
She stood _____ a group of students.|among|between|under|onto|Among menunjukkan berada di tengah kelompok.
The bus stop is _____ the school. (directly across the street)|opposite|inside|through|under|Opposite berarti tepat berhadapan/di seberang.
Sit _____ me. (immediately at my side)|beside|inside|across|through|Beside berarti di samping.
The picture is hanging _____ the wall.|on|in|beneath|between|On dipakai untuk gambar yang menempel dinding.
The plane is flying _____ the clouds. (higher than them)|above|under|inside|between|Above menunjukkan posisi lebih tinggi.
The shoes are _____ the door. (on the back side)|behind|before|above|on|Behind berarti di belakang.
There is a small shop _____ my house. (close to it)|near|into|across|through|Near menunjukkan jarak dekat.
The pen is _____ the bag. (within it)|inside|over|above|beside|Inside berarti di dalam.
The dog is sleeping _____ the tree. (beneath its branches)|under|over|above|through|Under menunjukkan posisi di bawah pohon.
The lamp is _____ the desk. (fixed on its surface)|on|in|around|through|On untuk permukaan meja.
The school is _____ the hospital and the post office.|between|among|behind|through|Between untuk posisi di tengah dua tempat tertentu.
The teacher is standing _____ the class. (at the front)|in front of|behind|under|inside|In front of berarti berada di depan kelas.
The river flows _____ the village. (in the space all around its edges)|around|inside|under|through|Around menyatakan mengelilingi sesuatu.
A bridge is _____ the river. (spanning it)|over|into|inside|beneath|Over dapat bermakna melintang di atas sungai.
The children are sitting _____ the floor.|on|under|above|between|On menunjukkan kontak dengan permukaan lantai.
The restaurant is _____ the cinema. (right next to it)|next to|through|along|into|Next to berarti tepat di samping.
The dog hid _____ the sofa. (at its back)|behind|before|above|inside|Behind menunjukkan sisi belakang sofa.
The bus is waiting _____ the station. (specific location)|at|in|into|through|At digunakan untuk titik lokasi tertentu.
The family lives _____ Jakarta. (within the city)|in|on|at|through|In digunakan untuk kota sebagai wilayah.
A clock hangs _____ the doorway. (higher than it)|above|under|inside|between|Above berarti lebih tinggi dari pintu.
The shop is _____ the corner of the street. (located there)|on|through|between|into|On the corner menyebut posisi toko di sudut jalan.
''')
place_times=[('7 a.m.','at'),('Monday','on'),('March','in'),('2026','in'),('Friday evening','on'),('noon','at'),('midnight','at'),('July 4th','on'),('winter','in'),('Sunday','on'),('the morning','in'),('the evening','in'),('night','at'),('my birthday','on'),('September','in'),('the afternoon','in'),('12:30 p.m.','at'),('Christmas Day','on'),('1997','in'),('Saturday morning','on'),('spring','in'),('the weekend (British English)','at'),('Thursday','on'),('8 o’clock','at'),('October 18th','on')]
for x,correct in place_times:
 q('prepositions','time-prepositions',f'Complete the time expression: Our meeting takes place _____ {x}.',correct,
 [w for w in ('in','on','at','for') if w!=correct],f"'{x}' dalam konteks ini memakai preposition '{correct}'.")
cloze_bank('prepositions','movement-prepositions','''
Please go _____ the station. (destination)|to|into|through|from|To menunjukkan tujuan perjalanan.
They travelled _____ Jakarta to Bali.|from|into|on|under|From menunjukkan titik asal perjalanan.
The child walked _____ the classroom from the corridor.|into|on|at|under|Into menunjukkan perpindahan ke dalam ruangan.
We drove _____ a long tunnel. (through its interior)|through|across|over|along|Through berarti melintasi bagian dalam.
Walk _____ the street carefully. (from one side to the other)|across|along|in|through|Across menunjukkan menyeberangi jalan.
We walked _____ the beach for an hour. (following its length)|along|into|under|across|Along berarti mengikuti jalur memanjang.
The boy jumped _____ the pool. (entering the water)|into|in|at|from|Into dipakai untuk gerakan masuk ke air.
She stepped _____ the car. (exiting)|out of|into|through|over|Out of menunjukkan keluar dari kendaraan.
Go _____ the bridge to reach the town. (from one end to the other)|across|under|into|on top of|Across menggambarkan menyeberangi jembatan.
The tourists walked _____ the museum. (moving inside it)|through|above|across|onto|Through menunjukkan gerakan melintasi bagian dalam.
Please move _____ the exit. (in that direction)|towards|from|under|inside|Towards bermakna menuju arah.
He ran _____ the stairs to the second floor.|up|under|into|across|Up menunjukkan gerakan ke atas tangga.
She walked _____ the stairs to the lobby.|down|over|across|onto|Down berarti bergerak turun.
The cat leapt _____ the table. (ending on its surface)|onto|into|out of|from|Onto menyatakan gerakan ke atas permukaan.
The cyclist rode _____ the park. (from one side to the other inside it)|through|under|onto|off|Through menunjukkan melintasi interior taman.
The bus came _____ the garage. (starting point)|from|into|onto|throughout|From menunjukkan asal.
We walked _____ the road to the other side.|across|along|down|beside|Across berarti menyeberang.
They travelled _____ the river by boat. (following its length)|along|under|into|onto|Along menunjukkan gerakan sejajar jalur sungai.
The bird flew _____ the open window. (entering the house)|through|onto|under|across from|Through cocok ketika melewati sebuah bukaan.
The driver turned _____ the main road. (entering it)|onto|under|inside|across|Turn onto berarti berbelok dan masuk ke jalan.
The children walked _____ the playground gate. (entering)|through|over|beneath|off|Through untuk melewati pintu atau gerbang.
She walked _____ the room when the meeting ended.|out of|into|onto|throughout|Out of menunjukkan gerakan keluar.
Please come _____ my office after lunch.|to|from|on|under|To menyatakan tujuan.
The plane flew _____ the mountain. (higher than it)|over|into|across|under|Over menyatakan melintas di atas gunung.
After class, I go _____.|home|to home|into home|at home|Go home memakai home sebagai kata keterangan arah.
''')
cloze_bank('prepositions','duration-prepositions','''
I studied English _____ two hours yesterday.|for|since|during|until|For diikuti durasi dua jam.
She has lived here _____ 2020.|since|for|during|until|Since diikuti titik awal tahun 2020.
Nobody spoke _____ the exam. (while the event took place)|during|since|for|until|During diikuti suatu peristiwa.
The shop stays open _____ 9 p.m. (up to that time)|until|since|during|for|Until menunjukkan batas akhir waktu.
He waited _____ thirty minutes.|for|since|during|until|Thirty minutes adalah durasi, maka for.
They have known each other _____ Monday. (starting then)|since|for|during|until|Monday sebagai titik awal memakai since.
We met _____ the conference. (while it happened)|during|for|since|until|During the conference adalah selama acara berlangsung.
Stay here _____ I come back.|until|during|for|since|Until diikuti klausa batas waktu.
She worked there _____ five years.|for|since|during|until|Five years adalah lama durasi.
We have been friends _____ childhood.|since|for|during|until|Childhood menjadi titik awal hubungan.
The lights went out _____ the storm.|during|for|since|until|During menunjukkan peristiwa saat badai.
The library closes _____ six. (continuing open up to six)|at|since|during|for|At digunakan untuk menunjuk waktu penutupan tepat pukul enam.
He has waited _____ 8 a.m. (starting at 8)|since|for|during|until|Since menunjukkan waktu mulai.
We talked _____ an hour.|for|since|during|until|An hour merupakan durasi.
She stayed silent _____ the interview.|during|since|for|until|During + event: interview.
Please finish this report _____ Friday. (deadline, no later)|by|until|for|since|By menunjukkan tenggat paling lambat.
The children played _____ the afternoon. (throughout that period)|throughout|since|until|by|Throughout mengacu ke keseluruhan periode.
I have been awake _____ midnight. (from that point)|since|during|for|until|Since midnight menyatakan titik awal.
She had no phone signal _____ the flight.|during|for|since|until|During menunjukkan kejadian selama penerbangan.
He stayed with us _____ three days.|for|since|until|by|For diikuti lama tiga hari.
We have lived in Jakarta _____ 2019.|since|for|during|until|Since diikuti tahun sebagai awal.
I will wait _____ you are ready.|until|during|for|since|Until diikuti kondisi saat menunggu berakhir.
The workers rested _____ the lunch break.|during|since|for|until|During diikuti periode istirahat sebagai event.
The project continued _____ six months.|for|since|during|by|For diikuti durasi enam bulan.
You must arrive _____ 7 a.m. at the latest.|by|until|since|during|By menyatakan batas waktu kedatangan.
''')
# Conjunctions: each stem explicitly establishes the intended logical relation or grammatical pattern.
add_examples=[('She reads books','she writes stories'),('I like tea','I enjoy coffee'),('The class studies grammar','the class practices spelling'),('The boy opened the door','the girl entered'),('He cleaned the room','he washed the dishes')]
reason_examples=[('I stayed at home','I felt sick'),('She was late','the bus broke down'),('We used an umbrella','it was raining'),('He studied hard','he wanted to pass'),('They went inside','the weather was cold')]
result_examples=[('It rained heavily','the match was cancelled'),('She missed the bus','she arrived late'),('He trained every day','he became stronger'),('The bag was too heavy','I asked for help'),('The shop was closed','we returned home')]
purpose_examples=[('Please speak slowly','everyone can understand you'),('She saved money','she could buy a bike'),('I wrote the address clearly','the driver could find us'),('He set an alarm','he would wake up early'),('We brought water','we would not get thirsty')]
infinitive_examples=[('She wakes up early','catch the bus'),('I work hard','support my family'),('He studies vocabulary','improve his English'),('We exercise','stay healthy'),('They went to the station','buy tickets')]
for part,exp in [(add_examples,'and'),(reason_examples,'because'),(result_examples,'so'),(purpose_examples,'so that'),(infinitive_examples,'in order to')]:
 for a,b in part:
  stem=f"Choose the connector expressing {'addition' if exp=='and' else 'reason' if exp=='because' else 'result' if exp=='so' else 'purpose'}: {a}{',' if exp in ('and','so') else ''} _____ {b}." if exp!='in order to' else f"Choose an infinitive expression of purpose: {a} _____ {b}."
  others=[x for x in ['and','because','so','so that','in order to','whereas','unless'] if x!=exp]
  # avoid parse ambiguity by explicit label; wording for in-order-to needs 'She wakes up early in order to catch the bus'
  q('conjunctions','addition-reason',stem,exp,others[:3],f"'{exp}' dalam contoh ini menyatakan {'penambahan' if exp=='and' else 'alasan' if exp=='because' else 'akibat' if exp=='so' else 'tujuan'}.")
contrast_cases=[('The test was difficult','I passed it'),('She is young','she is very experienced'),('The food was expensive','it was delicious'),('He was tired','he finished the race'),('It was raining','we went outside')]
for a,b in contrast_cases:
 q('conjunctions','contrast-conjunctions',f"Complete using a coordinating contrast word: {a}, _____ {b}.",'but',['because','so','and'],
 'But menghubungkan dua klausa yang berlawanan, setelah klausa pertama dan koma.')
 q('conjunctions','contrast-conjunctions',f"Complete using a subordinating concession: _____ {a.lower()}, {b}.",'Although',['However','But','Therefore'],
 'Although mengawali anak kalimat konsesif; tidak digandeng dengan but pada induk kalimat.')
 q('conjunctions','contrast-conjunctions',f"Complete using a sentence-level transition: {a}. _____, {b}.",'However',['Although','Because','But'],
 'However dapat menjadi penghubung antar kalimat terpisah, lalu diikuti koma.')
 q('conjunctions','contrast-conjunctions',f"Choose the stronger concession linker: _____ {a.lower()}, {b}.",'Even though',['So that','Because of','In order to'],
 'Even though mengungkapkan bahwa hasil tetap terjadi meski ada keadaan kontras.')
 # whereas balanced contrast is about different facts, use stable comparisons instead
for a,b in [('I drink tea','my sister drinks coffee'),('Rina enjoys reading','Dina prefers swimming'),('My father works mornings','my mother works nights'),('The north is cool','the south is warmer'),('He likes cities','she prefers villages')]:
 q('conjunctions','contrast-conjunctions',f"Complete a comparison of contrasting facts: {a}, _____ {b}.",'whereas',['because','so that','and then'],
 'Whereas dipakai untuk mengontraskan dua fakta yang berbeda.')
cond_if=[('it rains','we will stay home'),('you study hard','you will improve'),('she arrives early','we can start'),('he calls tonight','I will answer'),('the bus is late','we will take a taxi')]
cond_unless=[('you practice','you will not improve'),('she hurries','she will miss the bus'),('it stops raining','we cannot leave'),('he apologizes','I will not forgive him'),('they invite us','we will not go')]
cond_asif=[('He talks','he knows everything'),('She looks','she has seen a ghost'),('The child smiles','nothing happened'),('They act','they own the place'),('He spends money','he is a millionaire')]
cond_zero=[('you heat ice','it melts'),('you mix red and blue','you get purple'),('you cool water enough','it freezes'),('plants get sunlight','they can grow'),('you press the switch','the lamp turns on')]
cond_whether=[('I do not know','he will attend'),('Please tell me','you agree'),('She asked','we were ready'),('We are unsure','the shop is open'),('I wonder','they need help')]
for cases,target,why in [(cond_if,'If','If memperkenalkan syarat atau kemungkinan realistis.'),(cond_unless,'Unless','Unless berarti if ... not; tanpa syarat tersebut hasil negatif terjadi.'),(cond_asif,'as if','As if bermakna seolah-olah.'),(cond_zero,'If','If juga digunakan untuk fakta umum atau zero conditional.'),(cond_whether,'whether','Whether menandai pertanyaan tidak langsung atau alternatif.')]:
 for a,b in cases:
  if target=='If' and cases is cond_zero: stem=f'Complete a general truth: _____ {a}, {b}.'
  elif target=='If':stem=f'Complete the real future condition: _____ {a}, {b}.'
  elif target=='Unless':stem=f'Complete using “if not”: _____ {a}, {b}.'
  elif target=='as if':stem=f'Complete the “seolah-olah” expression: {a} _____ {b}.'
  else:stem=f'Complete an embedded yes/no question: {a} _____ {b}.'
  choices=[x for x in ['If','Unless','as if','whether','because','although'] if x!=target][:3]
  q('conjunctions','condition-conjunctions',stem,target,choices,why)
time_cases=[('you arrive home','call me'),('the class starts','please take your seat'),('the train arrives','we will board'),('you finish the exam','hand in your work'),('he gets here','we will leave')]
for before,after in time_cases:
 q('conjunctions','time-conjunctions',f'Choose the time linker meaning "ketika": _____ {before}, {after}.','When',['Because','Although','Unless'],
 'When menghubungkan dua kejadian berdasarkan waktu.')
 q('conjunctions','time-conjunctions',f'Choose "segera setelah": _____ {before}, {after}.','As soon as',['Even though','Because of','In order to'],
 'As soon as berarti segera setelah kejadian pertama.')
before_cases=[('Wash your hands','you eat'),('Check the address','you leave'),('Lock the door','you go out'),('Review the material','you take the exam'),('Save your work','you shut down the computer')]
after_cases=[('We went home','the movie ended'),('She rested','she finished work'),('He called his mother','he arrived'),('They celebrated','they won'),('I had lunch','the meeting finished')]
for a,b in before_cases:
 q('conjunctions','time-conjunctions',f'Choose “sebelum”: {a} _____ {b}.','before',['after','because','although'],
 'Before mengurutkan tindakan pertama sebelum tindakan kedua.')
for a,b in after_cases:
 q('conjunctions','time-conjunctions',f'Choose “setelah”: {a} _____ {b}.','after',['before','although','unless'],
 'After menunjukkan bahwa kejadian pada anak kalimat selesai lebih dahulu.')
while_cases=[('I was reading','my sister was cooking'),('He cleaned the kitchen','she washed clothes'),('We were waiting','the rain was falling'),('The students were studying','the teacher was preparing questions'),('She played piano','he sang')]
for a,b in while_cases:
 q('conjunctions','time-conjunctions',f'Choose “sementara” for two overlapping actions: {a} _____ {b}.','while',['until','because','unless'],
 'While menyatakan dua tindakan berlangsung bersamaan/bertumpang tindih.')

# Adjectives and adverbs
adjectives=[('The room','beautiful'),('The test','easy'),('Her father','patient'),('The mountain','high'),('The baby','happy'),('His answer','correct'),('The weather','cold'),('The driver','careful'),('The library','quiet'),('The water','clean'),('The story','interesting'),('The bus','slow'),('The teacher','friendly'),('The table','heavy'),('The dog','brave'),('The exam','difficult'),('The child','sad'),('The athlete','strong'),('The food','delicious'),('The street','wide'),('The house','large'),('The lesson','useful'),('The office','comfortable'),('The plan','perfect'),('The person','gentle')]
for subj,a in adjectives:
 # wrong adverb form and unusable inflection forms
 adv=(a[:-1]+'ily' if a.endswith('y') else a[:-2]+'ly' if a.endswith('le') else a+'ly')
 q('adjective-adverb','adjective-basics',f'Choose the adjective after the linking verb: {subj} is _____.',a,[adv,'more '+adv,a+'ness'],
 f"Setelah to be yang mendeskripsikan subjek gunakan adjective '{a}', bukan adverb cara.")
adv_pairs=[('careful','carefully'),('quick','quickly'),('beautiful','beautifully'),('happy','happily'),('gentle','gently'),('clear','clearly'),('honest','honestly'),('easy','easily'),('lazy','lazily'),('patient','patiently'),('sad','sadly'),('foolish','foolishly'),('brave','bravely'),('busy','busily'),('clean','cleanly'),('correct','correctly'),('comfortable','comfortably'),('fluent','fluently'),('strong','strongly'),('perfect','perfectly'),('slow','slowly'),('quiet','quietly'),('polite','politely'),('careless','carelessly'),('serious','seriously')]
for a,adv in adv_pairs:
 wrong=[a,a+'ly',a+'ness',a+'er',a+'ing',a[:-1]+'ly' if a.endswith('y') else a[:-2]+'ily']
 wrong=list(dict.fromkeys(w for w in wrong if w!=adv))
 assert len(wrong)>=3,(a,adv,wrong)
 q('adjective-adverb','adverbs-ly',f"Choose the standard adverb of manner derived from '{a}'.",adv,wrong[:3],
 f"Adverb cara dari adjective '{a}' adalah '{adv}'.")
# Irregular and special distinctions, 25 contextual tests
flat_cases=[('She sings _____. (adverb from good)','well',['good','goodly','better'],'Good → well sebagai adverb cara.'),
('He runs very _____. (speed)','fast',['fastly','fasterly','fastness'],'Fast menjadi adverb tanpa -ly.'),
('They work _____ every day. (with effort)','hard',['hardly','hardlyly','hardness'],'Work hard berarti bekerja keras.'),
('We arrived _____. (after the expected time)','late',['lately','latest','lateness'],'Late berarti terlambat.'),
('I wake up _____. (before usual time)','early',['earlily','earliestly','earliness'],'Early bisa menjadi adjective dan adverb.'),
('He can speak English _____. (with good ability)','well',['good','goodly','goodness'],'Well adalah adverb dari good.'),
('The athlete moves _____. (quickly)','fast',['fastly','fastness','fastestly'],'Fast dapat berfungsi sebagai adverb.'),
('She studied _____ for the exam. (with effort)','hard',['hardly','hardlyness','hardlyer'],'Study hard bermakna belajar giat.'),
('He has _____ slept this week. (almost not at all)','hardly',['hard','hardest','hardness'],'Hardly berbeda makna dari hard: hampir tidak.'),
('I have been very busy _____. (recently)','lately',['late','latest','laterly'],'Lately bermakna akhir-akhir ini.'),
('He plays the piano _____. (skillfully)','well',['good','goodly','wellly'],'Well menerangkan cara bermain piano.'),
('The train travels _____. (speedily)','fast',['fastly','fastness','fastestly'],'Fast tetap fast sebagai adverb.'),
('The team trained _____. (with great effort)','hard',['hardly','hardlyness','hardily'],'Hard bermakna sungguh-sungguh.'),
('She came _____. (not on time)','late',['lately','lateness','latestly'],'Late berarti terlambat, bukan lately.'),
('The children got up _____. (before usual time)','early',['earlily','earlierly','earness'],'Early juga dapat menjelaskan waktu tindakan.'),
('We _____ know each other. (almost not)','hardly',['hard','hardest','hardness'],'Hardly bermakna hampir tidak.'),
('She has visited us _____. (recently)','lately',['late','laterly','latest'],'Lately menyatakan beberapa waktu belakangan ini.'),
('I feel _____. (healthy)','well',['goodly','wellly','goodness'],'Well dapat berfungsi sebagai adjective berarti sehat.'),
('You did very _____ on the test. (good performance)','well',['good','goodly','betterly'],'Do well menunjukkan performa baik.'),
('We left _____. (not after the scheduled time)','early',['earlily','earliestly','earliness'],'Early dapat menerangkan waktu keberangkatan.'),
('The workers pushed _____. (with force)','hard',['hardly','hardlyly','hardness'],'Hard berarti dengan kuat.'),
('The shop closed _____. (later than normal)','late',['lately','lateness','laterly'],'Late dipakai untuk waktu tutup terlambat.'),
('The rabbit moves _____. (rapidly)','fast',['fastly','fastness','fasterly'],'Fast menjadi adverb tanpa -ly.'),
('I can _____ hear you. (almost not)','hardly',['hard','harder','hardness'],'Hardly adalah adverb yang berarti hampir tidak.'),
('The student writes _____. (good quality)','well',['good','goodly','wellness'],'Write well menjelaskan cara menulis.')]
for stem,a,wrong,ex in flat_cases:q('adjective-adverb','irregular-adverbs',f'Choose the correct word: {stem}',a,wrong,ex)
context_cases=[('careful','carefully','The driver is','The driver drives'),('quick','quickly','Her response was','She responded'),('happy','happily','The child is','The child smiled'),('patient','patiently','The nurse is','The nurse waited'),('quiet','quietly','The library is','The students worked'),('beautiful','beautifully','The painting is','The artist painted'),('clear','clearly','His explanation is','He explained it'),('slow','slowly','The train is','The train moves'),('sad','sadly','The boy looks','The boy spoke'),('fluent','fluently','The speaker is','The speaker spoke'),('easy','easily','The test was','He finished the test'),('correct','correctly','The answer is','She answered'),('brave','bravely','The firefighter was','The firefighter acted')]
# 13 + 12 =25 questions: mixed contexts
for i,(adj,adv,phrase1,phrase2) in enumerate(context_cases):
 wrong=[adv,adj+'ness',adj+'ly' if adj+'ly'!=adv else 'more '+adv]
 wrong=list(dict.fromkeys(x for x in wrong if x!=adj));assert len(wrong)==3
 q('adjective-adverb','adjective-adverb-context',f'Choose the adjective: {phrase1} _____.',adj,wrong,
 f"'{adj}' mendeskripsikan subjek setelah linking verb.")
 if i<12:
  wrong=[adj,adj+'ness','most '+adj]
  q('adjective-adverb','adjective-adverb-context',f'Choose the manner adverb: {phrase2} _____.',adv,wrong,
    f"'{adv}' menerangkan cara suatu tindakan dilakukan.")
# Degrees of comparison
pos_adjs=['tall','short','old','young','high','low','long','wide','small','big','heavy','light','cheap','expensive','fast','slow','beautiful','careful','friendly','strong','weak','easy','difficult','useful','important']
for adj in pos_adjs:
 wrong=['more '+adj,adj+'er',adj+'est']
 q('degrees-comparison','positive-comparison',f'Complete an equality comparison: This object is as _____ as that object. (adjective: {adj})',adj,wrong,
 f"Struktur kesetaraan adalah as + adjective dasar ({adj}) + as, bukan comparative/superlative.")
# comparative forms
comp_forms=[('cheap','cheaper'),('great','greater'),('tall','taller'),('high','higher'),('kind','kinder'),('big','bigger'),('hot','hotter'),('wet','wetter'),('thin','thinner'),('fit','fitter'),('happy','happier'),('lucky','luckier'),('pretty','prettier'),('lazy','lazier'),('busy','busier'),('clever','cleverer'),('narrow','narrower'),('slow','slower'),('wise','wiser'),('brave','braver'),('fine','finer'),('large','larger'),('nice','nicer'),('famous','more famous'),('expensive','more expensive')]
for adj,form in comp_forms:
 poss=[adj+'er',adj+'est','more '+adj,'most '+adj,adj+'ier',adj+'r',adj+'er than']
 wrong=list(dict.fromkeys(w for w in poss if w!=form))[:3]
 assert len(wrong)==3,(adj,form)
 q('degrees-comparison','comparative-forms',f"Choose the comparative form of '{adj}' (before 'than').",form,wrong,
 f"Bentuk comparative untuk '{adj}' adalah '{form}' sebelum than.")
# superlative forms
super_forms=[('cheap','cheapest'),('great','greatest'),('tall','tallest'),('high','highest'),('kind','kindest'),('big','biggest'),('hot','hottest'),('wet','wettest'),('thin','thinnest'),('fit','fittest'),('happy','happiest'),('lucky','luckiest'),('pretty','prettiest'),('lazy','laziest'),('busy','busiest'),('clever','cleverest'),('narrow','narrowest'),('slow','slowest'),('wise','wisest'),('brave','bravest'),('fine','finest'),('large','largest'),('nice','nicest'),('famous','most famous'),('expensive','most expensive')]
for adj,form in super_forms:
 poss=[adj+'est',adj+'er','most '+adj,'more '+adj,adj+'iest',adj+'st',adj+'er than']
 wrong=list(dict.fromkeys(w for w in poss if w!=form))[:3]
 assert len(wrong)==3,(adj,form)
 q('degrees-comparison','superlative-forms',f"Choose the superlative form of '{adj}' (used after 'the').",form,wrong,
 f"Bentuk superlative untuk '{adj}' adalah '{form}' dan biasanya didahului the.")
# irregular: repeated in distinct contexts, with comparative vs superlative variation, intentionally not only vocab
irr_groups=[('good','better','best'),('bad','worse','worst'),('many','more','most'),('much','more','most'),('little','less','least'),('far','farther','farthest')]
for i,(base,comp,sup) in enumerate(irr_groups):
 q('degrees-comparison','irregular-comparison',f"Choose the comparative for '{base}'.",comp,[sup,base+'er','more '+base] if comp!='more' else [sup,base+'er',base+'est'],
  f"'{base}' memiliki comparative '{comp}' dan superlative '{sup}'.")
 q('degrees-comparison','irregular-comparison',f"Choose the superlative for '{base}'.",sup,[comp,base+'est','most '+base] if sup!='most' else [comp,base+'est',base+'er'],
  f"'{base}' memiliki superlative '{sup}'.")
# 12 base, 13 context examples
irr_context=[('This test is _____ than the previous one. (good)','better',['best','gooder','goodest']),('He is the _____ player on the team. (good)','best',['better','gooder','more good']),('The weather is _____ today than yesterday. (bad)','worse',['worst','badder','baddest']),('This is the _____ storm this month. (bad)','worst',['worse','badder','most worse']),('We need _____ chairs than before. (many)','more',['most','manyer','muchest']),('The class with the _____ students wins. (many)','most',['more','manyer','mucher']),('We have _____ time than yesterday. (little)','less',['least','littler','littlest']),('This is the _____ expensive item on the list. (little)','least',['less','little','littler']),('My hometown is _____ from here than yours. (far)','farther',['farthest','farer','most far']),('Which station is the _____ from the airport? (far)','farthest',['farther','more far','farer']),('She has _____ experience than he does. (much)','more',['most','muchs','mucher']),('This shop has the _____ variety. (much)','most',['more','muchest','mucher']),('His score is _____ than mine. (good)','better',['best','gooder','more good'])]
for stem,a,wrong in irr_context:q('degrees-comparison','irregular-comparison',f'Complete: {stem}',a,wrong,
 'Pilihan bentuk irregular harus mengikuti makna perbandingan dan jumlah objek dalam kalimat.')

# Directions
meaning_bank('giving-directions','direction-vocabulary','''
intersection|persimpangan
T-junction|pertigaan
roundabout|bundaran
traffic lights|lampu lalu lintas
pedestrian crossing|penyeberangan pejalan kaki
crossroads|perempatan
straight ahead|lurus ke depan
on the left|di sebelah kiri
on the right|di sebelah kanan
opposite|berhadapan di seberang
next to|tepat di samping
near|dekat
behind|di belakang
in front of|di depan
between|di antara dua lokasi
''')
meaning_bank('giving-directions','giving-instructions','''
Go straight ahead.|Jalan lurus ke depan.
Turn left at the lights.|Belok kiri di lampu lalu lintas.
Turn right at the junction.|Belok kanan di persimpangan.
Cross the road carefully.|Seberangi jalan dengan hati-hati.
Walk past the bank.|Berjalan melewati bank.
Take the second exit.|Ambil jalan keluar kedua.
Make a U-turn where permitted.|Putar balik di tempat yang diizinkan.
Stop at the intersection.|Berhenti di persimpangan.
Keep walking along this street.|Terus berjalan sepanjang jalan ini.
Continue until the traffic lights.|Lanjutkan sampai lampu lalu lintas.
Go over the bridge.|Lewati jembatan.
Walk through the park.|Berjalan melewati bagian dalam taman.
Take the first street on your left.|Ambil jalan pertama di sebelah kiri.
Follow the signs to the hospital.|Ikuti rambu menuju rumah sakit.
Turn back and go straight.|Berbalik arah lalu jalan lurus.
''')
meaning_bank('giving-directions','asking-directions','''
Where is the nearest hospital?|Di mana rumah sakit terdekat?
Could you show me the way?|Bisakah Anda menunjukkan jalannya?
How do I get to the station?|Bagaimana cara menuju stasiun?
Is there a bank near here?|Apakah ada bank di dekat sini?
Could you repeat that, please?|Bisa tolong ulangi?
Is it far from here?|Apakah jauh dari sini?
Can I walk there?|Bisakah saya berjalan kaki ke sana?
Which way is the library?|Ke arah mana perpustakaan?
Thank you for your help.|Terima kasih atas bantuan Anda.
You're welcome.|Sama-sama.
Excuse me, may I ask a question?|Permisi, boleh saya bertanya?
Is it on the left or right?|Apakah di kiri atau di kanan?
Where is the bus stop?|Di mana halte bus?
Could you speak more slowly?|Bisa bicara lebih pelan?
How far is the museum?|Seberapa jauh museum itu?
''')
cloze_bank('giving-directions','directions-dialogues','''
A: Where is the hospital? B: Go straight and _____ at the traffic lights. (left direction)|turn left|turn up|turn inside|turn under|Turn left adalah perintah untuk belok kiri.
A: Which side is the bank? B: It is _____ your right.|on|in|through|under|On your right adalah ekspresi posisi alami.
A: Thank you! B: _____|You're welcome.|Where are you?|Turn back now.|It's a lamp.|You're welcome adalah jawaban sopan untuk terima kasih.
A: Excuse me, _____ is the station? B: Next to the market.|where|who|whose|when|Where menanyakan lokasi.
A: How do I get to the library? B: _____ ahead for two blocks.|Go straight|Go left in|Sit down|Take asleep|Go straight ahead berarti terus lurus.
A: Is the café far? B: No, it is _____ the bank.|next to|through|over across|into|Next to menerangkan lokasi tepat di samping.
A: Where is the supermarket? B: It is _____ the bank and the library.|between|among|above|through|Between menghubungkan dua landmark.
A: Which direction should I take? B: _____ at the T-junction.|Turn right|Turn above|Turn below|Turn inside|Turn right memberi instruksi berbelok kanan.
A: What should I do at the roundabout? B: Take the _____ exit.|second|two|twice|double|Second adalah bilangan ordinal untuk urutan pintu keluar.
A: How can I reach the school? B: Walk _____ the bridge to the other side.|across|into|beneath|inside|Across menunjukkan menyeberang.
A: Is the post office nearby? B: Yes, it is just _____ the corner.|around|into|beneath|through|Around the corner berarti dekat setelah berbelok sudut.
A: Could you tell me _____ the museum is?|where|whose|whom|why|Dalam indirect question, where the museum is memiliki urutan subject-verb.
A: Could you show me the _____ to the hotel?|way|week|weather|weight|Show me the way berarti menunjukkan rute.
A: Is it on the right? B: No, it's on the _____.|left|up|down|through|Left adalah lawan right.
A: Can you repeat that? B: Sure, _____ left at the light.|turn|turned|turns|turning|Imperative menggunakan bentuk dasar turn.
A: What is ahead? B: You will see the traffic _____.|lights|rivers|stairs|chairs|Traffic lights berarti lampu lalu lintas.
A: Do we cross the road? B: Yes, use the pedestrian _____.|crossing|ceiling|counter|bedroom|Pedestrian crossing adalah penyeberangan pejalan kaki.
A: What do I do next? B: Walk _____ the bank, then turn right.|past|inside|under|above|Walk past menunjukkan bergerak melewati bank.
A: Is the pharmacy opposite the hospital? B: Yes, it is _____ the street.|across|inside|between|below|Across the street berarti di seberang jalan.
A: I am lost. Can you _____ me?|help|helps|helping|helped|Setelah can gunakan bentuk dasar help.
A: Is the café near the park? B: Yes, it is _____ to the park.|next|through|out|under|Next to adalah ungkapan tetap untuk bersebelahan.
A: How far is it? B: It's within walking _____.|distance|hour|direction|corner|Within walking distance artinya cukup dekat untuk berjalan kaki.
A: Where should I stop? B: _____ at the pedestrian crossing.|Stop|Stops|Stopping|Stopped|Imperative menggunakan verb dasar Stop.
A: Is there a shortcut? B: Go _____ the park instead of around it.|through|on|beneath|above|Through the park berarti melewati interior taman.
A: Thank you for the directions. B: My _____.|pleasure|station|left|bridge|My pleasure merupakan jawaban sopan setelah berterima kasih.
''')

# --- QA & export ---
assert len(LESSONS)==12 and all(len(ls)==4 for ls in LESSONS.values())
counts=Counter((p['module_slug'],p['lesson_slug']) for p in QUESTIONS)
for mod,ls in LESSONS.items():
 for item in ls:
  assert counts[(mod,item['slug'])]==25,(mod,item['slug'],counts[(mod,item['slug'])])
assert len(QUESTIONS)==1200, (len(QUESTIONS),counts)
unique=Counter((x['module_slug'],x['lesson_slug'],x['stem'].casefold()) for x in QUESTIONS)
assert len(unique)==len(QUESTIONS), [('dup',k,n) for k,n in unique.items() if n>1]
# Deduplicated-code stable, deterministic and balanced option placement
shuffled=[]
for item in QUESTIONS:
 key=(item['module_slug']+'|'+item['lesson_slug']+'|'+item['stem']).encode('utf-8')
 h=hashlib.sha256(key).hexdigest()
 index=int(h[:8],16)%4
 opts=[None]*4;opts[index]=item['correct']
 for j,w in enumerate(item['wrongs']):opts[(index+j+1)%4]=w
 assert len({str(v).casefold().strip() for v in opts})==4,item
 shuffled.append({k:item[k] for k in ['module_slug','lesson_slug','stem','explanation']}|{'difficulty':('easy','medium','hard')[int(h[8:16],16)%3],'options':opts,'correct_index':index,
 'code':'EXP-'+h[:20].upper()})
assert len({item['code'] for item in shuffled})==len(shuffled)
# Keep reference JSON for audit/content fixes
(ROOT/'db/expanded_lessons.json').write_text(json.dumps(LESSONS,ensure_ascii=False,indent=2)+'\n')
(ROOT/'db/expanded_bank.json').write_text(json.dumps(shuffled,ensure_ascii=False,indent=2)+'\n')
def lit(s):return "'"+str(s).replace("'","''")+"'"
sql=['-- EnglishLab LMS extension: 12 modules, 48 lessons, 1,200 reviewed template-based MCQs.',
 '-- IMPORTANT: run AFTER db:init AND db:seed (Pronouns).',
 '-- Idempotent: existing lessons/questions are NOT overwritten; previously unpublished modules with lessons are NOT forcibly republished.',
 'BEGIN;']
for mod,arr in LESSONS.items():
 # Initial promotion only for modules not yet populated (respects deliberate admin unpublish after first run)
 sql.append(f"UPDATE modules SET is_published=TRUE WHERE slug={lit(mod)} AND NOT EXISTS (SELECT 1 FROM lessons WHERE module_id=modules.id);")
 for i,entry in enumerate(arr,1):
  sql.append(f"""INSERT INTO lessons(module_id,slug,title,summary,body_md,sort_order,is_published)
SELECT m.id,{lit(entry['slug'])},{lit(entry['title'])},{lit(entry['summary'])},{lit(entry['body_md'])},{i},TRUE FROM modules m WHERE m.slug={lit(mod)}
ON CONFLICT (module_id,slug) DO NOTHING;""")
 sql.append(f"""INSERT INTO exam_configs(module_id,question_count,duration_minutes,passing_score)
SELECT id,25,30,75 FROM modules WHERE slug={lit(mod)} ON CONFLICT(module_id) DO NOTHING;""")
for item in shuffled:
 sql.append(f"""WITH inserted AS (
 INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
 SELECT {lit(item['code'])},m.id,l.id,{lit(item['stem'])},{lit(item['difficulty'])},{lit(item['explanation'])}
 FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug={lit(item['lesson_slug'])} WHERE m.slug={lit(item['module_slug'])}
 ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, v.body, v.correct, v.idx FROM inserted
CROSS JOIN (VALUES {','.join(f'({lit(o)},{"TRUE" if i==item["correct_index"] else "FALSE"},{i})' for i,o in enumerate(item['options']))}) v(body,correct,idx);""")
sql.append('COMMIT;')
(ROOT/'db/003_expanded_curriculum.sql').write_text('\n'.join(sql)+'\n')
print(f"Created {len(LESSONS)} modules, {sum(map(len,LESSONS.values()))} lessons, {len(shuffled)} questions.")
print('Module counts: ',dict(Counter(x['module_slug'] for x in shuffled)))
print('Difficulty: ',dict(Counter(x['difficulty'] for x in shuffled)))
