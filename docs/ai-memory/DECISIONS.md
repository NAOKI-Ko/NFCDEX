# Portable Decision Summary

詳細な仕様は`../PRODUCT_SPEC.md`と`../GAME_RULES.md`を正とします。

## Foundation decisions

- Repository: `NAOKI-Ko/NFCDEX`
- Visibility: Public（最新ユーザー指示）
- Default branch: `main`
- iOS 17+ SwiftUI skeleton + XCTest
- Backend / Supabaseなし
- External SDKなしを原則とする
- 開発名 / Resume Key: `NFCDEX`

## Frozen MVP decisions

- 同一NFCは同一生物・同一variantを返す。
- creature = species + color / face / accessory variant。
- 図鑑コンプリートはspecies単位。
- normal rarityはCOMMON 72% / UNCOMMON 22% / RARE 6% / LEGENDARY 0% / SECRET 0%。
- LEGENDARYはMVPでは公式NFC専用。将来の超低確率anomalyはMVP外。
- identity v1は`protocolType + hardwareIdentifier → SHA-256 → TagFingerprint`。
- `resolverVersion = 1`。catalog拡張で既存個体をsilently changeさせない。
- official NFCはsigned payload verification必須。hardware identifierだけではofficialにしない。
- 初期36音は自録り + 加工中心でrights trackingする。
