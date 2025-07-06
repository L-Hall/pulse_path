import Foundation
import WatchConnectivity
import SwiftUI

// MARK: - HRV Data Models
struct HrvData {
    let stress: Int
    let recovery: Int
    let energy: Int
    let rmssd: Double
    let meanRR: Double
    let timestamp: Date
    let sessionId: String
}

struct UserPreferences {
    let adaptivePacingEnabled: Bool
    let notificationsEnabled: Bool
    let units: String
}

// MARK: - Watch Connectivity Manager
class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    
    @Published var currentHrvData: HrvData?
    @Published var userPreferences: UserPreferences?
    @Published var isReachable: Bool = false
    @Published var isPaired: Bool = false
    @Published var isInstalled: Bool = false
    
    private var session: WCSession?
    
    override init() {
        super.init()
        setupWatchConnectivity()
    }
    
    // MARK: - Setup
    private func setupWatchConnectivity() {
        guard WCSession.isSupported() else {
            print("WatchConnectivity not supported on this device")
            return
        }
        
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.updateConnectionStatus()
        }
        
        if let error = error {
            print("WCSession activation failed: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession deactivated")
        session.activate()
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.updateConnectionStatus()
        }
    }
    
    // MARK: - Message Handling
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        handleIncomingMessage(message)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        handleIncomingMessage(message)
        
        // Send acknowledgment
        let reply = ["status": "received", "timestamp": Date().timeIntervalSince1970]
        replyHandler(reply)
    }
    
    private func handleIncomingMessage(_ message: [String: Any]) {
        guard let type = message["type"] as? String else {
            print("Unknown message type received")
            return
        }
        
        DispatchQueue.main.async {
            switch type {
            case "hrv_reading":
                self.handleHrvReading(message)
            case "user_preferences":
                self.handleUserPreferences(message)
            case "app_state":
                self.handleAppState(message)
            default:
                print("Unhandled message type: \(type)")
            }
        }
    }
    
    private func handleHrvReading(_ message: [String: Any]) {
        guard let stress = message["stress"] as? Int,
              let recovery = message["recovery"] as? Int,
              let energy = message["energy"] as? Int,
              let rmssd = message["rmssd"] as? Double,
              let meanRR = message["meanRR"] as? Double,
              let timestampMs = message["timestamp"] as? Double,
              let sessionId = message["sessionId"] as? String else {
            print("Invalid HRV reading message format")
            return
        }
        
        let timestamp = Date(timeIntervalSince1970: timestampMs / 1000)
        
        self.currentHrvData = HrvData(
            stress: stress,
            recovery: recovery,
            energy: energy,
            rmssd: rmssd,
            meanRR: meanRR,
            timestamp: timestamp,
            sessionId: sessionId
        )
        
        print("HRV data updated: Stress=\(stress), Recovery=\(recovery), Energy=\(energy)")
        
        // Store in UserDefaults for persistence
        storeHrvData(currentHrvData!)
        
        // Update complications if needed
        updateComplications()
    }
    
    private func handleUserPreferences(_ message: [String: Any]) {
        let adaptivePacing = message["adaptivePacingEnabled"] as? Bool ?? true
        let notifications = message["notificationsEnabled"] as? Bool ?? true
        let units = message["units"] as? String ?? "metric"
        
        self.userPreferences = UserPreferences(
            adaptivePacingEnabled: adaptivePacing,
            notificationsEnabled: notifications,
            units: units
        )
        
        print("User preferences updated")
    }
    
    private func handleAppState(_ message: [String: Any]) {
        guard let state = message["state"] as? String else { return }
        
        print("App state updated: \(state)")
        
        // Handle different app states
        switch state {
        case "measurement_started":
            showMeasurementInProgress()
        case "measurement_completed":
            if let sessionId = message["sessionId"] as? String {
                handleMeasurementCompleted(sessionId)
            }
        case "sync_required":
            requestDataSync()
        default:
            break
        }
    }
    
    // MARK: - Sending Messages
    func sendMessageToPhone(_ message: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let session = session, session.isReachable else {
            print("Phone not reachable")
            completion(false)
            return
        }
        
        session.sendMessage(message, replyHandler: { reply in
            print("Message sent successfully, reply: \(reply)")
            completion(true)
        }) { error in
            print("Failed to send message: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func requestHrvMeasurement() {
        let message = [
            "type": "request_hrv_measurement",
            "timestamp": Date().timeIntervalSince1970
        ] as [String : Any]
        
        sendMessageToPhone(message) { success in
            if success {
                print("HRV measurement requested successfully")
            } else {
                print("Failed to request HRV measurement")
            }
        }
    }
    
    func sendUserAction(_ action: String, data: [String: Any]? = nil) {
        var message: [String: Any] = [
            "type": "watch_user_action",
            "action": action,
            "timestamp": Date().timeIntervalSince1970
        ]
        
        if let data = data {
            message.merge(data) { _, new in new }
        }
        
        sendMessageToPhone(message) { success in
            print("User action '\(action)' sent: \(success)")
        }
    }
    
    func requestComplicationData() {
        let message = [
            "type": "watch_complication_request",
            "timestamp": Date().timeIntervalSince1970
        ] as [String : Any]
        
        sendMessageToPhone(message) { success in
            print("Complication data requested: \(success)")
        }
    }
    
    // MARK: - Helper Methods
    private func updateConnectionStatus() {
        guard let session = session else { return }
        
        isReachable = session.isReachable
        isPaired = session.isPaired
        isInstalled = session.isWatchAppInstalled
        
        print("Connection status - Reachable: \(isReachable), Paired: \(isPaired), Installed: \(isInstalled)")
    }
    
    private func storeHrvData(_ data: HrvData) {
        let defaults = UserDefaults.standard
        
        defaults.set(data.stress, forKey: "lastStress")
        defaults.set(data.recovery, forKey: "lastRecovery")
        defaults.set(data.energy, forKey: "lastEnergy")
        defaults.set(data.timestamp, forKey: "lastTimestamp")
        defaults.set(data.sessionId, forKey: "lastSessionId")
        
        defaults.synchronize()
    }
    
    private func loadStoredHrvData() {
        let defaults = UserDefaults.standard
        
        guard defaults.object(forKey: "lastStress") != nil else { return }
        
        let stress = defaults.integer(forKey: "lastStress")
        let recovery = defaults.integer(forKey: "lastRecovery")
        let energy = defaults.integer(forKey: "lastEnergy")
        let timestamp = defaults.object(forKey: "lastTimestamp") as? Date ?? Date()
        let sessionId = defaults.string(forKey: "lastSessionId") ?? ""
        
        self.currentHrvData = HrvData(
            stress: stress,
            recovery: recovery,
            energy: energy,
            rmssd: 0.0, // Not stored in UserDefaults
            meanRR: 0.0, // Not stored in UserDefaults
            timestamp: timestamp,
            sessionId: sessionId
        )
    }
    
    private func showMeasurementInProgress() {
        // Show measurement in progress UI
        print("Measurement in progress")
    }
    
    private func handleMeasurementCompleted(_ sessionId: String) {
        // Handle measurement completion
        print("Measurement completed: \(sessionId)")
    }
    
    private func requestDataSync() {
        // Request data synchronization
        print("Data sync requested")
    }
    
    private func updateComplications() {
        // Update Watch complications with new data
        #if os(watchOS)
        import ClockKit
        
        if let complicationServer = CLKComplicationServer.sharedInstance() {
            complicationServer.activeComplications?.forEach { complication in
                complicationServer.reloadTimeline(for: complication)
            }
        }
        #endif
    }
}

// MARK: - iOS-specific extensions
#if os(iOS)
extension WatchConnectivityManager {
    func sessionWatchStateDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.updateConnectionStatus()
        }
    }
}
#endif