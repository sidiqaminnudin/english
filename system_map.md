# SYSTEM MAP — EnglishLab Self-hosted English LMS

**Status:** Extended curriculum MVP v1.1  |  **Focus:** All 13 modules  |  **Language:** Indonesia (UI) + English (lesson/examples)  |  **Targets:** Desktop & mobile

## 1. Goal, scope and guardrails
An educational website with **public published lessons** but authenticated practice and exams. One Express app, PostgreSQL, Bootstrap templates. Teachers/admin can maintain published content and the question bank without touching source files. All 13 modules from the supplied photo series are now populated with public lessons and seedable question banks: 7 Pronouns lessons + 48 new lessons and 105 + 1,200 MCQs. The materials are newly authored adaptations, not literal transcriptions. Publishing occurs only during explicit seed extension; admin changes are not overwritten on repeat.

### Roles & permissions
| Capability | Guest | Student | Admin |
|---|---|---|---|
| Discover courses & read published lessons | yes | yes | yes |
| Register / login | yes | yes | yes |
| Practice, exam, save attempts, view own results | no | yes | yes |
| View other users' attempts | no | no | no in v1 |
| Edit content / questions / exam configs | no | no | yes |
| Configure roles / manage accounts | no | no | out of scope for v1 |

## 2. Page tree
```
/
├── /courses ── /courses/english-foundations
│   └── /learn/:moduleSlug (13 modules)
│       └── /learn/pronouns
│       ├── /learn/pronouns/subject-pronouns
│       ├── /learn/pronouns/object-pronouns
│       ├── /learn/pronouns/possessive-pronouns
│       ├── /learn/pronouns/reflexive-pronouns
│       ├── /learn/pronouns/demonstrative-pronouns
│       ├── /learn/pronouns/relative-pronouns
│       └── /learn/pronouns/interrogative-pronouns
├── /register  /login  POST /logout
├── /dashboard /history
├── /practice/:moduleSlug [GET setup, POST start]
├── /exam/:moduleSlug [GET rules, POST start]
├── /attempts/:id/take [practice feedback / exam no answer leak]
├── /attempts/:id/result
└── /admin
    ├── /admin/questions
    ├── /admin/questions/new
    ├── /admin/questions/:id/edit
    ├── /admin/lessons/:id/edit
    └── /admin/exams
```

## 3. Course map — extracted from the entire user-supplied photo series
Course: `English Foundations`.

| Group | Module | Detailed coverage | Initial publish status |
|---|---|---|---|
| A. Fundamentals | Alphabet & Spelling | A-Z letter names, alphabet exercise, pronounce/spell words (vessel, weather, compass, etc.) | published (v1.1) |
| A. Fundamentals | Family & Basic Vocabulary | family members, greetings, conversation starter, seasons | published (v1.1) |
| A. Fundamentals | Cardinal & Ordinal Numbers | 1 to millions, decimals, fractions, mathematical symbols, years | published (v1.1) |
| A. Fundamentals | Telling Time, Days & Dates | past/to, AM/PM, month/day/year vs day/month/year, day names | published (v1.1) |
| B. Grammar | Countable & Uncountable Nouns | a/an, much/many, some/any, noun classifications | published (v1.1) |
| B. Grammar | Singular & Plural Nouns | -s/-es/-ies/-ves, irregular plurals, exceptions | published (v1.1) |
| B. Grammar | **Pronouns** | subject, object, possessive adjectives & pronouns, reflexive, demonstrative, relative, interrogative | **published** |
| B. Grammar | Simple Present Tense | nominal, verbal, do/does, -s/-es, adverbs frequency | published (v1.1) |
| B. Grammar | Prepositions | time (in/on/at/for/since/during), place & movement | published (v1.1) |
| B. Grammar | Conjunctions | reason, contrast, purpose, condition, time, addition | published (v1.1) |
| B. Grammar | Adjectives & Adverbs | adverb of manner, -ly, irregular, adjective/verb differences | published (v1.1) |
| B. Grammar | Degrees of Comparison | positive, comparative, superlative, irregular | published (v1.1) |
| C. Communication | Giving Directions | turn left/right, crossroads, asking directions, route instructions | published (v1.1) |

### Pronouns detailed lessons
1. **Subject Pronouns**: I, you, we, they, he, she, it; subject slot, agreement.
2. **Object Pronouns**: me, you, us, them, him, her, it; objects after verbs & prepositions.
3. **Possessive Forms**: my/your/our/their/his/her/its vs mine/yours/ours/theirs/his/hers; **its** != **it's**; no standalone *its* in usual possessive-pronoun tables.
4. **Reflexive Pronouns**: myself, yourself, himself, herself, itself, ourselves, yourselves, themselves; subject-object same, emphasis.
5. **Demonstrative Pronouns**: this/that/these/those; singular-plural, distance; pronoun vs determiner.
6. **Relative Pronouns**: who/whom/whose/which/that; restrictive relative clauses and possessives, avoid awkward ambiguity.
7. **Interrogative Pronouns**: who/whom/whose/which/what; subject/object/person/ownership/selection, modern conversational *who* vs formal *whom*.

Every lesson stores: title, Markdown body, bilingual examples, common mistakes, summary, free reading. Question bank tags per lesson and difficulty.

