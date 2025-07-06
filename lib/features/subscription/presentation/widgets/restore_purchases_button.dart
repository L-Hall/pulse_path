import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subscription_providers.dart';

/// Button for restoring previous purchases
class RestorePurchasesButton extends ConsumerWidget {
  const RestorePurchasesButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _restorePurchases(context, ref),
      child: Text(
        'Restore Purchases',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future<void> _restorePurchases(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Restoring purchases...'),
            ],
          ),
        ),
      );

      await ref.read(productPurchaserProvider.notifier).restorePurchases();

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Listen for the result
      ref.listen<AsyncValue<void>>(productPurchaserProvider, (previous, next) {
        next.when(
          data: (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchases restored successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          error: (error, _) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to restore purchases: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          loading: () {
            // Loading already handled above
          },
        );
      });
    } catch (error) {
      // Close loading dialog if open
      if (context.mounted) {
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to restore purchases: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}