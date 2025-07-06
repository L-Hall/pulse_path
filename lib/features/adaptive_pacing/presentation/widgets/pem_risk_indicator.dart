import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/adaptive_pacing_providers.dart';
import '../../../../shared/models/adaptive_pacing_data.dart';
import '../../../settings/domain/models/user_preferences.dart';

/// Widget displaying the current PEM risk level and pacing state
class PemRiskIndicator extends ConsumerWidget {
  const PemRiskIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pacingStatus = ref.watch(pacingStatusSummaryProvider);
    final pacingState = ref.watch(currentPacingStateProvider);
    final pemRisk = ref.watch(currentPemRiskProvider);
    final energyEnvelope = ref.watch(currentEnergyEnvelopeProvider);
    final warnings = ref.watch(trendWarningsProvider);
    final consecutiveHighRiskDays = ref.watch(consecutiveHighRiskDaysProvider);

    if (!(pacingStatus['hasAssessment'] as bool? ?? false)) {

      return _buildNoAssessmentState(context);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _getPacingStateGradient(context, pacingState),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _getPacingStateColor(pacingState).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pacingState?.type.emoji ?? '⚪',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pacingState?.type.displayName ?? 'Unknown State',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pacingState?.description ?? 'No assessment available',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              if (energyEnvelope != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$energyEnvelope%',

                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          if (pemRisk != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  _getPemRiskIcon(pemRisk),
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'PEM Risk: ${pemRisk.displayName}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],

          if (energyEnvelope != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.battery_charging_full,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Energy Envelope: $energyEnvelope%',

                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: energyEnvelope / 100.0,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (consecutiveHighRiskDays > 0) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$consecutiveHighRiskDays consecutive high-risk day${consecutiveHighRiskDays > 1 ? 's' : ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (warnings.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...warnings.take(2).map((warning) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      warning,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildNoAssessmentState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timeline,
            size: 32,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adaptive Pacing',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Take an HRV reading to get personalized pacing guidance',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Gradient _getPacingStateGradient(BuildContext context, PacingState? state) {
    if (state == null) {
      return LinearGradient(
        colors: [Colors.grey, Colors.grey.shade600],
      );
    }

    final baseColor = _getPacingStateColor(state);
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        baseColor,
        baseColor.withValues(alpha: 0.8),
      ],
    );
  }

  Color _getPacingStateColor(PacingState? state) {
    if (state == null) return Colors.grey;
    
    switch (state.type) {
      case PacingStateType.excellent:
        return const Color(0xFF4CAF50); // Green
      case PacingStateType.good:
        return const Color(0xFF8BC34A); // Light Green
      case PacingStateType.moderate:
        return const Color(0xFFFFC107); // Yellow
      case PacingStateType.caution:
        return const Color(0xFFFF9800); // Orange
      case PacingStateType.restRequired:
        return const Color(0xFFF44336); // Red
      case PacingStateType.recoveryMode:
        return const Color(0xFFB71C1C); // Dark Red
    }
  }

  IconData _getPemRiskIcon(PemRiskLevel pemRisk) {
    switch (pemRisk) {
      case PemRiskLevel.low:
        return Icons.check_circle;
      case PemRiskLevel.moderate:
        return Icons.warning;
      case PemRiskLevel.high:
        return Icons.error;
      case PemRiskLevel.critical:
        return Icons.dangerous;
    }
  }
}