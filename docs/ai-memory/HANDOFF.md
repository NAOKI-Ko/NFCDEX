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

- WU-01はreviewed commit `19698e602cd6acb368b6c29317188c1e404103cc`でAPPROVED。
- Next authorized workはWU-02A — NFC Input + Fingerprint。ただし、このReview Syncでは開始しない。
- 明示的なWU-02A実行依頼を受けるまで停止する。
- CoreNFC、CreatureResolver、SwiftData、Audio/Haptics、Discovery UI、Official NFC cryptoを実装しない。
- Backend、Supabase、External SDKを追加しない。

## Resume safety

- 作業開始前にlocal/remote SHA、ahead/behind、dirty stateを確認する。
- Public visibilityを維持し、Privateへ戻さない。
- Notion仕様と標準Git docsに差異があれば実装を止め、Human Gateへ戻す。
