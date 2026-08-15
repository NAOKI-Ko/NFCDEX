# Work Units

## WU-01 — Repository Bootstrap

### Goal

GitHub repositoryからcloneした担当者が、SwiftUI骨格をbuild/testでき、Git内のPortable AI Memoryだけで現在地を復元できる状態を作る。

### In scope

- GitHub repository（ユーザーの最新指示によりPublic）
- iOS SwiftUI application skeleton
- unit-test targetとshared scheme
- Portable AI Memory documents
- build/test evidence
- commit、push、local/remote SHA一致確認

### Out of scope

- NFCDEXの業務機能
- backend、database、authentication、sync
- production signing、App Store Connect、CI/CD
- WU-02A、WU-02B、WU-02Cの全作業

### Acceptance criteria

- `xcodebuild build` が成功する。
- `xcodebuild test` が成功する。
- repositoryがGitHub上でPublicとして作成されている。
- default branchへWU-01 commitがpushされる。
- local HEADとremote default branch SHAが一致する。
- Portable AI Memoryが停止点と再開手順を説明する。

### Completion gate

Evidenceを記録し、WU-01完了報告後に停止する。

## WU-02A / WU-02B / WU-02C

Status: Not started / Not authorized in this execution.

正本NFCDEXの次回指示を受けるまで、scopeを推測・展開しない。
