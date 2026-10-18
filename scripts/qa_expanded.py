#!/usr/bin/env python3
"""Offline curriculum-bank structural verification. Does not require PostgreSQL."""
from collections import Counter
from pathlib import Path
import json,re
root=Path(__file__).resolve().parents[1]
lessons=json.loads((root/'db/expanded_lessons.json').read_text())
questions=json.loads((root/'db/expanded_bank.json').read_text())
base=json.loads((root/'db/pronouns_bank.json').read_text())
assert len(lessons)==12
slugs={(mod,lesson['slug']) for mod,entries in lessons.items() for lesson in entries}
assert len(slugs)==48
assert len(questions)==1200
assert len(base)==105
assert len({x['code'] for x in questions})==1200
assert all(q['correct_index'] in (0,1,2,3) and len(q['options'])==4 for q in questions)
assert all(len(set(o.strip().casefold() for o in q['options']))==4 for q in questions)
assert all((q['module_slug'],q['lesson_slug']) in slugs for q in questions)
assert all(q['difficulty'] in ('easy','medium','hard') for q in questions)
assert all(len(q['explanation'])>=15 for q in questions)
counts=Counter((q['module_slug'],q['lesson_slug']) for q in questions)
assert len(counts)==48 and set(counts.values())=={25}
mods=Counter(q['module_slug'] for q in questions)
assert len(mods)==12 and set(mods.values())=={100}
stems=Counter((q['module_slug'],q['lesson_slug'],q['stem'].strip().casefold()) for q in questions)
assert len(stems)==1200
assert all(len(l['body_md'])>=280 for entries in lessons.values() for l in entries)
assert all(len(entries)==4 for entries in lessons.values())
sql=(root/'db/003_expanded_curriculum.sql').read_text()
assert sql.strip().endswith('COMMIT;') and sql.count('INSERT INTO questions(')==1200
assert len(re.findall(r'INSERT INTO lessons\(',sql))==48
print('PASS: 12 modules, 48 lessons, 1,200 extra questions; 1,305 total with Pronouns.')
print('PASS: 25 questions per lesson, 100 per extra module, 4 distinct options, 1 designated correct answer, unique codes/stems, SQL counts.')
print('Difficulty:',dict(Counter(q['difficulty'] for q in questions)))
print('Answer index:',dict(Counter(q['correct_index'] for q in questions)))
