import Flutter
import UIKit
import AVFoundation

/// Native iOS bridge for camera PPG optimization
@objc class CameraPPGBridge: NSObject, FlutterPlugin {
    
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.pulsepath.example/camera_ppg",
            binaryMessenger: registrar.messenger()
        )
        let instance = CameraPPGBridge()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "optimizeCameraSettings":
            optimizeCameraSettings(call: call, result: result)
        case "setAdaptiveFlash":
            setAdaptiveFlash(call: call, result: result)
        case "getDeviceCapabilities":
            getDeviceCapabilities(result: result)
        case "configurePPGSettings":
            configurePPGSettings(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// Optimize camera settings for PPG capture
    private func optimizeCameraSettings(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            return
        }
        
        let deviceModel = UIDevice.current.model
        let systemVersion = UIDevice.current.systemVersion
        
        // Device-specific optimizations
        var optimizations: [String: Any] = [:]
        
        // iPhone-specific settings
        if deviceModel.contains("iPhone") {
            optimizations = getPhoneOptimizations()
        } else if deviceModel.contains("iPad") {
            optimizations = getTabletOptimizations()
        }
        
        // iOS version-specific features
        if #available(iOS 15.0, *) {
            optimizations["supportsAdvancedCapture"] = true
            optimizations["supportsCinematicMode"] = true
        }
        
        if #available(iOS 14.0, *) {
            optimizations["supportsDeepFusion"] = true
        }
        
        result(optimizations)
    }
    
    /// Configure adaptive flash based on ambient light
    private func setAdaptiveFlash(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let enabled = args["enabled"] as? Bool else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            return
        }
        
        let intensity = args["intensity"] as? Double ?? 0.5
        let ambientLight = args["ambientLight"] as? Double ?? 0.0
        
        // Calculate optimal flash settings
        let flashSettings = calculateFlashSettings(
            enabled: enabled,
            intensity: intensity,
            ambientLight: ambientLight
        )
        
        result(flashSettings)
    }
    
    /// Get device-specific camera capabilities
    private func getDeviceCapabilities(result: @escaping FlutterResult) {
        var capabilities: [String: Any] = [:]
        
        // Device info
        capabilities["deviceModel"] = UIDevice.current.model
        capabilities["systemVersion"] = UIDevice.current.systemVersion
        
        // Camera capabilities
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            capabilities["hasFlash"] = device.hasFlash
            capabilities["hasTorch"] = device.hasTorch
            capabilities["maxZoom"] = device.activeFormat.videoMaxZoomFactor
            
            // Frame rate capabilities
            let frameRates = device.activeFormat.videoSupportedFrameRateRanges.map { range in
                return [
                    "min": range.minFrameRate,
                    "max": range.maxFrameRate
                ]
            }
            capabilities["supportedFrameRates"] = frameRates
            
            // Resolution capabilities
            let dimensions = device.activeFormat.formatDescription.dimensions
            capabilities["maxResolution"] = [
                "width": dimensions.width,
                "height": dimensions.height
            ]
        }
        
        // Performance characteristics
        capabilities["processorType"] = getProcessorType()
        capabilities["memorySize"] = getMemorySize()
        capabilities["thermalState"] = ProcessInfo.processInfo.thermalState.rawValue
        
        result(capabilities)
    }
    
    /// Configure PPG-specific camera settings
    private func configurePPGSettings(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            return
        }
        
        let targetFrameRate = args["frameRate"] as? Double ?? 30.0
        let enableStabilization = args["stabilization"] as? Bool ?? true
        let focusMode = args["focusMode"] as? String ?? "auto"
        
        var configuration: [String: Any] = [:]
        
        // Frame rate optimization
        configuration["optimalFrameRate"] = getOptimalFrameRate(target: targetFrameRate)
        
        // Focus configuration
        configuration["focusSettings"] = getFocusSettings(mode: focusMode)
        
        // Exposure settings
        configuration["exposureSettings"] = getExposureSettings()
        
        // White balance
        configuration["whiteBalanceSettings"] = getWhiteBalanceSettings()
        
        // Image processing
        configuration["imageProcessing"] = getImageProcessingSettings()
        
        result(configuration)
    }
    
    // MARK: - Device-specific optimizations
    
    private func getPhoneOptimizations() -> [String: Any] {
        let deviceName = getDeviceName()
        
        var settings: [String: Any] = [
            "preferredFrameRate": 30.0,
            "useFlash": true,
            "stabilization": true
        ]
        
        // iPhone model-specific optimizations
        switch deviceName {
        case let name where name.contains("iPhone 15"):
            settings["preferredFrameRate"] = 60.0
            settings["supportsCinematicMode"] = true
            settings["useAdvancedISP"] = true
            
        case let name where name.contains("iPhone 14"):
            settings["preferredFrameRate"] = 60.0
            settings["supportsCinematicMode"] = true
            settings["useAdvancedISP"] = true
            
        case let name where name.contains("iPhone 13"):
            settings["preferredFrameRate"] = 60.0
            settings["supportsCinematicMode"] = true
            
        case let name where name.contains("iPhone 12"):
            settings["preferredFrameRate"] = 60.0
            settings["useNightMode"] = false // Disable for PPG
            
        case let name where name.contains("iPhone 11"):
            settings["preferredFrameRate"] = 30.0
            settings["useNightMode"] = false
            
        default:
            settings["preferredFrameRate"] = 30.0
        }
        
        return settings
    }
    
    private func getTabletOptimizations() -> [String: Any] {
        return [
            "preferredFrameRate": 30.0,
            "useFlash": false, // iPads typically don't have flash
            "stabilization": false,
            "focusMode": "manual"
        ]
    }
    
    // MARK: - Flash calculations
    
    private func calculateFlashSettings(enabled: Bool, intensity: Double, ambientLight: Double) -> [String: Any] {
        guard enabled else {
            return ["useFlash": false, "intensity": 0.0]
        }
        
        // Adaptive flash based on ambient light
        let adjustedIntensity: Double
        
        if ambientLight < 0.1 { // Very dark
            adjustedIntensity = min(intensity * 1.2, 1.0)
        } else if ambientLight < 0.3 { // Dim
            adjustedIntensity = intensity
        } else if ambientLight < 0.7 { // Moderate
            adjustedIntensity = intensity * 0.8
        } else { // Bright
            adjustedIntensity = max(intensity * 0.5, 0.1)
        }
        
        return [
            "useFlash": true,
            "intensity": adjustedIntensity,
            "mode": ambientLight < 0.2 ? "torch" : "auto",
            "duration": ambientLight < 0.1 ? "continuous" : "auto"
        ]
    }
    
    // MARK: - Camera configuration helpers
    
    private func getOptimalFrameRate(target: Double) -> Double {
        let deviceCapabilities = getDeviceName()
        
        // Modern iPhones can handle 60fps for PPG
        if deviceCapabilities.contains("iPhone 12") ||
           deviceCapabilities.contains("iPhone 13") ||
           deviceCapabilities.contains("iPhone 14") ||
           deviceCapabilities.contains("iPhone 15") {
            return min(target, 60.0)
        }
        
        // Older devices stick to 30fps
        return min(target, 30.0)
    }
    
    private func getFocusSettings(mode: String) -> [String: Any] {
        switch mode {
        case "manual":
            return [
                "mode": "manual",
                "position": 0.1, // Close focus for finger
                "locked": true
            ]
        case "macro":
            return [
                "mode": "auto",
                "range": "macro",
                "locked": false
            ]
        default:
            return [
                "mode": "auto",
                "range": "normal",
                "locked": false
            ]
        }
    }
    
    private func getExposureSettings() -> [String: Any] {
        return [
            "mode": "custom",
            "iso": 400, // Good for PPG capture
            "shutterSpeed": 1.0/60.0, // Match frame rate
            "bias": 0.0,
            "locked": true
        ]
    }
    
    private func getWhiteBalanceSettings() -> [String: Any] {
        return [
            "mode": "manual",
            "temperature": 3000, // Warm for skin tones
            "tint": 0,
            "locked": true
        ]
    }
    
    private func getImageProcessingSettings() -> [String: Any] {
        return [
            "enableHDR": false, // Disable for consistent PPG
            "enableNightMode": false,
            "enablePortraitMode": false,
            "enableDeepFusion": false,
            "enableSmartHDR": false,
            "colorSpace": "sRGB" // Standard color space
        ]
    }
    
    // MARK: - Device identification
    
    private func getDeviceName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value))!)
        }
        
        // Map identifier to readable name
        switch identifier {
        case "iPhone15,4", "iPhone15,5": return "iPhone 15"
        case "iPhone15,2", "iPhone15,3": return "iPhone 15 Pro"
        case "iPhone14,4", "iPhone14,5": return "iPhone 13 mini"
        case "iPhone14,2", "iPhone14,3": return "iPhone 13 Pro"
        case "iPhone14,6": return "iPhone SE (3rd generation)"
        case "iPhone14,7", "iPhone14,8": return "iPhone 14"
        case "iPhone13,1", "iPhone13,2": return "iPhone 12 mini"
        case "iPhone13,3", "iPhone13,4": return "iPhone 12 Pro"
        default: return identifier
        }
    }
    
    private func getProcessorType() -> String {
        let identifier = getDeviceName()
        
        if identifier.contains("iPhone 15") { return "A17 Pro" }
        if identifier.contains("iPhone 14") { return "A16 Bionic" }
        if identifier.contains("iPhone 13") { return "A15 Bionic" }
        if identifier.contains("iPhone 12") { return "A14 Bionic" }
        if identifier.contains("iPhone 11") { return "A13 Bionic" }
        
        return "Unknown"
    }
    
    private func getMemorySize() -> Int {
        return Int(ProcessInfo.processInfo.physicalMemory / 1024 / 1024 / 1024) // GB
    }
}