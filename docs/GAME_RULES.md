# GAME_RULES — NFCDEX

Notion sources: [02 GAME_RULES — NFCDEX](https://app.notion.com/p/3bd8c2d3ffd081b3be2bd4421670080f), [06 ASSET_PLAN — NFCDEX](https://app.notion.com/p/3bd8c2d3ffd081a4a968d0903c514dff)

## Core rule

**1つのNFCには1つの生物が住む。** 同一`TagFingerprint`と同一`resolverVersion`からは、端末再起動後も同じspecies、color、face、accessory、sound、rarity、effect profileを返す。

## Normal rarity distribution — MVP fixed

| Rarity | Normal NFC | Role |
|---|---:|---|
| COMMON | 72% | 笑い・母数 |
| UNCOMMON | 22% | 小当たり |
| RARE | 6% | 明確な当たり |
| LEGENDARY | 0% | MVPでは公式NFC専用 |
| SECRET | 0% | 原則公式、通常UIで条件を明示しない |

- LEGENDARYはMVPでは公式NFC専用。
- 将来、通常NFCから天文学的確率で出るanomalyを別ルールで追加できる余地は残すが、MVPでは無効でありscope外。
- 分布は将来実装時に単一configで管理し、hard-codeを散在させない。

## Creature identity

`creature = species + colorVariant + faceVariant + accessoryVariant`

- `speciesID`: 図鑑上の基礎生物。図鑑コンプリート判定の単位。
- `colorVariantID`: 個体の色。
- `faceVariantID`: 個体の表情。
- `accessoryVariantID`: 個体の小物。`none`を許可。
- `attribute`: Flavor。MVPではgame effectを持たない。
- `soundID`, `rarity`, `effectProfile`も個体identityに含む。

species rarityとvariant rarityは独立する。同じCOMMON speciesでもcrown variantは存在できる。

## Variant distribution — MVP v1

### Color

- 5 variants
- 各20%

### Face

- 4 variants
- 各25%

### Accessory

| Variant | Probability |
|---|---:|
| none | 50% |
| hat | 20% |
| glasses | 15% |
| ribbon | 10% |
| crown | 5% |

- rarity / species / color / face / accessoryは、将来のResolverでdomain separatorを使って別々に導出する。
- 単一hashの同じmod結果を雑に使い回さない。

## Encyclopedia completion

- speciesを発見すると、そのspeciesを図鑑登録済みとする。
- variantは別speciesとしてカウントしない。
- 異なるNFCから同一speciesの異なるcolor / face / accessory個体が出現しうる。
- variant情報は発見個体側で保持し、「このNFCの個体」として表示する。
- variant全収集はMVPの達成条件にしない。

## Normal NFC identity v1

```text
protocolType + hardwareIdentifier
  → canonical input
  → SHA-256
  → TagFingerprint
```

- MIFARE / ISO15693 / ISO7816はidentifierを第一候補とする。
- FeliCaはIDmを第一候補とする。
- NDEF payload単体をphysical tagの保証された一意IDとはみなさない。
- stable hardware identifierを得られないtagをNDEFだけで固有NFCと断定しない。
- `resolverVersion = 1`。
- catalog拡張やrule変更で既存NFCの個体をsilently changeさせない。

## Official NFC

- signed payload verificationがPASSした場合のみofficial扱いする。
- hardware identifierだけでofficial / LEGENDARY扱いしない。
- official creatureはmanifestで明示的に固定する。
- official resolverをnormal resolverより優先する。
- malformed payload、unknown official ID、署名失敗はfail safeとし、LEGENDARYを表示しない。
- private keyをapp / repositoryへ含めない。

## First discovery / re-scan

### First discovery

- scan待機またはsilhouette
- rarityに応じたreveal
- 生物名 + rarity + sound
- 図鑑登録

### Re-scan

- full revealを繰り返さない。
- 同じ生物・variantが即登場し、固有音を鳴らす。
- `scanCount + 1`。
- 同一tag 10回等のachievement triggerにできる。

## Achievement rules — MVP

1. はじめまして — 初NFC
2. 生息調査 — 10 unique NFC
3. だいぶ探してる — 50 unique NFC
4. またお前か — 同じNFCを10回
5. ちょっと珍しい — UNCOMMON初発見
6. うおっ — RARE初発見
7. 本物だ — 公式NFC初発見
8. 100回かざした — total scan 100

報酬通貨は持たせず、探索の副目標に限定する。

## Sound inventory v0.1

| Rarity | Count | Role | Length guide |
|---|---:|---|---|
| COMMON | 20 | くだらない・即笑える | 0.2〜1.0秒 |
| UNCOMMON | 8 | ちょっと気持ちいい | 0.5〜1.5秒 |
| RARE | 5 | 明確な当たり | 1.0〜2.5秒 |
| LEGENDARY | 2 | 異常に豪華 | 2.5〜5.0秒 |
| SECRET | 1 | 予想外 | 自由 |

合計36音。自録り + 加工を中心とし、rights trackingを必須とする。

- 自録り / 自作を第一選択。
- 原音と加工後fileを両方保持する。
- 外部素材はcommercial use / modification / redistribution条件をasset ledgerへ記録できるものだけを使用する。
- 出所不明のSNS / meme / 映画 / game音源を使用しない。
- Webから音源を無断取得しない。

## Game feel

- COMMON演出は1秒前後。
- RARE以上は一拍溜める。
- LEGENDARYは意図的に過剰演出。skip手段を検討する。
- sound / haptics / revealのpeakを合わせる。
- 数字より先に体感でrarityが分かること。

## Do not introduce in MVP

- battle、training、level
- gacha currency、daily reward、stamina、ad reward
- location mission
- runtime AI image generation、3D、SpriteKit必須化
- Backend、Supabase、External SDK
