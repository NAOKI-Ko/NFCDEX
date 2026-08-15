# Portable AI Memory — Index

このディレクトリは、特定のAIサービスや会話履歴に依存せず、Git cloneだけで作業状態を復元するための記憶層です。

## Reading order

1. `../../AGENTS.md` — 守るべき実行規約
2. `PROJECT_STATE.md` — 現在地と停止点
3. `WORK_UNITS.md` — WU境界と完了条件
4. `DECISIONS.md` — 採用済み判断と仮定
5. `HANDOFF.md` — 次の担当者向け再開手順

## Update contract

- 各WU完了時に全ファイルの整合性を確認します。
- 事実と未決定事項を分離し、会話だけに残さないでください。
- SHA、コマンド、テスト結果など再検証可能な事実はEvidenceへ記録します。
- credentialやsecretは記録しません。

