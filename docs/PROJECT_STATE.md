# PROJECT_STATE — NFCDEX

- Last updated: 2026-08-15
- Product: NFC生物図鑑（仮）
- Development name / Resume Key: `NFCDEX`
- Repository: `NAOKI-Ko/NFCDEX`
- Visibility: Public
- Default branch: `main`
- Current authorized work: WU-01 Correction Pass only
- Current state: Correction Pass complete; exact remote commit review pending
- Next gate: ChatGPT exact-SHA review

## Completed foundation

- iOS 17+ SwiftUI application skeleton
- XCTest target and shared scheme
- standard Git docs under `docs/`
- Portable AI Memory pointer/index under `docs/ai-memory/`
- Build/Test evidence

## Correction scope completed

- 誤って混入した別プロジェクト文脈をAGENTS/README/AI Memoryから除去。
- Notion NFCDEXの01〜06を参照し、標準Git docsへproduct identity、game rules、WU境界、QA、asset rulesを同期。
- `docs/ai-memory/`を標準docsの代替ではない補助indexへ整理。
- SwiftUI skeletonの機能追加は行っていない。

## Frozen product contracts

- 同一NFC → 同一生物・同一variant。
- normal NFC identity v1: `protocolType + hardwareIdentifier → SHA-256 → TagFingerprint`。
- `resolverVersion = 1`。
- normal rarity: COMMON 72% / UNCOMMON 22% / RARE 6% / LEGENDARY 0% / SECRET 0%。
- LEGENDARYはMVPでは公式NFC専用。将来の超低確率anomalyはMVP外。
- creature = species + color / face / accessory variant。図鑑コンプリートはspecies単位。
- official NFCはsigned payload verification必須。hardware identifierだけでofficial扱いしない。
- Backendなし、Supabaseなし、External SDKなしを原則とする。

## Explicitly not started

- WU-02A CoreNFC Input + Fingerprint
- WU-02B Creature Catalog + Resolver
- WU-02C Audio / Haptics / Effect Runtime
- SwiftData model
- Discovery UI
- Official NFC crypto

## Open human decisions

- 正式アプリ名、brand assets、具体的なspecies catalog。
- distribution用Bundle ID / Apple Developer Team。
- Visual GateでのSECRET存在示唆、rarity演出、asset品質。
