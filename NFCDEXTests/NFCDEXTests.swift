import XCTest
@testable import NFCDEX

final class NFCDEXTests: XCTestCase {
    func testFingerprintIsDeterministicAcrossRepeatedScans() throws {
        let identity = try NFCHardwareIdentity(
            protocolType: .mifare,
            hardwareIdentifier: Data([0x01, 0x02, 0xAB, 0xCD])
        )
        let expected = TagFingerprint.make(from: identity)

        for _ in 0..<100 {
            XCTAssertEqual(TagFingerprint.make(from: identity), expected)
        }
        XCTAssertEqual(expected.version, 1)
        XCTAssertEqual(expected.digest.count, 32)
        XCTAssertEqual(
            expected.hexDigest,
            "cb841fd840af85633c05eaf5d26045d42ef778123a0a7c8a0219e88d59e5d05c"
        )
    }

    func testProtocolDomainSeparation() throws {
        let identifier = Data([0xDE, 0xAD, 0xBE, 0xEF])
        let fingerprints = try NFCProtocolType.allCases.map { protocolType in
            TagFingerprint.make(
                from: try NFCHardwareIdentity(
                    protocolType: protocolType,
                    hardwareIdentifier: identifier
                )
            )
        }

        XCTAssertEqual(Set(fingerprints.map(\.hexDigest)).count, NFCProtocolType.allCases.count)
    }

    func testCanonicalInputIncludesVersionProtocolAndIdentifier() throws {
        let identity = try NFCHardwareIdentity(
            protocolType: .iso15693,
            hardwareIdentifier: Data([0x00, 0xFF])
        )

        XCTAssertEqual(
            TagFingerprint.canonicalData(for: identity),
            Data("nfcdex.tag-fingerprint.v1\u{0}iso15693\u{0}".utf8) + Data([0x00, 0xFF])
        )
    }

    func testEmptyHardwareIdentifierIsRejected() {
        XCTAssertThrowsError(
            try NFCHardwareIdentity(protocolType: .iso7816, hardwareIdentifier: Data())
        ) { error in
            XCTAssertEqual(
                error as? NFCIdentityError,
                .missingHardwareIdentifier(protocolType: .iso7816)
            )
        }
    }

    func testEverySupportedProtocolCreatesDomainIdentity() throws {
        for protocolType in NFCProtocolType.allCases {
            let identity = try NFCHardwareIdentity(
                protocolType: protocolType,
                hardwareIdentifier: Data([0x01])
            )

            XCTAssertEqual(identity.protocolType, protocolType)
            XCTAssertEqual(identity.hardwareIdentifier.count, 1)
        }
    }

    func testCancelledStateCanSafelyResetToIdle() {
        var stateMachine = NFCScanStateMachine()
        XCTAssertTrue(stateMachine.begin(isReaderAvailable: true))
        stateMachine.cancel()
        XCTAssertEqual(stateMachine.state, .cancelled)

        stateMachine.reset()
        XCTAssertEqual(stateMachine.state, .idle)
    }

    func testErrorStateCanSafelyResetToIdle() {
        var stateMachine = NFCScanStateMachine()
        XCTAssertTrue(stateMachine.begin(isReaderAvailable: true))
        stateMachine.fail(with: .connectionFailed)
        XCTAssertEqual(stateMachine.state, .error(.connectionFailed))

        stateMachine.reset()
        XCTAssertEqual(stateMachine.state, .idle)
    }

    func testUnavailableReaderIsDistinctFromUnknownTagProtocol() {
        var stateMachine = NFCScanStateMachine()

        XCTAssertFalse(stateMachine.begin(isReaderAvailable: false))
        XCTAssertEqual(stateMachine.state, .error(.readerUnavailable))
        XCTAssertNotEqual(stateMachine.state, .unsupported(.unknownTagProtocol))
    }

    func testMissingIdentifierIsNotMisclassifiedAsSuccess() {
        var stateMachine = NFCScanStateMachine()
        stateMachine.markUnsupported(.noStableHardwareIdentifier(protocolType: .felica))

        XCTAssertEqual(
            stateMachine.state,
            .unsupported(.noStableHardwareIdentifier(protocolType: .felica))
        )
    }
}
