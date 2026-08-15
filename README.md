# NFCDEX

NFCDEXは、現実世界のNFCをスキャンすると、そのNFCに固定された変な生物と固有音を発見・収集できる「NFC × 生物図鑑 × 宝探し」のバカゲーです。

現在は **WU-02A NFC Input + Fingerprint実装・automated verification完了 / Human Device Gate待ち** です。CoreNFCから通常NFCのhardware identity候補を取得し、versioned domain separatorを含むSHA-256 TagFingerprint v1を生成するdiagnosticを収録しています。Raw hardware identifierは表示・永続化しません。CreatureResolver、SwiftData、Audio/Haptics、Discovery UI、Official NFC cryptoは未実装です。

## Foundation

- Repository: [NAOKI-Ko/NFCDEX](https://github.com/NAOKI-Ko/NFCDEX)
- Visibility: Public
- Default branch: `main`
- iOS 17+
- SwiftUI + XCTest
- CoreNFC diagnostic: MIFARE / ISO15693 / ISO7816 / FeliCa code paths
- TagFingerprint v1: CryptoKit SHA-256
- Backend / Supabaseなし
- External SDKなし

## Build / Test

```sh
xcodebuild build \
  -project NFCDEX.xcodeproj \
  -scheme NFCDEX \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath work/DerivedData \
  CODE_SIGNING_ALLOWED=NO

xcodebuild test \
  -project NFCDEX.xcodeproj \
  -scheme NFCDEX \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath work/TestDerivedData \
  CODE_SIGNING_ALLOWED=NO \
  ONLY_ACTIVE_ARCH=YES \
  ARCHS=arm64
```

## Start here

作業再開時は、[AGENTS.md](AGENTS.md)の後に[docs/START_HERE.md](docs/START_HERE.md)から標準docsを順番に読みます。`docs/ai-memory/`は標準docsへのportable indexであり、代替の正本ではありません。
