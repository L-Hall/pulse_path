import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ble_hrv_providers.dart';
import '../widgets/ble_capture_progress_widget.dart';
import '../widgets/ble_device_status_widget.dart';
import '../../domain/services/ble_hrv_integration_service.dart';

/// Page for capturing HRV data from connected BLE device
class BleHrvCapturePage extends ConsumerStatefulWidget {
  const BleHrvCapturePage({super.key});

  @override
  ConsumerState<BleHrvCapturePage> createState() => _BleHrvCapturePageState();
}

class _BleHrvCapturePageState extends ConsumerState<BleHrvCapturePage> {
  bool _isCapturing = false;

  @override
  Widget build(BuildContext context) {
    final integrationService = ref.watch(bleHrvIntegrationProvider);
    final progressStream = ref.watch(bleHrvProgressProvider);
    final captureStats = integrationService.getStats();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BLE HRV Capture'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Status
            BleDeviceStatusWidget(stats: captureStats),
            
            const SizedBox(height: 24),
            
            // Instructions
            _buildInstructions(context),
            
            const SizedBox(height: 24),
            
            // Progress Display
            Expanded(
              child: progressStream.when(
                data: (progress) => _buildProgressContent(context, progress),
                loading: () => _buildReadyContent(context, integrationService),
                error: (error, stack) => _buildErrorContent(context, error.toString()),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            _buildActionButtons(context, integrationService, captureStats),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'HRV Capture Instructions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '1. Ensure your heart rate monitor is properly fitted\n'
              '2. Find a quiet, comfortable position\n'
              '3. Breathe normally and remain still during capture\n'
              '4. The capture will take 3 minutes for optimal accuracy',
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadyContent(BuildContext context, BleHrvIntegrationService service) {
    final isReady = service.isReadyForCapture;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isReady ? Icons.favorite : Icons.bluetooth_disabled,
          size: 80,
          color: isReady 
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
        ),
        const SizedBox(height: 16),
        Text(
          isReady ? 'Ready to Capture HRV' : 'Device Not Ready',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          isReady 
              ? 'Your heart rate monitor is connected and ready for HRV analysis'
              : 'Please connect a heart rate monitor to continue',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressContent(BuildContext context, BleHrvCaptureProgress progress) {
    return BleCaptureProgressWidget(progress: progress);
  }

  Widget _buildErrorContent(BuildContext context, String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 80,
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        Text(
          'Capture Error',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          error,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context, 
    BleHrvIntegrationService service,
    BleHrvCaptureStats stats,
  ) {
    if (stats.isCapturing) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            service.stopCapture();
            setState(() => _isCapturing = false);
          },
          icon: const Icon(Icons.stop),
          label: const Text('Stop Capture'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: service.isReadyForCapture && !_isCapturing
              ? () => _startCapture(service)
              : null,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start HRV Capture'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back to Dashboard'),
        ),
      ],
    );
  }

  Future<void> _startCapture(BleHrvIntegrationService service) async {
    setState(() => _isCapturing = true);

    try {
      final result = await service.startHrvCapture();
      
      if (mounted) {
        if (result.isSuccess) {
          _showSuccessDialog(result.reading!);
        } else {
          _showErrorDialog(result.errorMessage!);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Unexpected error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
    }
  }

  void _showSuccessDialog(dynamic reading) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('HRV Capture Successful!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your HRV data has been captured and analyzed successfully.'),
            const SizedBox(height: 16),
            Text('RMSSD: ${reading.metrics.rmssd.toStringAsFixed(1)} ms'),
            Text('Stress Score: ${reading.scores.stress}'),
            Text('Recovery Score: ${reading.scores.recovery}'),
            Text('Energy Score: ${reading.scores.energy}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Return to dashboard
            },
            child: const Text('View Dashboard'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Capture Failed'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}