import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/sync_status.dart';
import '../providers/cloud_sync_providers.dart';

/// Widget that displays the current sync status
class SyncStatusWidget extends ConsumerWidget {
  final bool compact;
  final VoidCallback? onTap;

  const SyncStatusWidget({
    super.key,
    this.compact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncStatusProvider);
    final theme = Theme.of(context);

    return syncStatus.when(
      data: (status) => _buildSyncStatusContent(context, status),
      loading: () => _buildLoadingContent(context),
      error: (error, _) => _buildErrorContent(context, error.toString()),
    );
  }

  Widget _buildSyncStatusContent(BuildContext context, AppSyncStatus status) {
    final theme = Theme.of(context);
    final icon = _getSyncIcon(status.state);
    final color = _getSyncColor(theme, status.state);
    final text = _getSyncText(status);

    if (compact) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                text,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text('Cloud Sync'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            if (status.pendingOperations > 0)
              Text(
                '${status.pendingOperations} pending operations',
                style: theme.textTheme.bodySmall,
              ),
            if (status.lastSuccessfulSync != null)
              Text(
                'Last sync: ${_formatLastSync(status.lastSuccessfulSync!)}',
                style: theme.textTheme.bodySmall,
              ),
          ],
        ),
        trailing: status.state == SyncState.syncing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    final theme = Theme.of(context);
    
    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            ),
            SizedBox(width: 4),
            Text('Loading...'),
          ],
        ),
      );
    }

    return const Card(
      child: ListTile(
        leading: CircularProgressIndicator(),
        title: Text('Cloud Sync'),
        subtitle: Text('Loading sync status...'),
      ),
    );
  }

  Widget _buildErrorContent(BuildContext context, String error) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.error;

    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 12, color: color),
            const SizedBox(width: 4),
            Text(
              'Error',
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: Icon(Icons.error_outline, color: color),
        title: const Text('Cloud Sync'),
        subtitle: Text('Error: $error'),
        onTap: onTap,
      ),
    );
  }

  IconData _getSyncIcon(SyncState state) {
    switch (state) {
      case SyncState.offline:
        return Icons.cloud_off;
      case SyncState.connecting:
        return Icons.cloud_queue;
      case SyncState.syncing:
        return Icons.cloud_sync;
      case SyncState.synced:
        return Icons.cloud_done;
      case SyncState.error:
        return Icons.cloud_off;
      case SyncState.paused:
        return Icons.pause_circle_outline;
    }
  }

  Color _getSyncColor(ThemeData theme, SyncState state) {
    switch (state) {
      case SyncState.offline:
        return theme.colorScheme.outline;
      case SyncState.connecting:
        return theme.colorScheme.primary;
      case SyncState.syncing:
        return theme.colorScheme.primary;
      case SyncState.synced:
        return theme.colorScheme.tertiary;
      case SyncState.error:
        return theme.colorScheme.error;
      case SyncState.paused:
        return theme.colorScheme.outline;
    }
  }

  String _getSyncText(AppSyncStatus status) {
    switch (status.state) {
      case SyncState.offline:
        return 'Offline';
      case SyncState.connecting:
        return 'Connecting...';
      case SyncState.syncing:
        return 'Syncing...';
      case SyncState.synced:
        return 'Synced';
      case SyncState.error:
        return 'Error';
      case SyncState.paused:
        return 'Paused';
    }
  }

  String _formatLastSync(DateTime lastSync) {
    final now = DateTime.now();
    final difference = now.difference(lastSync);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}