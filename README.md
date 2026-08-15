# NFCDEX

家庭内の家事・育児・見えない家事・家庭運営・経済的負担を記録し、貢献バランスを可視化するiOSアプリです。

現在は **WU-01 Repository Bootstrap** 完了時点です。SwiftUIの起動可能な最小骨格と、AIエージェントが別環境でも作業状態を復元できるPortable AI Memoryを収録しています。アプリ機能の実装はまだ開始していません。

## Requirements

- Xcode 26.6（検証環境）
- iOS 17.0+
- Swift 5

## Build / Test

```sh
xcodebuild build \
  -project NFCDEX.xcodeproj \
  -scheme NFCDEX \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath .derived-data \
  CODE_SIGNING_ALLOWED=NO

xcodebuild test \
  -project NFCDEX.xcodeproj \
  -scheme NFCDEX \
  -destination 'platform=iOS Simulator,name=<available simulator>' \
  -derivedDataPath .derived-data \
  CODE_SIGNING_ALLOWED=NO
```

## Start here

AIまたは人間が作業を再開するときは、[AGENTS.md](AGENTS.md) と [docs/ai-memory/INDEX.md](docs/ai-memory/INDEX.md) を先に読みます。

