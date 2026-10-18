import json, pathlib, re
root=pathlib.Path(__file__).resolve().parents[1]
raw={
'subject-pronouns': r'''
___ am learning English today.|I|Me|My|Mine|A|I adalah subject pronoun orang pertama tunggal.
___ is my brother, Alex.|He|Him|His|Himself|A|He dipakai sebagai subjek laki-laki tunggal.
Anna is a nurse. ___ works at a hospital.|She|Her|Hers|They|A|She menggantikan Anna sebagai subjek.
My friends are here. ___ are waiting outside.|They|Them|Their|It|A|They menggantikan friends (jamak) sebagai subjek.
My sister and I are ready. ___ can start now.|We|Us|Our|Them|A|We mencakup pembicara dan orang lain sebagai subjek.
The laptop is new. ___ works very well.|It|He|Him|They|A|It adalah pronoun untuk satu benda.
___ are my English teacher, Mr. David.|You|Your|Yours|Me|A|You berfungsi sebagai subjek orang yang diajak bicara.
Mr. Lee drives to work. ___ leaves at seven.|He|Him|His|Them|A|Mr. Lee menjadi subjek he.
The children look excited. ___ are going on a trip.|They|Their|Them|We|A|Children bentuk jamak, gunakan they.
My mother and father are home. ___ are cooking dinner.|They|Them|He|Her|A|Dua orang menjadi subject pronoun they.
The weather is beautiful. ___ is sunny today.|It|They|He|We|A|It bisa menjadi subjek untuk weather.
___ are responsible for this assignment, Lisa and I.|We|Us|Them|Her|A|Lisa and I adalah we sebagai subjek.
This is my friend Tim. ___ speaks three languages.|He|Him|They|His|A|He menjadi subjek yang menggantikan Tim.
My uncle and aunt live nearby. ___ visit us often.|They|Them|Their|It|A|Subjek untuk dua orang adalah they.
___ is the correct form: 'She runs', not 'Her runs'.|She|Her|Hers|Herself|A|Sebelum kata kerja runs diperlukan subject pronoun she.
''',
'object-pronouns': r'''
Please call ___ when you arrive.|me|I|my|mine|A|Setelah kata kerja call diperlukan object pronoun me.
I saw Daniel yesterday. I greeted ___.|him|he|his|himself|A|Him sebagai objek dari greeted.
Our teacher helped ___ with the lesson.|us|we|our|ours|A|Us adalah objek untuk we.
Sarah is kind. Everyone likes ___.|her|she|hers|herself|A|Her adalah objek kata kerja likes.
The dogs are hungry. Please feed ___.|them|they|their|theirs|A|Them adalah objek untuk dogs.
Could you explain the rule to ___?|me|I|my|mine|A|Setelah preposition to gunakan me.
I bought this book for ___.|you|your|yours|yourself|A|You dapat berfungsi sebagai objek.
My father invited my brother and ___.|me|I|my|mine|A|Setelah invited gunakan me, bukan I.
The manager spoke to Emma and ___.|him|he|his|himself|A|Setelah spoke to memerlukan him sebagai object pronoun.
Please put the keys on the table. Do not lose ___.|them|they|their|theirs|A|Keys jamak, objeknya them.
I do not know the answer. Can you tell ___?|me|I|mine|my|A|Tell me memerlukan object pronoun.
Lucy is waiting for ___.|us|we|our|ours|A|Setelah for gunakan us.
The cat looks tired. Let's leave ___ alone.|it|its|they|their|A|It sebagai objek untuk cat tunggal.
The teacher asked Tom and ___ to stay.|her|she|hers|herself|A|Her dipakai sebagai objek ask.
Between you and ___, this is difficult.|me|I|my|mine|A|Setelah preposition between, gunakan me.
''',
'possessive-pronouns': r'''
This is ___ pencil. (I)|my|mine|me|myself|A|My adalah possessive adjective sebelum noun pencil.
The red backpack is ___. (she)|hers|her|she|herself|A|Hers adalah possessive pronoun tanpa noun setelahnya.
Is this ___ notebook? (you)|your|yours|you|yourself|A|Your dipakai tepat sebelum notebook.
Those seats are ___. (we)|ours|our|us|we|A|Ours berdiri sendiri tanpa noun.
I like ___ new shoes. (they)|their|theirs|them|they|A|Their sebelum noun shoes.
This house belongs to John. It is ___.|his|him|he|himself|A|His bisa berdiri sendiri sebagai possessive pronoun.
My phone is black, but ___ is white. (you)|yours|your|you|yourself|A|Yours menggantikan your phone.
The children are doing ___ homework.|their|theirs|them|they|A|Their adalah possessive adjective sebelum homework.
This is Anna's jacket. The jacket is ___.|hers|her|she|herself|A|Hers menggantikan Anna's jacket.
The company changed ___ policy.|its|it's|it|itself|A|Its adalah possessive determiner; it's berarti it is/it has.
The bicycle is not mine. It is ___. (he)|his|him|he|himself|A|His adalah possessive pronoun untuk he.
We cleaned ___ classroom before leaving.|our|ours|us|we|A|Our sebelum noun classroom.
The final decision is ___. (they)|theirs|their|them|they|A|Theirs berdiri sendiri setelah is.
___ idea sounds interesting. (you)|Your|Yours|You|Yourself|A|Your sebelum noun idea.
I have my ticket. Does Maya have ___?|hers|her|she|herself|A|Hers mewakili her ticket sehingga noun tidak diulang.
''',
'reflexive-pronouns': r'''
I made this cake by ___.|myself|me|mine|my|A|By myself berarti melakukannya sendiri.
He hurt ___ while playing football.|himself|him|his|he|A|He dan objek merujuk orang sama: himself.
She taught ___ to play the guitar.|herself|her|hers|she|A|Subject she dan objek orang sama memakai herself.
We prepared the food ___.|ourselves|us|our|ours|A|We sebagai pelaku dan penegasan memakai ourselves.
Please help ___ to some cake, everyone.|yourselves|yourself|your|yours|A|Everyone diajak bicara sebagai kelompok: help yourselves.
The robot turned ___ off automatically.|itself|its|it|itselfs|A|Itself dipakai untuk benda tunggal.
The children dressed ___ before school.|themselves|them|their|theirs|A|Children jamak dan objek diri sendiri: themselves.
You should be proud of ___.|yourself|yours|your|you|A|Proud of yourself mengacu diri lawan bicara tunggal.
My friend and I fixed the bicycle ___.|ourselves|myself|themselves|us|A|My friend and I = we, jadi ourselves.
Tom looked at ___ in the mirror.|himself|him|his|he|A|Tom melihat dirinya sendiri: himself.
They built the shelter by ___.|themselves|them|theirs|their|A|By themselves berarti mereka membangunnya sendiri.
Be careful! Don't cut ___ with that knife.|yourself|yours|your|you|A|Cut yourself untuk lawan bicara tunggal.
The actress introduced ___ to the audience.|herself|her|she|hers|A|Pelaku she memperkenalkan dirinya: herself.
We enjoyed ___ at the party.|ourselves|us|our|ours|A|Enjoy ourselves berarti bersenang-senang.
The machine restarts ___ after an update.|itself|it|its|themselves|A|Machine tunggal menggunakan itself.
''',
'demonstrative-pronouns': r'''
___ is my pen here in my hand.|This|These|Those|They|A|This tunggal dekat pembicara.
___ are my books here on the desk.|These|This|That|It|A|These untuk benda jamak dekat pembicara.
___ is the mountain over there.|That|This|These|They|A|That untuk satu benda jauh.
___ are the stars far away.|Those|That|This|It|A|Those untuk banyak benda jauh.
Look at these two keys. ___ are mine.|These|This|That|It|A|These merujuk dua kunci dekat.
___ is a beautiful painting on the opposite wall.|That|These|Those|They|A|Painting tunggal jauh: that.
I prefer ___, not those, pointing to these shoes beside me.|these|this|that|it|A|These untuk shoes yang jamak dan dekat.
___ is my favorite mug, right here.|This|Those|These|They|A|Mug tunggal dekat: this.
Can you see ___ birds in that distant tree?|those|this|that|it|A|Those adalah determiner jamak jauh sebelum birds.
___ apples in this basket are fresh.|These|This|That|It|A|These adalah determiner jamak dekat sebelum apples.
___ chair beside you is broken.|That|These|Those|They|A|That dipakai sebelum chair tunggal di dekat lawan bicara (lebih jauh dari pembicara).
___ is the answer I was looking for, right here.|This|These|Those|They|A|This untuk jawaban tunggal yang ditunjuk dekat.
___ people across the street are waving.|Those|That|This|It|A|Those untuk people jamak jauh.
I don't want this sandwich. I want ___ one over there.|that|these|those|it|A|That digunakan sebagai determiner tunggal sebelum one di lokasi jauh.
___ are not my gloves here; they belong to Mia.|These|This|That|It|A|Gloves berbentuk jamak dan dekat: these.
''',
'relative-pronouns': r'''
The woman ___ teaches us is very patient.|who|whose|which|where|A|Who merujuk orang sebagai subjek klausa relatif.
The book ___ I borrowed is fascinating.|that|who|whose|whom|A|That dapat merujuk benda dalam klausa relatif pembatas.
The student ___ bag is missing looks worried.|whose|who|whom|which|A|Whose menunjukkan kepemilikan bag.
The machine ___ broke yesterday is working again.|that|who|whose|whom|A|That untuk benda dalam defining relative clause.
The man to ___ I spoke was polite.|whom|whose|which|that|A|Setelah preposition to formal, gunakan whom untuk orang.
The teacher ___ explained the rule was helpful.|who|whom|whose|which|A|Who bertindak sebagai subjek explained.
I met a scientist ___ research won an award.|whose|whom|who|which|A|Whose menunjukkan research milik scientist.
The bike ___ has a red frame belongs to Liam.|which|whom|who|whose|A|Which merujuk benda (bike) sebagai subjek.
The person ___ you called is my cousin.|whom|whose|which|where|A|Whom dapat digunakan sebagai objek person yang dipanggil dalam formal English.
The dog ___ tail is fluffy is friendly.|whose|whom|who|where|A|Whose dapat dipakai pada kepemilikan hewan.
The house ___ stands on the hill is old.|that|whom|who|whose|A|That cocok untuk house dalam defining relative clause.
The writer ___ books you love is visiting.|whose|who|whom|which|A|Whose menentukan buku milik writer.
The laptop, ___ I bought last year, still works.|which|that|who|whose|A|Dalam non-defining relative clause berkomma, gunakan which, bukan that.
My uncle, ___ lives in Bandung, is an engineer.|who|that|which|whom|A|Non-defining clause untuk orang sebagai subjek memakai who.
The woman with ___ he worked has retired.|whom|whose|which|that|A|Setelah with sebagai preposition formal untuk orang gunakan whom.
''',
'interrogative-pronouns': r'''
___ is knocking at the door?|Who|Whose|Which|Whom's|A|Who menanyakan identitas orang yang menjadi subjek.
___ bag is this?|Whose|Who|Whom|What|A|Whose menanyakan kepemilikan bag.
___ do you prefer, tea or coffee?|Which|Who|Whose|Whom|A|Which cocok untuk pilihan yang disebutkan.
___ is your name?|What|Who|Whose|Whom|A|What menanyakan informasi nama.
To ___ did you send the email? (formal)|whom|who's|whose|which|A|To whom dipakai secara formal setelah preposition to.
___ made this delicious cake?|Who|Whom|Whose|Which's|A|Who menanyakan subjek manusia yang membuat cake.
___ is the best answer from these three options?|Which|Whose|Who|Whom|A|Which memilih satu dari pilihan terbatas.
___ are these keys?|Whose|Who|What|Whom|A|Whose dapat berdiri sendiri menanyakan pemilik keys.
___ do you want to eat for lunch?|What|Who|Whose|Whom|A|What menanyakan sesuatu (makanan).
With ___ are you speaking? (formal)|whom|whose|what|which|A|With whom digunakan untuk objek orang dalam register formal.
___ of these jackets belongs to you?|Which|Who|Whose|Whom|A|Which of ... menanyakan pemilihan dari kumpulan yang jelas.
___ is responsible for opening the office?|Who|Whom|Whose|What|A|Who subjek orang yang bertanggung jawab.
___ did the teacher invite? (formal)|Whom|Whose|Which's|What|A|Whom menanyakan objek manusia yang diundang (bahasa formal).
___ is inside this box?|What|Who|Whom|Whose|A|What menanyakan benda/isi kotak.
___ notebook is on the table, yours or mine?|Whose|Who|Whom|What|A|Whose menanyakan siapa pemilik notebook.
'''
}
questions=[]
for tag, block in raw.items():
    entries=[ln.strip() for ln in block.splitlines() if ln.strip()]
    assert len(entries)==15,(tag,len(entries))
    for i,line in enumerate(entries,1):
        fields=line.split('|')
        assert len(fields)==7,(tag,i,fields)
        q,*options,letter,explanation=fields
        assert letter in 'ABCD'
        # Rotate options to avoid answer-A bias. Correct choice index remains derived from rotation.
        shift=(i*3 + len(tag))%4
        opts=options[shift:]+options[:shift]
        correct=(0-shift)%4
        difficulty=('easy' if i <=5 else 'medium' if i<=10 else 'hard')
        questions.append({'code':f'PRO-{tag.split("-")[0].upper()[:4]}-{i:03d}',
                          'lesson_slug':tag,'stem':q,'difficulty':difficulty,
                          'options':opts,'correct_index':correct,'explanation':explanation})
