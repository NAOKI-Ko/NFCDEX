# CODEX_REPORT — WU-02A NFC Input + Fingerprint

- Date: 2026-08-15
- Review base: `64636be503905a232418dec094163ce4689a95e2`
- Source of truth: Notion `05 CODEX_HANDOFF — NFCDEX`
- Scope: WU-02A only
- WU-02B/C: not started

## Implementation

- CoreNFC reader abstraction using `NFCTagReaderSession`。
- Scan states: idle / scanning / success / cancelled / error / unsupported。
- Hardware identity paths:
  - MIFARE `identifier`
  - ISO15693 `identifier`
  - ISO7816 `identifier`
  - FeliCa `currentIDm`
- NFC Forum diagnostic declarations:
  - Type 4 NDEF application AID `D2760000850101`
  - Type 3 system code `12FC`
- Canonical identity v1 uses a versioned domain separator, protocol type, and hardware identifier。
- SHA-256 via Apple CryptoKit; no external SDK。
- Empty identifiers fail closed as unsupported。
- NDEF payload is not used as physical identity。
- Raw hardware identifiers are neither displayed nor persisted。

## Unit Test

- Result: PASS
- Count: 9 tests / 0 failures
- Coverage: 100-run determinism、fixed digest vector、protocol domain separation、all four protocol domain inputs、empty-ID rejection、cancel/error reset、unavailable/unsupported handling。
- Simulator: iPhone 16 Pro Max simulator / iOS 26.5

## Build

- Result: PASS
- Destination: generic iOS device
- Configuration: Debug
- Code signing: disabled for CI-style compile verification
- CoreNFC entitlement and Info.plist NFC declarations: validated

## Human Device Gate

- Diagnostic presentation: implemented in `ContentView`。
- Displays only protocol、identifier byte length、fingerprint version/digest、same-launch rescan comparison、device/iOS。
- Connected device discovered: iPhone 17 (`iPhone18,3`)。
- Device state: unavailable。
- Tested physical tags/cards: none; physical scan is pending。
- Deterministic rescan: pending physical device。
- Restart result: pending physical device。
- Instructions and evidence template: `evidence/WU-02A/HUMAN_GATE.md`。

## Scope exclusions verified

- CreatureResolver / rarity / species / variants: not implemented
- SwiftData persistence: not implemented
- Discovery UI: not implemented; diagnostic-only presentation
- Audio / Haptics / effects: not implemented
- Official NFC crypto: not implemented
- Backend / Supabase / External SDK: not added
- WU-02B/C: not started

## Blockers

- Physical iPhone is unavailable to Xcode, so the required NFC Human Device Gate cannot be executed in this environment。

## Stop

Commit / push / Git verification後に停止する。WU-02B/Cへ進まない。
