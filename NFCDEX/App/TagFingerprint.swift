import CryptoKit
import Foundation

enum NFCProtocolType: String, CaseIterable, Equatable, Sendable {
    case mifare
    case iso15693
    case iso7816
    case felica
}

enum NFCIdentityError: Error, Equatable {
    case missingHardwareIdentifier(protocolType: NFCProtocolType)
}

struct NFCHardwareIdentity: Equatable, Sendable {
    let protocolType: NFCProtocolType
    let hardwareIdentifier: Data

    init(protocolType: NFCProtocolType, hardwareIdentifier: Data) throws {
        guard !hardwareIdentifier.isEmpty else {
            throw NFCIdentityError.missingHardwareIdentifier(protocolType: protocolType)
        }

        self.protocolType = protocolType
        self.hardwareIdentifier = hardwareIdentifier
    }
}

struct TagFingerprint: Equatable, Sendable {
    static let formatVersion = 1
    private static let domain = "nfcdex.tag-fingerprint"

    let version: Int
    let digest: Data

    var hexDigest: String {
        digest.map { String(format: "%02x", $0) }.joined()
    }

    var diagnosticValue: String {
        "v\(version):\(hexDigest)"
    }

    static func make(from identity: NFCHardwareIdentity) -> TagFingerprint {
        let digest = SHA256.hash(data: canonicalData(for: identity))
        return TagFingerprint(version: formatVersion, digest: Data(digest))
    }

    static func canonicalData(for identity: NFCHardwareIdentity) -> Data {
        var canonical = Data("\(domain).v\(formatVersion)\u{0}".utf8)
        canonical.append(contentsOf: identity.protocolType.rawValue.utf8)
        canonical.append(0)
        canonical.append(identity.hardwareIdentifier)
        return canonical
    }
}
