# WU-02A Human Device Gate

Status: PENDING — physical iPhone unavailable to Xcode on 2026-08-15.

Detected device:

- Model: iPhone 17 (`iPhone18,3`)
- Xcode state: `unavailable`
- Device / iOS version: pending connection

## Diagnostic procedure

1. Connect and unlock an NFC-capable iPhone, enable Developer Mode, and select an Apple Development Team in Xcode if required.
2. Build and run NFCDEX on the physical iPhone.
3. Open `WU-02A Device Diagnostic` and scan one available NFC tag.
4. Record only detected protocol, identifier byte length, and the SHA-256 `v1:` fingerprint. Do not record the raw identifier.
5. Scan the same tag again and confirm `Matches first scan in this launch`.
6. Terminate the app, relaunch it, scan the same tag, and compare the safe fingerprint with step 4.
7. Record any unreadable tag/card type and the diagnostic behavior without exposing sensitive card data.

## Result template

- Device / iOS:
- Tested NFC tag/card type:
- Detected protocol:
- Hardware identifier available: yes / no
- Identifier byte length:
- Same-launch rescan fingerprint match: pass / fail
- App-restart fingerprint match: pass / fail
- Unsupported / unreadable cases:
- Raw identifier recorded: no

WU-02A cannot pass the Human Device Gate until these fields are completed from a physical NFC scan.
