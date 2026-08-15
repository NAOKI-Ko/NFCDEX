# AGENTS.md

## Scope

NFCDEXは家庭内貢献バランス可視化iOSアプリです。作業はWork Unit（WU）単位で実施し、承認されたWU以外へ進みません。

## Source of truth order

1. ユーザーが明示した最新のNFCDEX仕様・指示
2. `docs/ai-memory/PROJECT_STATE.md`
3. `docs/ai-memory/WORK_UNITS.md`
4. `docs/ai-memory/DECISIONS.md`
5. `docs/ai-memory/HANDOFF.md`
6. 実装・テスト・Git履歴

矛盾がある場合は上位を優先し、推測で後続WUへ進めないでください。

## Required workflow

`Scope → Implement → Build → Test → Evidence → Commit → Push → Local/Remote SHA verification → Report → Stop`

- 1回にactiveにできるWUは1つです。
- WUのOut of Scopeを変更しません。
- 完了時はPortable AI MemoryとEvidenceを実態に合わせて更新します。
- secret、token、実ユーザーデータ、個人情報をcommitしません。
- 外部依存の追加、production変更、後続WU開始は明示承認が必要です。

## WU-01 stop gate

WU-01完了後は報告して停止します。WU-02A、WU-02B、WU-02Cには着手しません。

