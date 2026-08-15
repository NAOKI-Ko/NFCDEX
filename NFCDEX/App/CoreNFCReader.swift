import Combine
import CoreNFC
import Foundation

protocol NFCReading: AnyObject {
    var state: NFCScanState { get }
    func startScanning()
    func cancelScanning()
    func reset()
}

final class CoreNFCReader: NSObject, ObservableObject, NFCReading {
    @Published private(set) var state: NFCScanState = .idle

    private let stateLock = NSLock()
    private var stateMachine = NFCScanStateMachine()
    private var session: NFCTagReaderSession?

    func startScanning() {
        guard transition({ $0.begin(isReaderAvailable: NFCTagReaderSession.readingAvailable) }) else {
            return
        }

        guard let session = NFCTagReaderSession(
            pollingOption: [.iso14443, .iso15693, .iso18092],
            delegate: self
        ) else {
            transition { $0.fail(with: .readerUnavailable) }
            return
        }
        session.alertMessage = "NFCタグをiPhone上部に近づけてください。"
        self.session = session
        session.begin()
    }

    func cancelScanning() {
        transition { $0.cancel() }
        session?.invalidate()
        session = nil
    }

    func reset() {
        session?.invalidate()
        session = nil
        transition { $0.reset() }
    }

    private func handle(identity: NFCHardwareIdentity, in session: NFCTagReaderSession) {
        let fingerprint = TagFingerprint.make(from: identity)
        let diagnostic = NFCDiagnosticResult(
            protocolType: identity.protocolType,
            identifierByteCount: identity.hardwareIdentifier.count,
            fingerprint: fingerprint
        )
        transition { $0.succeed(with: diagnostic) }
        session.alertMessage = "NFC identity v1を確認しました。"
        session.invalidate()
    }

    private func handleMissingIdentifier(
        protocolType: NFCProtocolType,
        in session: NFCTagReaderSession
    ) {
        transition {
            $0.markUnsupported(.noStableHardwareIdentifier(protocolType: protocolType))
        }
        session.invalidate(errorMessage: "安定したhardware identifierを取得できませんでした。")
    }

    @discardableResult
    private func transition<Result>(
        _ body: (inout NFCScanStateMachine) -> Result
    ) -> Result {
        stateLock.lock()
        let result = body(&stateMachine)
        let newState = stateMachine.state
        stateLock.unlock()

        if Thread.isMainThread {
            state = newState
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.state = newState
            }
        }
        return result
    }

    private var currentState: NFCScanState {
        stateLock.lock()
        defer { stateLock.unlock() }
        return stateMachine.state
    }
}

extension CoreNFCReader: NFCTagReaderSessionDelegate {
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {}

    func tagReaderSession(
        _ session: NFCTagReaderSession,
        didInvalidateWithError error: Error
    ) {
        self.session = nil

        switch currentState {
        case .idle, .success, .cancelled, .error, .unsupported:
            return
        default:
            break
        }

        let readerError = error as? NFCReaderError
        if readerError?.code == .readerSessionInvalidationErrorUserCanceled {
            transition { $0.cancel() }
        } else {
            transition { $0.fail(with: .readerError(code: readerError?.code.rawValue ?? -1)) }
        }
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        guard tags.count == 1, let tag = tags.first else {
            transition { $0.fail(with: .multipleTagsDetected) }
            session.invalidate(errorMessage: "NFCタグを1枚だけ近づけてください。")
            return
        }

        session.connect(to: tag) { [weak self] error in
            guard let self else { return }

            guard error == nil else {
                self.transition { $0.fail(with: .connectionFailed) }
                session.invalidate(errorMessage: "NFCタグへ接続できませんでした。")
                return
            }

            do {
                let identity: NFCHardwareIdentity
                switch tag {
                case .miFare(let mifare):
                    identity = try NFCHardwareIdentity(
                        protocolType: .mifare,
                        hardwareIdentifier: mifare.identifier
                    )
                case .iso15693(let iso15693):
                    identity = try NFCHardwareIdentity(
                        protocolType: .iso15693,
                        hardwareIdentifier: iso15693.identifier
                    )
                case .iso7816(let iso7816):
                    identity = try NFCHardwareIdentity(
                        protocolType: .iso7816,
                        hardwareIdentifier: iso7816.identifier
                    )
                case .feliCa(let felica):
                    identity = try NFCHardwareIdentity(
                        protocolType: .felica,
                        hardwareIdentifier: felica.currentIDm
                    )
                @unknown default:
                    self.transition { $0.markUnsupported(.unknownTagProtocol) }
                    session.invalidate(errorMessage: "未対応のNFC protocolです。")
                    return
                }

                self.handle(identity: identity, in: session)
            } catch NFCIdentityError.missingHardwareIdentifier(let protocolType) {
                self.handleMissingIdentifier(protocolType: protocolType, in: session)
            } catch {
                self.transition { $0.fail(with: .readerError(code: -1)) }
                session.invalidate(errorMessage: "NFC identityを生成できませんでした。")
            }
        }
    }
}
