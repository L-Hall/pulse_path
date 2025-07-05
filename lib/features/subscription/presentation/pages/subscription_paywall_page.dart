import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/subscription_providers.dart';
import '../widgets/subscription_product_card.dart';
import '../widgets/feature_comparison_widget.dart';
import '../widgets/restore_purchases_button.dart';
import '../../domain/models/subscription_product.dart' as models;

/// Subscription paywall page for selecting and purchasing subscriptions
class SubscriptionPaywallPage extends ConsumerStatefulWidget {
  const SubscriptionPaywallPage({super.key});

  @override
  ConsumerState<SubscriptionPaywallPage> createState() => _SubscriptionPaywallPageState();
}

class _SubscriptionPaywallPageState extends ConsumerState<SubscriptionPaywallPage> {
  models.SubscriptionProduct? selectedProduct;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize subscription service and load products
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSubscriptions();
    });
  }

  Future<void> _initializeSubscriptions() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(subscriptionInitializerProvider.notifier).initialize();
      await ref.read(subscriptionProductsProvider.notifier).loadProducts();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _purchaseProduct(models.SubscriptionProduct product) async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    try {
      await ref.read(productPurchaserProvider.notifier).purchaseProduct(product);
      
      // Listen for purchase results
      ref.listen<AsyncValue<void>>(productPurchaserProvider, (previous, next) {
        next.when(
          data: (_) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchase successful! Welcome to Premium!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          error: (error, _) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Purchase failed: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          loading: () {},
        );
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(subscriptionProductsProvider);
    final popularProduct = ref.watch(popularSubscriptionProvider);
    final initializationState = ref.watch(subscriptionInitializerProvider);
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Upgrade to Premium'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Maybe Later',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
      body: initializationState.when(
        data: (_) => _buildPaywallContent(products, popularProduct),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _buildErrorState(error),
      ),
    );
  }

  Widget _buildPaywallContent(List<models.SubscriptionProduct> products, models.SubscriptionProduct? popularProduct) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          _buildHeader(),
          const SizedBox(height: 32),
          
          // Feature comparison
          const FeatureComparisonWidget(),
          const SizedBox(height: 32),
          
          // Subscription options
          _buildSubscriptionOptions(products, popularProduct),
          const SizedBox(height: 32),
          
          // Purchase button
          _buildPurchaseButton(),
          const SizedBox(height: 16),
          
          // Restore purchases
          const RestorePurchasesButton(),
          const SizedBox(height: 16),
          
          // Terms and privacy
          _buildTermsAndPrivacy(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unlock Your Full Potential',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Get advanced HRV analytics, unlimited readings, and premium features to optimize your wellbeing.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionOptions(List<models.SubscriptionProduct> products, models.SubscriptionProduct? popularProduct) {
    if (products.isEmpty) {
      return const Center(
        child: Text('No subscription options available'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...products.map((product) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SubscriptionProductCard(
            product: product,
            isSelected: selectedProduct?.id == product.id,
            isPopular: product.id == popularProduct?.id,
            onTap: () {
              setState(() {
                selectedProduct = product;
              });
            },
          ),
        )),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    final isButtonEnabled = selectedProduct != null && !_isLoading;
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? () => _purchaseProduct(selectedProduct!) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                selectedProduct != null
                    ? 'Subscribe for ${selectedProduct!.price}'
                    : 'Select a Plan',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildTermsAndPrivacy() {
    return Column(
      children: [
        Text(
          'By subscribing, you agree to our Terms of Service and Privacy Policy. Subscriptions automatically renew unless cancelled at least 24 hours before the end of the current period.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // TODO: Open Terms of Service
              },
              child: const Text('Terms of Service'),
            ),
            const Text(' • '),
            TextButton(
              onPressed: () {
                // TODO: Open Privacy Policy
              },
              child: const Text('Privacy Policy'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load subscription options',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _initializeSubscriptions,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}