# Decisions

## D-001 — Minimal native foundation

- Date: 2026-08-15
- Status: Accepted for WU-01
- Decision: SwiftUI + XCTestのみを使用し、third-party dependencyを追加しない。
- Reason: WU-01の再現可能な最小骨格に限定するため。

## D-002 — Deployment target

- Date: 2026-08-15
- Status: Provisional
- Decision: iOS 17.0以上。
- Reason: SwiftUIの安定したbaselineとして使用し、後続Human Gateで変更可能にするため。

## D-003 — Development identity

- Date: 2026-08-15
- Status: Provisional
- Decision: Product module `NFCDEX`、開発用Bundle ID `com.naoki.nfcdex`。
- Reason: signingなしのBuild/Testに必要な安定識別子。distribution確定を意味しない。

## D-004 — Git is portable memory

- Date: 2026-08-15
- Status: Accepted
- Decision: 現在地、WU境界、判断、再開手順を`docs/ai-memory/`へcommitする。
- Reason: 特定のAI会話・端末・vendor memoryへ依存しないため。

## D-005 — Repository visibility

- Date: 2026-08-15
- Status: Accepted by explicit user instruction
- Decision: `NAOKI-Ko/NFCDEX`をPublic repositoryとして運用する。
- Reason: 当初のPrivate指定は、作成直前のユーザー指示「publicでいいよ」により変更された。
