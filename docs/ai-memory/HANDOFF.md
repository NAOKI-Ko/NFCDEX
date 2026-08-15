# Handoff

## Restore

```sh
git clone https://github.com/NAOKI-Ko/NFCDEX.git
cd NFCDEX
git status --short --branch
git rev-parse HEAD
```

次に`AGENTS.md`と`docs/START_HERE.md`から標準docsを順番に読みます。

## Current boundary

- WU-02A implementation / automated verification完了。実機Human Device Gateは接続iPhone unavailableのためpending。
- `evidence/WU-02A/HUMAN_GATE.md`に従い、実機でrescan / restart determinismを確認する。
- WU-02B/Cを開始しない。
- CreatureResolver、SwiftData、Audio/Haptics、Discovery UI、Official NFC cryptoを実装しない。
- Backend、Supabase、External SDKを追加しない。

## Resume safety

- 作業開始前にlocal/remote SHA、ahead/behind、dirty stateを確認する。
- Public visibilityを維持し、Privateへ戻さない。
- Notion仕様と標準Git docsに差異があれば実装を止め、Human Gateへ戻す。
