import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' show Size;
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

/// Data source for camera-based PPG (photoplethysmography) capture
class CameraPpgDataSource {
  CameraPpgDataSource._();
  
  static final CameraPpgDataSource _instance = CameraPpgDataSource._();
  factory CameraPpgDataSource() => _instance;

  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;
  StreamController<Uint8List>? _frameStreamController;

  /// Initialize camera with optimal settings for PPG detection
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      // Request camera permission
      final permission = await _requestCameraPermission();
      if (!permission) {
        throw CameraPpgException('Camera permission denied');
      }

      // Get available cameras
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraPpgException('No cameras available');
      }

      // Find rear camera (preferred for PPG)
      final rearCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      // Initialize camera controller with optimal settings
      _controller = CameraController(
        rearCamera,
        ResolutionPreset.low, // Low resolution for performance
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420, // Optimal for processing
      );

      await _controller!.initialize();

      // Configure camera settings for PPG
      await _configureCameraForPpg();

      _isInitialized = true;
      return true;
    } catch (e) {
      throw CameraPpgException('Failed to initialize camera: $e');
    }
  }

  /// Configure camera settings specifically for PPG detection
  Future<void> _configureCameraForPpg() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      // Set flash mode to torch for consistent illumination
      await _controller!.setFlashMode(FlashMode.torch);
      
      // Lock focus to prevent autofocus during capture
      await _controller!.setFocusMode(FocusMode.locked);
      
      // Set exposure mode to manual if supported
      await _controller!.setExposureMode(ExposureMode.locked);
      
      // Set white balance to prevent color temperature changes
      // await _controller!.setWhiteBalanceMode(WhiteBalanceMode.locked);
    } catch (e) {
      // Some settings might not be supported on all devices
      // Continue with default settings
    }
  }

  /// Request camera permission from user
  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    
    if (status.isGranted) {
      return true;
    }
    
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    }
    
    return false;
  }

  /// Start capturing frames for PPG analysis
  Stream<Uint8List> startCapture() {
    if (!_isInitialized || _controller == null) {
      throw CameraPpgException('Camera not initialized');
    }

    if (_isCapturing) {
      throw CameraPpgException('Capture already in progress');
    }

    _isCapturing = true;
    _frameStreamController = StreamController<Uint8List>.broadcast();

    // Start image stream
    _controller!.startImageStream((CameraImage image) {
      try {
        // Convert CameraImage to Uint8List for processing
        final frameData = _convertCameraImageToBytes(image);
        _frameStreamController?.add(frameData);
      } catch (e) {
        _frameStreamController?.addError(CameraPpgException('Frame processing error: $e'));
      }
    });

    return _frameStreamController!.stream;
  }

  /// Stop capturing frames
  Future<void> stopCapture() async {
    if (!_isCapturing) return;

    try {
      await _controller?.stopImageStream();
      _isCapturing = false;
      await _frameStreamController?.close();
      _frameStreamController = null;
    } catch (e) {
      throw CameraPpgException('Failed to stop capture: $e');
    }
  }

  /// Convert CameraImage to bytes for processing
  Uint8List _convertCameraImageToBytes(CameraImage image) {
    try {
      // For YUV420 format, we primarily need the Y (luminance) plane
      // which contains the brightness information needed for PPG
      final yPlane = image.planes[0];
      return yPlane.bytes;
    } catch (e) {
      throw CameraPpgException('Failed to convert camera image: $e');
    }
  }

  /// Toggle flash/torch for optimal illumination
  Future<void> setFlashEnabled(bool enabled) async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.setFlashMode(enabled ? FlashMode.torch : FlashMode.off);
    } catch (e) {
      throw CameraPpgException('Failed to control flash: $e');
    }
  }

  /// Adjust exposure for optimal PPG signal
  Future<void> setExposure(double value) async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      // Clamp exposure value to valid range
      final clampedValue = value.clamp(-4.0, 4.0);
      await _controller!.setExposureOffset(clampedValue);
    } catch (e) {
      // Exposure control might not be supported on all devices
    }
  }

  /// Get current camera resolution
  Size? get resolution {
    return _controller?.value.previewSize;
  }

  /// Check if camera is currently capturing
  bool get isCapturing => _isCapturing;

  /// Check if camera is initialized
  bool get isInitialized => _isInitialized;

  /// Get camera controller for UI preview
  CameraController? get controller => _controller;

  /// Dispose resources and cleanup
  Future<void> dispose() async {
    if (_isCapturing) {
      await stopCapture();
    }

    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }
}

/// Custom exception for camera PPG operations
class CameraPpgException implements Exception {
  final String message;
  
  const CameraPpgException(this.message);
  
  @override
  String toString() => 'CameraPpgException: $message';
}