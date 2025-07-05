import 'package:flutter/material.dart';
import '../../domain/models/subscription_product.dart' as models;

/// Widget for displaying a subscription product option
class SubscriptionProductCard extends StatelessWidget {
  final models.SubscriptionProduct product;
  final bool isSelected;
  final bool isPopular;
  final VoidCallback? onTap;

  const SubscriptionProductCard({
    super.key,
    required this.product,
    this.isSelected = false,
    this.isPopular = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (isSelected) ...[
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ],
        ),
        child: Stack(
          children: [
            // Popular badge
            if (isPopular)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'POPULAR',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and duration
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getDisplayTitle(),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.onPrimaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            _getDurationText(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSelected 
                                  ? Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.price,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected 
                                ? Theme.of(context).colorScheme.onPrimaryContainer
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (_getSavingsText() != null)
                          Text(
                            _getSavingsText()!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Features
                _buildFeaturesList(),
                
                // Selection indicator
                if (isSelected) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayTitle() {
    switch (product.type) {
      case models.SubscriptionType.monthly:
        return 'Monthly Premium';
      case models.SubscriptionType.annual:
        return 'Annual Premium';
      case models.SubscriptionType.lifetime:
        return 'Lifetime Premium';
      case models.SubscriptionType.free:
        return 'Free';
    }
  }

  String _getDurationText() {
    switch (product.type) {
      case models.SubscriptionType.monthly:
        return 'Billed monthly';
      case models.SubscriptionType.annual:
        return 'Billed annually';
      case models.SubscriptionType.lifetime:
        return 'One-time payment';
      case models.SubscriptionType.free:
        return 'Free forever';
    }
  }

  String? _getSavingsText() {
    switch (product.type) {
      case models.SubscriptionType.annual:
        return 'Save 33%';
      case models.SubscriptionType.lifetime:
        return 'Best Value';
      default:
        return null;
    }
  }

  Widget _buildFeaturesList() {
    final features = product.features.take(3).toList(); // Show max 3 features on card
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Icon(
              Icons.check,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                feature,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8)
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}