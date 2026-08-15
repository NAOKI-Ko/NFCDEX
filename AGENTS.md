# AGENTS.md

## Project identity

NFCDEXは、現実世界のNFCをスキャンすると、そのNFCに固定された変な生物と固有音を発見・収集できる「NFC × 生物図鑑 × 宝探し」のバカゲーです。

## Source of truth

実装・文書変更の前に、次の順序で読みます。

1. ユーザーが明示した最新指示
2. NotionのNFCDEX親ページと `01 PRODUCT_SPEC`〜`06 ASSET_PLAN`
3. `docs/START_HERE.md`
4. `docs/PROJECT_STATE.md`
5. `docs/PRODUCT_SPEC.md`
6. `docs/GAME_RULES.md`
7. `docs/IMPLEMENTATION_PLAN.md`
8. `docs/QA_CHECKLIST.md`
9. `docs/CODEX_REPORT.md`
10. `docs/REVIEW_LOG.md`
11. 実装・テスト・Git履歴

`docs/ai-memory/`はportableな補助indexです。標準docsの代替ではなく、矛盾した場合は標準docsを正とします。

## Work Unit contract

`Scope → Implementation → Build → Test → Evidence → Commit → Push → SHA verification → Report → Human review → Stop`

- 1回にactiveにできるWUは1つです。
- ユーザーが指定したWUだけを実行し、次WUへ自動進行しません。
- Notionで確定した確率・identity・version・securityルールを独自変更しません。
- secret、秘密鍵、token、実ユーザーデータをcommitしません。
- force pushは禁止です。
- External SDK、Backend、Supabaseは明示承認なしに追加しません。

## Current stop gate

WU-01 Correction Pass完了後に停止します。次を開始してはいけません。

- WU-02A CoreNFC Input + Fingerprint
- WU-02B Creature Catalog + Resolver
- WU-02C Audio / Haptics / Effect Runtime
- SwiftData model、Discovery UI、Official NFC crypto、Backend、External SDK

