import json,pathlib,collections,sys
r=pathlib.Path(__file__).resolve().parents[1]
w=json.loads((r/'db/writing_expansion.json').read_text());l=json.loads((r/'db/listening_expansion.json').read_text())
assert len(w)==144 and len(l)==64
wc=collections.Counter(q['grammar_focus'] for q in w); lc=collections.Counter(q['slug'] for q in l)
assert len(wc)==9 and set(wc.values())=={16},wc
assert len(lc)==8 and set(lc.values())=={8},lc
assert len({x['code'] for x in w})==len(w)
assert len({x['code'] for x in l})==len(l)
for q in w:
 assert 10<=len(q['indonesian'])<=200 and 10<=len(q['model_answer'])<=350 and q['difficulty'] in ('easy','medium','hard')
 assert q['accepted_answers'] and q['model_answer'] in q['accepted_answers']
for q in l:
 assert len(q['options'])==len(set(q['options']))==4
 assert q['options'][q['correct_index']] and 0<=q['correct_index']<4
 assert len(q['stem'])>=12 and len(q['explanation'])>=12
print('QA PASS',len(w),'additional writing questions in',len(wc),'groups;',len(l),'additional listening questions in',len(lc),'tracks')
