# VOA in-place replacement: preparation only

Operator confirmed the existing 2 listening runs (8 items) are TEST data and accepted audio/snapshot inconsistency after replacement. No runs deleted; replacement has NOT run.

Backup database: `D:\He3x\english\backups\before-v12-1792828994005.dump` (pg_restore --list passed).
Backup source including active audio: `D:\He3x\english\backups\before-voa-20261024-150314`.

Merged catalog, three patch scripts and transcript files. Added prepare-voa-transcripts.py to fetch source evidence, verify the MP3 URL appears in Conversation, extract published transcript text, and decode candidates with FFmpeg. Extracted text is not yet verified against listening; it may retain stage directions or explanatory notes from the source page.

Eight downloaded candidates are in `D:\He3x\english\src\public\audio\real`. These are statically accessible candidates, NOT the active track URLs. Exact source URLs and hashes are in `D:\He3x\english\backups\voa-source-pages\report.json` and the catalog.

| slug | decoded duration |
|---|---|
| at-the-library | 01:50.52 |
| weekend-plans | 02:57.24 |
| missed-the-bus | 03:29.89 |
| at-the-cafe | 03:39.32 |
| rainy-afternoon | 02:01.86 |
| asking-directions | 01:30.67 |
| new-job | 01:58.57 |
| at-the-clinic | 03:21.93 |

All eight decode and match source Conversation URLs. This does NOT prove human voices, exact spoken transcript, or correct answers by listening. The 32 questions remain unaudited against recordings. No listening/browser acceptance test performed. Lesson 21 transcript contains poetry/song/ukulele: specifically review rights for these elements before redistributing; general VOA original-content terms do not establish third-party rights. Source terms: https://learningenglish.voanews.com/p/6021.html.

BLOCKED pending listening review, question audit and asset-specific rights review. Do not execute replace-listening-v12-in-place.js until these are complete. Active MP3s, db/v12_listening.json, listening track/question rows and user history have not been replaced. Old dataset intentionally retained until approved replacement is ready. No commit/push/deployment performed.
