import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/first_launch_service.dart';
import '../../../../core/di/injection_container.dart';
import '../providers/dashboard_providers.dart';

/// Dialog shown on first app launch to let users choose their data preference
class FirstLaunchDialog extends StatefulWidget {
  final VoidCallback onCompleted;

  const FirstLaunchDialog({
    super.key,
    required this.onCompleted,
  });

  @override
  State<FirstLaunchDialog> createState() => _FirstLaunchDialogState();
}

class _FirstLaunchDialogState extends State<FirstLaunchDialog>
    with TickerProviderStateMixin {
  UserDataChoice? _selectedChoice;
  bool _isProcessing = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        title: Column(
          children: [
            Icon(
              Icons.favorite,
              size: 48,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to PulsePath!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you like to start your HRV journey?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Sample Data Option
              _buildChoiceCard(
                choice: UserDataChoice.sampleData,
                theme: theme,
              ),
              
              const SizedBox(height: 16),
              
              // Start Fresh Option
              _buildChoiceCard(
                choice: UserDataChoice.startFresh,
                theme: theme,
              ),
              
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can change this choice later in settings',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isProcessing ? null : () {
              setState(() {
                _selectedChoice = UserDataChoice.sampleData;
              });
              _handleChoice();
            },
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: _isProcessing || _selectedChoice == null ? null : _handleChoice,
            child: _isProcessing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceCard({
    required UserDataChoice choice,
    required ThemeData theme,
  }) {
    final isSelected = _selectedChoice == choice;
    
    return GestureDetector(
      onTap: _isProcessing ? null : () {
        setState(() {
          _selectedChoice = choice;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  choice.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    choice.displayName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected 
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              choice.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer.withOpacity(0.8)
                    : theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleChoice() async {
    if (_selectedChoice == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final firstLaunchService = sl<FirstLaunchService>();
      
      // Save the user's choice
      await firstLaunchService.saveDataChoice(_selectedChoice!);
      
      // Mark first launch as completed
      await firstLaunchService.markFirstLaunchCompleted();
      
      // Close dialog and trigger callback
      if (mounted) {
        Navigator.of(context).pop();
        widget.onCompleted();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving preference: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

/// Provider-based method to show the first launch dialog
void showFirstLaunchDialogIfNeeded(BuildContext context, WidgetRef ref) async {
  try {
    final firstLaunchService = sl<FirstLaunchService>();
    final isFirstLaunch = await firstLaunchService.isFirstLaunch();
    
    if (isFirstLaunch && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FirstLaunchDialog(
          onCompleted: () {
            // Refresh dashboard data after choice is made
            ref.invalidate(smartDashboardDataProvider);
            ref.invalidate(dataSourceBreakdownProvider);
          },
        ),
      );
    }
  } catch (e) {
    debugPrint('Error checking first launch: $e');
  }
}