### Expansion: 12 modules × 4 lessons and 100 questions
- **Alphabet & Spelling** (`alphabet-spelling`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Family & Basic Vocabulary** (`family-vocabulary`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Cardinal & Ordinal Numbers** (`cardinal-ordinal`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Time, Days & Dates** (`telling-time-dates`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Countable & Uncountable** (`countable-uncountable`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Singular & Plural** (`singular-plural`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Simple Present** (`simple-present`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Prepositions** (`prepositions`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Conjunctions** (`conjunctions`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Adjectives & Adverbs** (`adjective-adverb`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Degrees of Comparison** (`degrees-comparison`): 4 public lessons, 25 MCQ per lesson, 100 questions total.
- **Giving Directions** (`giving-directions`): 4 public lessons, 25 MCQ per lesson, 100 questions total.

Difficulty flags are initial, approximate metadata for balancing the exam. Item difficulty and answer quality need periodic teacher review; all questions currently use MCQ, not audio or free-text.

## 4. Features and business rules

### Public content
- SEO-friendly slug URLs and safe Markdown rendering; no student login required.
- Guest landing and catalog never leak draft modules/lessons; draft modules are hidden until approved.
- Read-progress saves only for logged-in learners; anonymous visitor can learn without tracking.

### Account flows
- Register with username, display name, password; login by username; secure session persisted to PostgreSQL.
- Existing login required when starting a practice/exam. Logout via CSRF-protected POST.
- V1 no password reset/email, social login or admin role editing (deliberate scope).

### Practice
- Available questions must be active, in a published module, and have exactly four options and one correct answer.
- Select whole module or one lesson. Take up to 10 random questions (or less if fewer exist).
- Candidate selection preferentially places less recently seen questions first; randomize question and option sequence.
- Answer saved immediately through authenticated CSRF-protected fetch; feedback *correct/incorrect + explanation* displayed only in practice. Answer can be changed during same attempt, score evaluated on submit.
- No countdown in practice.

### Exam
- Exam config is per module (question count, time limit, pass score). Only admin changes config.
- Start stores immutable question & option snapshot per attempt. Each student's question order varies and survives refresh.
- Countdown and server-side time enforcement; autosubmit on expiry in browser as convenience, but server remains authority.
- During exam no correct answers or explanations are returned; only confirmation that response is saved.
- Submit locks all answers; score `correct / question_count * 100` rounded to two decimals; unanswered wrong. Result shows pass/fail and review **only after submission**.
- If active question bank has fewer questions than config, use all available and show actual count, rather than silently failing or inventing items.

### Admin
- Admin home reports users, active questions, published modules, attempts.
- Edit each lesson Markdown & published status.
- Filter question bank by module, edit/add MCQ, turn active status on/off.
- Edit each module exam config (count, duration, pass score).
- Seed loads curated questions idempotently; it does not overwrite admin-edited questions on subsequent runs.

### Data & operations
- `questions` independent of immutable `attempt_items` snapshots.
- PostgreSQL session table created on app startup; HTTPS/Nginx reverse proxy.
- `/healthz` exposes only simple service status, never secrets.
- Curriculum draft modules are NOT selectable for practice/exam until published.

## 5. Data model
`users (1) -> (N) attempts` 
`courses (1) -> (N) modules (1) -> (N) lessons` 
`modules (1) -> (N) questions (1) -> (4) question_options`
`attempts (1) -> (N) attempt_items (option snapshot, chosen option, result)`
`users (N) <-> lessons (N)` via `lesson_progress`
`modules (1) -> (1) exam_configs`

SQL definition: `db/001_schema.sql`. Original Pronouns bank: `db/002_pronouns.sql` and `db/pronouns_bank.json`. Expansion: `db/003_expanded_curriculum.sql` generated by `scripts/build-expanded.py` from authored lesson/query data, plus auditable `db/expanded_lessons.json` and `db/expanded_bank.json`. To apply: `npm run db:seed:all` on a new install, or `npm run db:seed:extra` if already seeded with Pronouns. Do not re-run schema destructively.

## 6. Nonfunctional requirements
- All responsive for >=320px viewport, usable with keyboard, touch targets ~44px, clear focus ring, descriptive labels.
- No client-side scores. Parameterized SQL queries for every user-entered value. Password bcrypt cost >=12. CSRF on all writes. Generic auth error text.
- Avoid automatic external calls in sensitive APIs; bootstrap/icon CSS CDN can be self-hosted later for offline deployment.
- Database backup with `pg_dump`, image/markdown backups when supported; verify restore before production.
- Content editing uses Markdown with inline HTML disabled. Seed examples adapted/verified for grammatical accuracy; photographic pages are **source material**, not automatically OCR'd/copy-pasted verbatim.
- Test plan: auth/session, public access, permissions, negative CSRF, question uniqueness, correct-flag count, exam timeout, answer order, persistence/reload, unauthorized attempt ID, UI at 390px and 1440px.

## 7. Implementation path
P0 — Create DB, run schema+seed, first admin, open public modules. (included)
P1 — CRUD lessons/questions/config, user dashboard, practice and exam. (included)
P2 — 12 new module lessons + seedable banks (included); CSV import, richer question types and usage analytics (planned).
P3 — bulk generation with human review, class/group management, detailed assessment report, mobile offline PWA. (planned)

## 8. Assumptions
- All lessons readable without login; only *Practice* and *Exam* require login.
- The standard seed keeps the Pronouns MVP. The additional seed publishes 12 drafted modules when they have no existing lessons, inserts 48 lessons and 1,200 MCQs, and preserves admin edits on subsequent runs.
- Questions are authored from rules and vocabulary in the photo topics and built from reviewed templates; they are NOT verbatim copies. Automated validation covers uniqueness/format, NOT a full professional assessment of all 1,305 answer semantics.
- v1 supports scored Multiple Choice (MCQ). Future DB revisions should be used for fill-blank and sentence-correction scoring, not assumed to exist already.
