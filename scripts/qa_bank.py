import json,pathlib,collections,sys
root=pathlib.Path(__file__).resolve().parents[1]
bank=json.loads((root/'db/pronouns_bank.json').read_text())
expected={'subject-pronouns','object-pronouns','possessive-pronouns','reflexive-pronouns','demonstrative-pronouns','relative-pronouns','interrogative-pronouns'}
assert len(bank)==105, 'Expected 105 questions'
assert len({q['code'] for q in bank})==len(bank), 'Question code duplicated'
assert {q['lesson_slug'] for q in bank}==expected, 'Lesson list mismatch'
for q in bank:
 assert len(q['options'])==4,'Options not 4: '+q['code']
 assert len({o.strip().lower() for o in q['options']})==4,'Repeated distractor: '+q['code']
 assert q['correct_index'] in range(4),'Bad correct answer: '+q['code']
 assert q['difficulty'] in {'easy','medium','hard'}
 assert len(q['explanation'])>=8
byLesson=collections.Counter(q['lesson_slug'] for q in bank)
assert set(byLesson.values())=={15}
byLevel=collections.Counter(q['difficulty'] for q in bank)
assert set(byLevel.values())=={35}
byCorrect=collections.Counter(q['correct_index'] for q in bank)
assert max(byCorrect.values())-min(byCorrect.values())<=3
print('PASS: 105 questions, 7 lessons (15 each), 3 difficulties (35 each), 4 unique options, one correct, balanced correct positions.');print('Distribution',dict(byCorrect))
