# Handoff

## Restore context

```sh
git clone https://github.com/NAOKI-Ko/NFCDEX.git
cd NFCDEX
git status --short --branch
git rev-parse HEAD
```

その後、`AGENTS.md`から`docs/ai-memory/INDEX.md`のreading orderを読みます。

## Verify foundation

```sh
xcodebuild build \
  -project NFCDEX.xcodeproj \
  -scheme NFCDEX \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath .derived-data \
  CODE_SIGNING_ALLOWED=NO
```

テストは`xcrun simctl list devices available`で利用可能な端末名を確認して実行します。

## Current handoff boundary

- WU-01完了報告で停止。
- WU-02A/B/Cへ進まない。
- 次の作業は、ユーザーが正本NFCDEXに基づく次WUを明示承認した後のみ開始。

## Safety

- secret、token、Apple Team ID、production identifierをdocsへ貼らない。
- GitHub remoteと想定visibility（現在はPublic）を作業前後に確認する。
- 作業開始前にlocal/remote SHAとdirty stateを確認する。
