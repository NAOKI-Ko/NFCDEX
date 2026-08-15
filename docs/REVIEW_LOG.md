# REVIEW_LOG — NFCDEX

## 2026-08-15 — WU-01 initial review

- Review target: `27da6d3872b107b27e3bceafd66b60e533bb3f1c`
- Decision: CHANGES REQUESTED
- Blocking findings:
  - `AGENTS.md`と`README.md`に別project identityが混入。
  - 必須標準Git docs 8件が欠落。
  - `docs/ai-memory/`が標準docsの代替になっていた。
- Required correction:
  - Notion NFCDEX仕様01〜06へ忠実に同期。
  - SwiftUI skeletonを維持し、アプリ機能を実装しない。
  - Public repositoryを維持。
  - WU-02A/B/Cを開始しない。

## 2026-08-15 — WU-01 Correction Pass

- Status: Implemented; exact correction commit is the Git commit containing this entry.
- Product identity corrected to「NFC × 生物図鑑 × 宝探しのバカゲー」。
- Required standard docs created。
- Portable AI Memory converted to pointers / summaries subordinate to standard docs。
- Notion phase-0 identity、rarity、variant、resolverVersion、official NFC、sound inventory、offline architecture rules mirrored。
- No application feature implementation。
- Next action: ChatGPT exact remote SHA review。
- Stop gate: WU-02A/B/C not authorized。
