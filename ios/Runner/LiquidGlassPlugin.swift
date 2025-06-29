import Flutter
import UIKit

/// Factory for creating Liquid Glass platform views on iOS 26+
public class LiquidGlassViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return LiquidGlassPlatformView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger
        )
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

/// Platform view implementation for Liquid Glass effects
class LiquidGlassPlatformView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var glassLayer: UIView?
    private var methodChannel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView(frame: frame)
        methodChannel = FlutterMethodChannel(
            name: "liquid_glass_\(viewId)",
            binaryMessenger: messenger!
        )
        super.init()

        setupLiquidGlassEffect(with: args)
        methodChannel.setMethodCallHandler(handleMethodCall)
    }

    func view() -> UIView {
        return _view
    }

    private func setupLiquidGlassEffect(with args: Any?) {
        guard let params = args as? [String: Any] else { return }
        
        let elevation = params["elevation"] as? Int ?? 1
        let borderRadius = params["borderRadius"] as? Double ?? 8.0

        // Check if iOS 26+ and UILiquidGlassMaterial is available
        // For now, use enhanced visual effect view
        setupEnhancedGlass(elevation: elevation, borderRadius: borderRadius)
    }

    private func setupEnhancedGlass(elevation: Int, borderRadius: Double) {
        // Create enhanced visual effect view for glass effect
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let glassView = UIVisualEffectView(effect: blurEffect)
        
        glassView.frame = _view.bounds
        glassView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        glassView.layer.cornerRadius = CGFloat(borderRadius)
        glassView.layer.masksToBounds = true
        
        // Add enhanced glass effects
        setupEnhancedGlassEffects(on: glassView, elevation: elevation)
        
        _view.addSubview(glassView)
        glassLayer = glassView
    }

    private func setupEnhancedGlassEffects(on view: UIView, elevation: Int) {
        // Add subtle border
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        // Add shadow based on elevation
        view.layer.shadowOpacity = Float(0.1 * elevation)
        view.layer.shadowRadius = CGFloat(2 * elevation)
        view.layer.shadowOffset = CGSize(width: 0, height: elevation)
        view.layer.shadowColor = UIColor.black.cgColor
        
        // Add specular highlight layer
        let highlightLayer = CAGradientLayer()
        highlightLayer.frame = view.bounds
        highlightLayer.colors = [
            UIColor.white.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ]
        highlightLayer.locations = [0.0, 0.3]
        highlightLayer.cornerRadius = view.layer.cornerRadius
        view.layer.addSublayer(highlightLayer)
    }

    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setTint":
            setTintColor(call.arguments, result: result)
        case "updateElevation":
            updateElevation(call.arguments, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setTintColor(_ arguments: Any?, result: @escaping FlutterResult) {
        guard let args = arguments as? [String: Any],
              let red = args["red"] as? Int,
              let green = args["green"] as? Int,
              let blue = args["blue"] as? Int,
              let alpha = args["alpha"] as? Int else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid tint color arguments", details: nil))
            return
        }

        let color = UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )

        DispatchQueue.main.async {
            // Apply tint to glass layer
            if let effectView = self.glassLayer as? UIVisualEffectView {
                effectView.contentView.backgroundColor = color.withAlphaComponent(0.1)
            }
        }

        result(nil)
    }

    private func updateElevation(_ arguments: Any?, result: @escaping FlutterResult) {
        guard let elevation = arguments as? Int else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid elevation value", details: nil))
            return
        }

        DispatchQueue.main.async {
            self.glassLayer?.layer.shadowOpacity = Float(0.1 * elevation)
            self.glassLayer?.layer.shadowRadius = CGFloat(2 * elevation)
            self.glassLayer?.layer.shadowOffset = CGSize(width: 0, height: elevation)
        }

        result(nil)
    }
}

/// Plugin registration for Liquid Glass views
public class LiquidGlassPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = LiquidGlassViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "liquid_glass_view")
        
        let channel = FlutterMethodChannel(name: "liquid_glass", binaryMessenger: registrar.messenger())
        let instance = LiquidGlassPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isSupported":
            result(true) // Always supported for demo
        case "getSystemTint":
            // Return current system tint color
            let systemTint = getCurrentSystemTint()
            result([
                "red": Int(systemTint.cgColor.components?[0] ?? 0) * 255,
                "green": Int(systemTint.cgColor.components?[1] ?? 0) * 255,
                "blue": Int(systemTint.cgColor.components?[2] ?? 0) * 255,
                "alpha": Int(systemTint.cgColor.components?[3] ?? 0) * 255
            ])
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getCurrentSystemTint() -> UIColor {
        // Return system accent color as fallback
        return UIColor.systemBlue
    }
}