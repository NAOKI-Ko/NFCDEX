# PRODUCT_SPEC — NFCDEX

Notion source: [01 PRODUCT_SPEC — NFCDEX](https://app.notion.com/p/3bd8c2d3ffd08146b345e54a9ae5355a)

## Product definition

- Product: NFC生物図鑑（仮）
- Development name / Resume Key: `NFCDEX`
- One-line: 現実世界のNFCをスキャンすると、そのNFCに固定された変な生物と固有音を発見・収集できる「NFC × 生物図鑑 × 宝探し」のバカゲー。

## Opportunity

日常にあるNFCを便利機能ではなく「未知の生物が住むゲームオブジェクト」に変換し、技術理解ではなく「これ何が出る？」という好奇心を生む。

## Product principles

1. Scan first — 起動からscanまで最短。
2. Same tag, same creature — 同じNFCには同じ生物・同じ個体差が住む。
3. Stupid but collectible — くだらない見た目と音でも図鑑として収集したくなる。
4. Rarity must feel different — 音・間・haptics・画面演出でrarity差を体感させる。
5. Offline by default — MVPのコア体験は完全ローカル。
6. Official tags are exceptional — 公式NFCを通常NFCと明確に区別する。

## MVP user stories

- 1操作でNFC scanを開始できる。
- 初めてのNFCから生物を発見できる。
- 同じNFCを再scanすると同じ生物・variantに再会できる。
- 発見済みspeciesを図鑑で確認し、固有音を再生できる。
- 未発見枠を見て別のNFCを探したくなる。
- RARE以上で明確な当たり感を得る。
- 公式NFCで通常と別格の体験を得る。
- 発見結果を画像として共有できる。

## Functional contracts

### Scan / tag identity

- scan開始 / cancel / error / successを状態管理する。
- normal NFC identity v1のcanonical inputは`protocolType + hardwareIdentifier`。
- canonical inputをSHA-256し、内部`TagFingerprint`を生成する。
- MIFARE / ISO15693 / ISO7816はidentifier、FeliCaはIDmをhardware identity第一候補とする。
- NDEF payload単体をphysical tagの保証された一意IDとはみなさない。
- stable identifierを取得できないtagはunsupported / limited identityとして安全に扱う。
- NFCの生identifierは必要以上に永続化せず、保存にはfingerprintを使う。
- official NFCはsigned payload verification必須。hardware identifierだけでofficial / LEGENDARYにしない。

### Creature resolution

- normal tagは`fingerprint + resolverVersion → creature`のpure functionで解決する。
- MVPの`resolverVersion = 1`。
- catalog拡張やrule変更で既存NFCの個体をsilently changeさせない。
- creature = species + color / face / accessory variant。
- 図鑑コンプリートはspecies単位。variantはNFCに住む個体差として保持する。
- rarity / species / color / face / accessory / sound / effect profileは決定論的に解決する。
- ResolverはUI / persistenceから分離する。

### Discovery / encyclopedia / achievement / share

- 初発見のみfull reveal、再発見は短縮演出とし、多重scanを抑止する。
- 図鑑は発見済み / 未発見、rarity filter、detail、音再生、発見日時、scan count、お気に入り、共有を扱う。
- achievementは完全ローカルで、探索の副目標に限定する。
- share画像は端末内生成し、OS共有sheetへ渡す。

## Non-functional requirements

- 主要機能はnetworkなしで動作。
- Backendなし、Supabaseなし、account / cloud syncなし。
- 通常操作でデータ損失しない。
- NFC unavailable / denied / cancel / malformed inputから安全に復帰。
- 音とhapticsは設定でOFF可能。
- External SDKなしを原則とする。
- secretやofficial NFC private keyをapp / repoへ含めない。

## Out of scope

- Backend / Supabase / account / cloud sync
- friends / global ranking / location tracking / UGC
- store / event CMS / NFC write
- battle / training / level / gacha currency / daily reward / stamina / ad reward
- 通常NFCからの超低確率anomaly（MVP外）

## MVP success

- 初見ユーザーが説明なしでも別のNFCを探したくなる。
- COMMONとLEGENDARYの体験差を明確に説明できる。
- 「このNFCにはこの生物が住んでいる」と感じられる。
