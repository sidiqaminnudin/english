# SYSTEM MAP — He3x Self-hosted English LMS

**Status:** Implementable MVP v1.0  |  **Focus:** Pronouns  |  **Language:** Indonesia (UI) + English (lesson/examples)  |  **Targets:** Desktop & mobile

## 1. Goal, scope and guardrails
An educational website with **public published lessons** but authenticated practice and exams. One Express app, PostgreSQL, Bootstrap templates. Teachers/admin can maintain published content and the question bank without touching source files. Dedicated Pronouns curriculum and seeded question bank in this release; other modules from the supplied photo collection are pre-registered as unpublished curriculum for gradual digitalization. Do not silently publish incomplete placeholder lessons.

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
│   └── /learn/pronouns
│       ├── /learn/pronouns/subject-pronouns
│       ├── /learn/pronouns/object-pronouns
│       ├── /learn/pronouns/possessive-pronouns
│       ├── /learn/pronouns/reflexive-pronouns
│       ├── /learn/pronouns/demonstrative-pronouns
│       ├── /learn/pronouns/relative-pronouns
│       └── /learn/pronouns/interrogative-pronouns
├── /register  /login  POST /logout
├── /dashboard /history
├── /practice/pronouns [GET setup, POST start]
├── /exam/pronouns [GET rules, POST start]
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
| A. Fundamentals | Alphabet & Spelling | A-Z letter names, alphabet exercise, pronounce/spell words (vessel, weather, compass, etc.) | draft |
| A. Fundamentals | Family & Basic Vocabulary | family members, greetings, conversation starter, seasons | draft |
| A. Fundamentals | Cardinal & Ordinal Numbers | 1 to millions, decimals, fractions, mathematical symbols, years | draft |
| A. Fundamentals | Telling Time, Days & Dates | past/to, AM/PM, month/day/year vs day/month/year, day names | draft |
| B. Grammar | Countable & Uncountable Nouns | a/an, much/many, some/any, noun classifications | draft |
| B. Grammar | Singular & Plural Nouns | -s/-es/-ies/-ves, irregular plurals, exceptions | draft |
| B. Grammar | **Pronouns** | subject, object, possessive adjectives & pronouns, reflexive, demonstrative, relative, interrogative | **published** |
| B. Grammar | Simple Present Tense | nominal, verbal, do/does, -s/-es, adverbs frequency | draft |
| B. Grammar | Prepositions | time (in/on/at/for/since/during), place & movement | draft |
| B. Grammar | Conjunctions | reason, contrast, purpose, condition, time, addition | draft |
| B. Grammar | Adjectives & Adverbs | adverb of manner, -ly, irregular, adjective/verb differences | draft |
| B. Grammar | Degrees of Comparison | positive, comparative, superlative, irregular | draft |
| C. Communication | Giving Directions | turn left/right, crossroads, asking directions, route instructions | draft |

### Pronouns detailed lessons
1. **Subject Pronouns**: I, you, we, they, he, she, it; subject slot, agreement.
2. **Object Pronouns**: me, you, us, them, him, her, it; objects after verbs & prepositions.
3. **Possessive Forms**: my/your/our/their/his/her/its vs mine/yours/ours/theirs/his/hers; **its** != **it's**; no standalone *its* in usual possessive-pronoun tables.
4. **Reflexive Pronouns**: myself, yourself, himself, herself, itself, ourselves, yourselves, themselves; subject-object same, emphasis.
5. **Demonstrative Pronouns**: this/that/these/those; singular-plural, distance; pronoun vs determiner.
6. **Relative Pronouns**: who/whom/whose/which/that; restrictive relative clauses and possessives, avoid awkward ambiguity.
7. **Interrogative Pronouns**: who/whom/whose/which/what; subject/object/person/ownership/selection, modern conversational *who* vs formal *whom*.

Every lesson stores: title, Markdown body, bilingual examples, common mistakes, summary, free reading. Question bank tags per lesson and difficulty.

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

SQL definition: `db/001_schema.sql`. DB seed: `db/002_pronouns.sql` (generated, PostgreSQL-compatible, no external data fetching). Source questions: `db/pronouns_bank.json`.

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
P2 — Admin CSV import, richer question types, full curriculum transcription & QA, usage analytics. (planned)
P3 — bulk generation with human review, class/group management, detailed assessment report, mobile offline PWA. (planned)

## 8. Assumptions
- All lessons readable without login; only *Practice* and *Exam* require login.
- Pronouns is the only published learning module in this first deliverable. Unpublished placeholders preserve the full syllabus and can be activated when lessons/questions are ready.
- Questions are carefully curated illustrative exercises (not exact photocopies) to avoid errors/ambiguities in handwritten and older worksheets.
- v1 supports scored Multiple Choice (MCQ). Future DB revisions should be used for fill-blank and sentence-correction scoring, not assumed to exist already.
