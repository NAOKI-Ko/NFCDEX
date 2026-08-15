# PROJECT_STATE — NFCDEX

- Last updated: 2026-08-15
- Product: NFC生物図鑑（仮）
- Development name / Resume Key: `NFCDEX`
- Repository: `NAOKI-Ko/NFCDEX`
- Visibility: Public
- Default branch: `main`
- Last completed work: WU-01 — APPROVED
- Reviewed commit: `19698e602cd6acb368b6c29317188c1e404103cc`
- Current work unit: WU-02A — NFC Input + Fingerprint
- Review base: `64636be503905a232418dec094163ce4689a95e2`
- Current state: Implementation and automated verification complete; Human Device Gate pending
- Next authorized work: None
- Next gate: Physical iPhone NFC diagnostic, then exact-SHA review

## Completed foundation

- iOS 17+ SwiftUI application skeleton
- XCTest target and shared scheme
- standard Git docs under `docs/`
- Portable AI Memory pointer/index under `docs/ai-memory/`
- Build/Test evidence

## WU-02A implementation

- `NFCTagReaderSession` abstraction and scan states: idle / scanning / success / cancelled / error / unsupported。
- MIFARE `identifier`、ISO15693 `identifier`、ISO7816 `identifier`、FeliCa `currentIDm`をhardware identity候補へ変換。
- NFC Forum Type 4 NDEF AID `D2760000850101`とType 3 system code `12FC`をdiagnostic対象として宣言。
- canonical input: `nfcdex.tag-fingerprint.v1 NUL protocolType NUL hardwareIdentifier`。
- CryptoKit SHA-256によるversioned `TagFingerprint` v1。
- empty identifierはunsupportedとして扱い、fingerprintを生成しない。
- raw hardware identifier / NDEF payloadは表示・永続化しない。
- 実機用diagnosticはprotocol、identifier byte length、fingerprint、同一launch内rescan一致を表示。
- Unit Test: 9 tests / 0 failures。generic iOS device build: PASS。
- Human Device Gate: 接続iPhoneがunavailableのためpending。`evidence/WU-02A/HUMAN_GATE.md`を参照。

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

- WU-02B Creature Catalog + Resolver
- WU-02C Audio / Haptics / Effect Runtime
- SwiftData model
- Discovery UI
- Official NFC crypto

## Open human decisions

- 正式アプリ名、brand assets、具体的なspecies catalog。
- distribution用Bundle ID / Apple Developer Team。
- Visual GateでのSECRET存在示唆、rarity演出、asset品質。
- WU-02A実機gate用の利用可能iPhone、iOS version、test NFC tag/card。