assert len(questions)==105
assert len({q['code'] for q in questions})==105
assert all(len(set(o.casefold() for o in q['options']))==4 for q in questions)
out=root/'db/pronouns_bank.json'
out.write_text(json.dumps(questions,ensure_ascii=False,indent=2)+'\n')
def literal(s): return "'"+str(s).replace("'","''")+"'"
lines=['-- Seed bank soal Pronouns (105 pertanyaan, 7 subtopik, 3 level).','-- Jalankan sesudah db:init dan seed course/modul/lesson.','BEGIN;']
for q in questions:
    sql=f"""WITH inserted AS (
  INSERT INTO questions(code,module_id,lesson_id,stem,difficulty,explanation)
  SELECT {literal(q['code'])},m.id,l.id,{literal(q['stem'])},{literal(q['difficulty'])},{literal(q['explanation'])}
  FROM modules m JOIN lessons l ON l.module_id=m.id AND l.slug={literal(q['lesson_slug'])} WHERE m.slug='pronouns'
  ON CONFLICT(code) DO NOTHING RETURNING id
)
INSERT INTO question_options(question_id,body,is_correct,sort_order)
SELECT inserted.id, opts.body, opts.correct, opts.idx FROM inserted
CROSS JOIN (VALUES {','.join(f'({literal(opt)},{"TRUE" if n==q["correct_index"] else "FALSE"},{n})' for n,opt in enumerate(q['options']))}) AS opts(body,correct,idx);"""
    lines.append(sql)
lines.append('COMMIT;')
(root/'db/002_pronouns.sql').write_text('\n'.join(lines)+'\n')
print('Generated',len(questions),'Pronouns questions:',out,'SQL lines',len(lines))
