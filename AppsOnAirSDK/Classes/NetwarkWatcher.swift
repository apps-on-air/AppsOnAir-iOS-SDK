import Foundation
import Reachability

// Protocol to notify listeners about network state changes
protocol NetworkServiceDelegate: AnyObject {
    func networkStatusDidChange(status: Bool)
}

// Protocol to define network service functionality
protocol NetworkService {
    var delegate: NetworkServiceDelegate? { get set }
    func startMonitoring()
    func stopMonitoring()
}

// Implementation of network service using Reachability
class ReachabilityNetworkService: NetworkService {
    private let reachability = try! Reachability()
    weak var delegate: NetworkServiceDelegate?

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(_:)), name: .reachabilityChanged, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }

    func startMonitoring() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Error starting reachability notifier: \(error)")
        }
    }

    func stopMonitoring() {
        reachability.stopNotifier()
    }

    @objc private func networkChanged(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }

        let isConnected = reachability.connection != .unavailable
        delegate?.networkStatusDidChange(status: isConnected)
    }
}
