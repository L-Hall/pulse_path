import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import '../../data/datasources/camera_ppg_datasource.dart';
import '../providers/hrv_providers.dart';
import '../providers/ppg_capture_providers.dart';
import '../../../../core/di/injection_container.dart';

/// Page for capturing HRV data using camera PPG
class HrvCapturePage extends ConsumerStatefulWidget {
  const HrvCapturePage({super.key});

  @override
  ConsumerState<HrvCapturePage> createState() => _HrvCapturePageState();
}

class _HrvCapturePageState extends ConsumerState<HrvCapturePage>
    with TickerProviderStateMixin {
  static const Duration _captureDuration = Duration(minutes: 3);
  
  late AnimationController _pulseController;
  late AnimationController _progressController;
  
  Timer? _captureTimer;
  Timer? _progressTimer;
  int _remainingSeconds = _captureDuration.inSeconds;
  bool _isCapturing = false;
  bool _showInstructions = true;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _progressController = AnimationController(
      duration: _captureDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    _captureTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  Future<void> _startCapture() async {
    try {
      setState(() {
        _isCapturing = true;
        _showInstructions = false;
      });

      // Initialize camera and start capture
      await ref.read(ppgCaptureNotifierProvider.notifier).startCapture();
      
      // Start progress animation
      _progressController.forward();
      
      // Start countdown timer
      _startCountdownTimer();
      
    } catch (e) {
      _showErrorDialog('Failed to start capture: $e');
      setState(() {
        _isCapturing = false;
        _showInstructions = true;
      });
    }
  }

  void _startCountdownTimer() {
    _captureTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });
      
      if (_remainingSeconds <= 0) {
        _completeCapture();
      }
    });
  }

  Future<void> _completeCapture() async {
    _captureTimer?.cancel();
    _progressController.stop();
    
    try {
      // Stop capture and get results
      final result = await ref.read(ppgCaptureNotifierProvider.notifier).stopCapture();
      
      if (result != null && result.rrIntervals.isNotEmpty) {
        // Process the captured data
        await _processHrvData(result.rrIntervals);
        _showSuccessDialog();
      } else {
        _showErrorDialog('Insufficient data captured. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('Failed to complete capture: $e');
    } finally {
      _resetCapture();
    }
  }

  Future<void> _processHrvData(List<double> rrIntervals) async {
    try {
      // Process the RR intervals through the HRV reading pipeline
      await ref.read(hrvReadingNotifierProvider.notifier).processReading(
        rrIntervals: rrIntervals,
        timestamp: DateTime.now(),
        durationSeconds: _captureDuration.inSeconds,
        notes: 'Camera PPG capture',
        tags: ['camera', 'ppg'],
      );
    } catch (e) {
      throw Exception('HRV processing failed: $e');
    }
  }

  void _resetCapture() {
    setState(() {
      _isCapturing = false;
      _showInstructions = true;
      _remainingSeconds = _captureDuration.inSeconds;
    });
    _progressController.reset();
    _pulseController.reset();
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Capture Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Capture Complete'),
        content: const Text('Your HRV data has been successfully captured and analyzed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Return to previous screen
            },
            child: const Text('View Results'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ppgCaptureState = ref.watch(ppgCaptureNotifierProvider);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'HRV Capture',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_isCapturing)
            IconButton(
              onPressed: () {
                _captureTimer?.cancel();
                ref.read(ppgCaptureNotifierProvider.notifier).stopCapture();
                _resetCapture();
              },
              icon: const Icon(Icons.stop),
            ),
        ],
      ),
      body: ppgCaptureState.when(
        data: (captureData) => _buildCaptureInterface(captureData),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureInterface(PpgCaptureData? captureData) {
    return SafeArea(
      child: Column(
        children: [
          // Camera preview area
          Expanded(
            flex: 3,
            child: _buildCameraPreview(),
          ),
          
          // Instructions or real-time feedback
          Expanded(
            child: _showInstructions 
                ? _buildInstructions()
                : _buildRealTimeFeedback(captureData),
          ),
          
          // Progress and controls
          Expanded(
            child: _buildControlsArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isCapturing ? Colors.red : Colors.white,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Consumer(
          builder: (context, ref, child) {
            final cameraDataSource = sl<CameraPpgDataSource>();
            final controller = cameraDataSource.controller;
            
            if (controller != null && controller.value.isInitialized) {
              return AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              );
            }
            
            return Container(
              color: Colors.grey[900],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white54,
                      size: 64,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Camera Preview',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fingerprint,
            color: Colors.white,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'Place your finger over the camera',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Cover both the camera and flash completely\nwith your fingertip. Hold steady for 3 minutes.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRealTimeFeedback(PpgCaptureData? captureData) {
    final heartRate = captureData?.processingResult?.heartRate ?? 0.0;
    final signalQuality = captureData?.processingResult?.signalQuality ?? 0.0;
    final isValidSignal = captureData?.processingResult?.isValidSignal ?? false;

    // Update pulse animation based on heart rate
    if (heartRate > 0 && _isCapturing) {
      final bpm = heartRate;
      final pulseDuration = 60000 ~/ bpm; // milliseconds per beat
      _pulseController.duration = Duration(milliseconds: pulseDuration);
      if (!_pulseController.isAnimating) {
        _pulseController.repeat();
      }
    }

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Heart rate display with pulse animation
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Icon(
                  Icons.favorite,
                  color: isValidSignal ? Colors.red : Colors.white54,
                  size: 48,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Heart rate value
          Text(
            heartRate > 0 ? '${heartRate.round()} BPM' : '-- BPM',
            style: TextStyle(
              color: isValidSignal ? Colors.white : Colors.white54,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Signal quality indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getSignalQualityColor(signalQuality),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _getSignalQualityText(signalQuality),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlsArea() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Progress indicator
          if (_isCapturing) ...[
            AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressController.value,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              '${_formatTime(_remainingSeconds)} remaining',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ] else ...[
            // Start button
            ElevatedButton(
              onPressed: _startCapture,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Start Capture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getSignalQualityColor(double quality) {
    if (quality >= 0.8) return Colors.green;
    if (quality >= 0.6) return Colors.orange;
    if (quality >= 0.4) return Colors.yellow;
    return Colors.red;
  }

  String _getSignalQualityText(double quality) {
    if (quality >= 0.8) return 'Excellent signal';
    if (quality >= 0.6) return 'Good signal';
    if (quality >= 0.4) return 'Fair signal';
    if (quality >= 0.2) return 'Poor signal';
    return 'No signal';
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}