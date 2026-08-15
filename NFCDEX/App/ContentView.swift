import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var reader = CoreNFCReader()
    @State private var baselineFingerprint: TagFingerprint?
    @State private var rescanMatchesBaseline: Bool?

    var body: some View {
        NavigationStack {
            List {
                Section("WU-02A Device Diagnostic") {
                    Label(statusTitle, systemImage: statusSymbol)

                    if case .success(let result) = reader.state {
                        LabeledContent("Protocol", value: result.protocolType.rawValue)
                        LabeledContent(
                            "Identifier length",
                            value: "\(result.identifierByteCount) bytes"
                        )
                        LabeledContent("Fingerprint format", value: "v\(result.fingerprint.version)")

                        Text(result.fingerprint.diagnosticValue)
                            .font(.caption.monospaced())
                            .textSelection(.enabled)
                            .accessibilityLabel("Tag fingerprint")

                        if let rescanMatchesBaseline {
                            Label(
                                rescanMatchesBaseline
                                    ? "Matches first scan in this launch"
                                    : "Does not match first scan in this launch",
                                systemImage: rescanMatchesBaseline
                                    ? "equal.circle.fill"
                                    : "exclamationmark.triangle.fill"
                            )
                            .foregroundStyle(rescanMatchesBaseline ? .green : .red)
                        } else {
                            Text("Scan the same tag again to verify this launch.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Device") {
                    LabeledContent("Model", value: UIDevice.current.model)
                    LabeledContent("iOS", value: UIDevice.current.systemVersion)
                }

                Section {
                    controls
                } footer: {
                    Text("Raw hardware identifiers and NDEF payloads are not displayed or persisted.")
                }
            }
            .navigationTitle("NFCDEX")
        }
        .accessibilityIdentifier("wu02a.nfc-diagnostic")
        .onChange(of: reader.state) { _, newState in
            guard case .success(let result) = newState else { return }

            if let baselineFingerprint {
                rescanMatchesBaseline = baselineFingerprint == result.fingerprint
            } else {
                baselineFingerprint = result.fingerprint
                rescanMatchesBaseline = nil
            }
        }
    }

    @ViewBuilder
    private var controls: some View {
        switch reader.state {
        case .scanning:
            Button("Cancel scan", role: .cancel) {
                reader.cancelScanning()
            }
        case .idle, .success, .cancelled, .error, .unsupported:
            Button("Scan NFC tag") {
                reader.startScanning()
            }

            if reader.state != .idle {
                Button("Reset diagnostic") {
                    reader.reset()
                }
            }
        }
    }

    private var statusTitle: String {
        switch reader.state {
        case .idle:
            "Ready"
        case .scanning:
            "Scanning"
        case .success:
            "Fingerprint generated"
        case .cancelled:
            "Cancelled — ready to reset or rescan"
        case .error(let failure):
            "Error: \(failure.description)"
        case .unsupported(let reason):
            "Unsupported: \(reason.description)"
        }
    }

    private var statusSymbol: String {
        switch reader.state {
        case .idle: "wave.3.right"
        case .scanning: "wave.3.right.circle"
        case .success: "checkmark.seal.fill"
        case .cancelled: "xmark.circle"
        case .error: "exclamationmark.triangle"
        case .unsupported: "nosign"
        }
    }
}

private extension NFCScanFailure {
    var description: String {
        switch self {
        case .readerUnavailable: "reader unavailable"
        case .multipleTagsDetected: "multiple tags detected"
        case .connectionFailed: "connection failed"
        case .readerError(let code): "reader error \(code)"
        }
    }
}

private extension NFCUnsupportedReason {
    var description: String {
        switch self {
        case .noStableHardwareIdentifier(let protocolType):
            "no stable identifier for \(protocolType.rawValue)"
        case .unknownTagProtocol:
            "NFC reader or protocol unavailable"
        }
    }
}
