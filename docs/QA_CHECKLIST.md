# QA_CHECKLIST — NFCDEX

Notion source: [04 QA_CHECKLIST — NFCDEX](https://app.notion.com/p/3bd8c2d3ffd081c69e79e135b105de53)

## Gate definitions

- Automated: build / unit / integrationで検証。
- Visual: screenshot / recordingでreview。
- Human Device Gate: 実機NFC / sound / haptics。

## WU-01 Correction Pass gate

- [x] `AGENTS.md`のproduct identityがNFCDEX。
- [x] `README.md`のproduct identityがNFCDEX。
- [x] 必須標準docs 8件が存在。
- [x] `docs/ai-memory/`が標準docsの代替ではなく、矛盾禁止を明記。
- [x] normal rarity 72 / 22 / 6 / 0 / 0をGit docsへ同期。
- [x] creature = species + color / face / accessory variantを同期。
- [x] 図鑑コンプリートspecies単位を同期。
- [x] variant分布20%×5 / 25%×4 / accessory 50/20/15/10/5を同期。
- [x] identity v1、SHA-256 TagFingerprint、protocol candidates、NDEF制約を同期。
- [x] resolverVersion 1、catalog compatibilityを同期。
- [x] official signed payload requirementを同期。
- [x] sound inventory 20 / 8 / 5 / 2 / 1、rights trackingを同期。
- [x] Backend / Supabaseなし、External SDKなしを同期。
- [x] 旧project contamination search 0件。
- [x] Build PASS。
- [x] Test PASS（1 test / 0 failures）。
- [x] commit / push PASS。
- [x] local HEAD == origin/main。
- [x] ahead/behind 0/0。
- [x] working tree clean。

## WU-02A NFC / fingerprint gate

- [x] reader start / cancel / unavailable / unsupported state handling
- [x] cancel / error terminal stateからidleへreset可能
- [x] MIFARE / ISO15693 / ISO7816 identifier、FeliCa IDm code path
- [x] 同一入力100回で同一fingerprint
- [x] protocol domain separation
- [x] fixed SHA-256 test vector
- [x] empty identifierを固有NFCとして扱わない
- [x] NDEF payload単体をphysical identityにしない
- [x] raw hardware identifierをdiagnosticへ表示・永続化しない
- [x] Unit Test PASS（9 tests / 0 failures）
- [x] generic iOS device Build PASS
- [ ] MIFARE / ISO15693 / ISO7816 / FeliCaの実機identifier安定性
- [ ] 同一tagの複数scanで同一fingerprint — Human Device Gate
- [ ] app restart後も同一fingerprint — Human Device Gate
- [ ] 実機NFC read — Human Device Gate

## Future Resolver gate — not executed in WU-01

- [ ] 同一fingerprint + resolverVersionで同一creature
- [ ] app restart相当でも結果不変
- [ ] rarity bucket boundary
- [ ] color / face / accessory bucket boundary
- [ ] domain separator independence
- [ ] catalog expansion compatibility

## Future Discovery / persistence / UX gate — not executed in WU-01

- [ ] first discovery / re-scan / duplicate suppression
- [ ] SwiftData record、scan count、timestamps、favorite
- [ ] rarity演出差、Reduce Motion、sound/haptics OFF
- [ ] Encyclopedia / achievements / share

## Future official NFC security gate — not executed in WU-01

- [ ] valid signature PASS
- [ ] payload / signature tamper FAIL
- [ ] malformed envelope / unknown ID fail safe
- [ ] private keyがsource / bundle / docs / fixtureにない

## Release gate — not executed in WU-01

- [ ] device matrix / app launch / data migration
- [ ] privacy manifest / NFC usage / capabilities
- [ ] asset ledgerと全asset rights
- [ ] release buildとpushed SHAの1:1対応
- [ ] Notion / Git state sync
