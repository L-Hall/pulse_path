import 'package:flutter/material.dart';
import '../../domain/services/ble_hrv_integration_service.dart';

/// Widget showing BLE HRV capture progress and status
class BleCaptureProgressWidget extends StatelessWidget {
  final BleHrvCaptureProgress progress;

  const BleCaptureProgressWidget({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status Icon
        _buildStatusIcon(context),
        
        const SizedBox(height: 24),
        
        // Progress Indicator
        if (progress.status == BleHrvCaptureStatus.capturing) ...[
          _buildProgressRing(context),
          const SizedBox(height: 24),
        ],
        
        // Status Text
        Text(
          _getStatusTitle(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          progress.message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 24),
        
        // Progress Details
        _buildProgressDetails(context),
        
        // Success Details (when completed)
        if (progress.status == BleHrvCaptureStatus.completed && progress.hrvReading != null)
          _buildSuccessDetails(context),
      ],
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    IconData icon;
    Color color;
    
    switch (progress.status) {
      case BleHrvCaptureStatus.starting:
        icon = Icons.play_arrow;
        color = Colors.blue;
        break;
      case BleHrvCaptureStatus.capturing:
        icon = Icons.favorite;
        color = Colors.red;
        break;
      case BleHrvCaptureStatus.analyzing:
        icon = Icons.analytics;
        color = Colors.purple;
        break;
      case BleHrvCaptureStatus.completed:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case BleHrvCaptureStatus.cancelled:
        icon = Icons.cancel;
        color = Colors.orange;
        break;
      case BleHrvCaptureStatus.error:
        icon = Icons.error;
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 60,
        color: color,
      ),
    );
  }

  Widget _buildProgressRing(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 8,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          // Progress circle
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress.progress,
              strokeWidth: 8,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
          // Percentage text
          Text(
            '${(progress.progress * 100).toInt()}%',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    context,
                    'Duration',
                    _formatDuration(progress.duration),
                    Icons.timer,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    context,
                    'RR Intervals',
                    '${progress.rrIntervalsCollected}',
                    Icons.favorite,
                  ),
                ),
              ],
            ),
            
            if (progress.status == BleHrvCaptureStatus.capturing) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress.progress,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessDetails(BuildContext context) {
    final reading = progress.hrvReading!;
    
    return Card(
      color: Colors.green.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  'HRV Analysis Results',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Key metrics
            Row(
              children: [
                Expanded(
                  child: _buildMetricItem(
                    context,
                    'RMSSD',
                    '${reading.metrics.rmssd.toStringAsFixed(1)} ms',
                  ),
                ),
                Expanded(
                  child: _buildMetricItem(
                    context,
                    'Mean RR',
                    '${reading.metrics.meanRr.toStringAsFixed(0)} ms',
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Scores
            Row(
              children: [
                Expanded(
                  child: _buildScoreItem(
                    context,
                    'Stress',
                    '${reading.scores.stress}',
                    Colors.red,
                  ),
                ),
                Expanded(
                  child: _buildScoreItem(
                    context,
                    'Recovery',
                    '${reading.scores.recovery}',
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildScoreItem(
                    context,
                    'Energy',
                    '${reading.scores.energy}',
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  String _getStatusTitle() {
    switch (progress.status) {
      case BleHrvCaptureStatus.starting:
        return 'Starting Capture';
      case BleHrvCaptureStatus.capturing:
        return 'Capturing HRV Data';
      case BleHrvCaptureStatus.analyzing:
        return 'Analyzing Data';
      case BleHrvCaptureStatus.completed:
        return 'Capture Complete!';
      case BleHrvCaptureStatus.cancelled:
        return 'Capture Cancelled';
      case BleHrvCaptureStatus.error:
        return 'Capture Failed';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}