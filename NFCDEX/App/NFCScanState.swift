import Foundation

struct NFCDiagnosticResult: Equatable, Sendable {
    let protocolType: NFCProtocolType
    let identifierByteCount: Int
    let fingerprint: TagFingerprint
}

enum NFCScanFailure: Error, Equatable, Sendable {
    case readerUnavailable
    case multipleTagsDetected
    case connectionFailed
    case readerError(code: Int)
}

enum NFCUnsupportedReason: Equatable, Sendable {
    case noStableHardwareIdentifier(protocolType: NFCProtocolType)
    case unknownTagProtocol
}

enum NFCScanState: Equatable, Sendable {
    case idle
    case scanning
    case success(NFCDiagnosticResult)
    case cancelled
    case error(NFCScanFailure)
    case unsupported(NFCUnsupportedReason)
}

struct NFCScanStateMachine {
    private(set) var state: NFCScanState = .idle

    @discardableResult
    mutating func begin(isReaderAvailable: Bool) -> Bool {
        guard isReaderAvailable else {
            state = .unsupported(.unknownTagProtocol)
            return false
        }

        state = .scanning
        return true
    }

    mutating func succeed(with result: NFCDiagnosticResult) {
        state = .success(result)
    }

    mutating func cancel() {
        state = .cancelled
    }

    mutating func fail(with failure: NFCScanFailure) {
        state = .error(failure)
    }

    mutating func markUnsupported(_ reason: NFCUnsupportedReason) {
        state = .unsupported(reason)
    }

    mutating func reset() {
        state = .idle
    }
}
