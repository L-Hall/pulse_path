import 'package:flutter_test/flutter_test.dart';
import 'package:pulse_path/features/subscription/domain/models/subscription_product.dart';

void main() {
  group('Subscription Models', () {
    group('SubscriptionProduct', () {
      test('should create monthly subscription with correct configuration', () {
        final monthlyProduct = SubscriptionProduct(
          id: 'pulse_path_monthly',
          title: 'PulsePath Monthly Premium',
          description: 'Unlimited HRV readings with advanced analytics',
          price: '£5.99',
          currencyCode: 'GBP',
          rawPrice: 5.99,
          type: SubscriptionType.monthly,
          duration: SubscriptionDuration.month,
          features: [
            'Unlimited HRV Readings',
            'Advanced Analytics',
            'Cloud Sync',
            'Premium Support',
          ],
          isActive: false,
          isPopular: false,
        );

        expect(monthlyProduct.id, 'pulse_path_monthly');
        expect(monthlyProduct.type, SubscriptionType.monthly);
        expect(monthlyProduct.rawPrice, 5.99);
        expect(monthlyProduct.features.length, 4);
        expect(monthlyProduct.isPopular, false);
      });

      test('should create annual subscription marked as popular', () {
        final annualProduct = SubscriptionProduct(
          id: 'pulse_path_annual',
          title: 'PulsePath Annual Premium',
          description: 'Save 45% with yearly billing',
          price: '£39.99',
          currencyCode: 'GBP',
          rawPrice: 39.99,
          type: SubscriptionType.annual,
          duration: SubscriptionDuration.year,
          features: [
            'Unlimited HRV Readings',
            'Advanced Analytics',
            'Cloud Sync',
            'Premium Support',
            'Data Export',
            'Adaptive Pacing',
          ],
          isActive: false,
          isPopular: true,
        );

        expect(annualProduct.id, 'pulse_path_annual');
        expect(annualProduct.isPopular, true);
        expect(annualProduct.rawPrice, 39.99);
        expect(annualProduct.features.length, 6);
      });

      test('should calculate correct savings for annual vs monthly', () {
        const monthlyPrice = 5.99;
        const annualPrice = 39.99;
        
        final monthlyCost = monthlyPrice * 12; // £71.88
        final annualSavings = monthlyCost - annualPrice; // £31.89
        final savingsPercentage = (annualSavings / monthlyCost) * 100; // ~44.4%
        
        expect(savingsPercentage.round(), 44); // Close to 45% as advertised
        expect(annualSavings > 30, true); // Significant savings
      });

      test('should create lifetime subscription with permanent access', () {
        final lifetimeProduct = SubscriptionProduct(
          id: 'pulse_path_lifetime',
          title: 'PulsePath Lifetime Access',
          description: 'One-time payment for permanent access',
          price: '£99.00',
          currencyCode: 'GBP',
          rawPrice: 99.0,
          type: SubscriptionType.lifetime,
          duration: SubscriptionDuration.lifetime,
          features: [
            'All Premium Features',
            'Lifetime Access',
            'Future Features',
            'Priority Support',
          ],
          isActive: false,
          isPopular: false,
        );

        expect(lifetimeProduct.id, 'pulse_path_lifetime');
        expect(lifetimeProduct.type, SubscriptionType.lifetime);
        expect(lifetimeProduct.duration, SubscriptionDuration.lifetime);
        expect(lifetimeProduct.rawPrice, 99.0);
      });

      test('should serialize to and from JSON correctly', () {
        final originalProduct = SubscriptionProduct(
          id: 'test_product',
          title: 'Test Product',
          description: 'Test Description',
          price: '£9.99',
          currencyCode: 'GBP',
          rawPrice: 9.99,
          type: SubscriptionType.monthly,
          duration: SubscriptionDuration.month,
          features: ['Feature 1', 'Feature 2'],
          isActive: false,
          isPopular: true,
        );

        // Convert to JSON and back
        final json = originalProduct.toJson();
        final deserializedProduct = SubscriptionProduct.fromJson(json);

        expect(deserializedProduct.id, originalProduct.id);
        expect(deserializedProduct.title, originalProduct.title);
        expect(deserializedProduct.price, originalProduct.price);
        expect(deserializedProduct.type, originalProduct.type);
        expect(deserializedProduct.duration, originalProduct.duration);
        expect(deserializedProduct.features, originalProduct.features);
        expect(deserializedProduct.isPopular, originalProduct.isPopular);
        expect(deserializedProduct.rawPrice, originalProduct.rawPrice);
      });
    });

    group('SubscriptionStatus', () {
      test('should create active subscription status', () {
        final activeStatus = SubscriptionStatus(
          isActive: true,
          currentType: SubscriptionType.annual,
          expiryDate: DateTime(2024, 12, 31),
          purchaseDate: DateTime(2024, 1, 1),
          transactionId: 'test_transaction_123',
          isInTrialPeriod: false,
          autoRenewEnabled: true,
        );

        expect(activeStatus.isActive, true);
        expect(activeStatus.currentType, SubscriptionType.annual);
        expect(activeStatus.transactionId, 'test_transaction_123');
        expect(activeStatus.autoRenewEnabled, true);
      });

      test('should create free tier status', () {
        const freeStatus = SubscriptionStatus(
          isActive: false,
          currentType: SubscriptionType.free,
        );

        expect(freeStatus.isActive, false);
        expect(freeStatus.currentType, SubscriptionType.free);
        expect(freeStatus.expiryDate, null);
        expect(freeStatus.transactionId, null);
      });

      test('should handle trial period correctly', () {
        final trialStatus = SubscriptionStatus(
          isActive: true,
          currentType: SubscriptionType.annual,
          expiryDate: DateTime(2024, 12, 31),
          purchaseDate: DateTime(2024, 1, 1),
          isInTrialPeriod: true,
          autoRenewEnabled: true,
        );

        expect(trialStatus.isActive, true);
        expect(trialStatus.isInTrialPeriod, true);
        expect(trialStatus.autoRenewEnabled, true);
      });

      test('should serialize to and from JSON correctly', () {
        final originalStatus = SubscriptionStatus(
          isActive: true,
          currentType: SubscriptionType.annual,
          expiryDate: DateTime(2024, 12, 31),
          purchaseDate: DateTime(2024, 1, 1),
          transactionId: 'test_transaction_123',
          isInTrialPeriod: false,
          autoRenewEnabled: true,
        );

        // Convert to JSON and back
        final json = originalStatus.toJson();
        final deserializedStatus = SubscriptionStatus.fromJson(json);

        expect(deserializedStatus.isActive, originalStatus.isActive);
        expect(deserializedStatus.currentType, originalStatus.currentType);
        expect(deserializedStatus.expiryDate, originalStatus.expiryDate);
        expect(deserializedStatus.purchaseDate, originalStatus.purchaseDate);
        expect(deserializedStatus.transactionId, originalStatus.transactionId);
        expect(deserializedStatus.autoRenewEnabled, originalStatus.autoRenewEnabled);
      });
    });

    group('FeatureAccess', () {
      test('should create free tier feature access', () {
        const freeAccess = FeatureAccess(
          advancedAnalytics: false,
          dataExport: false,
          cloudSync: false,
          premiumSupport: false,
          adaptivePacing: true, // Available in free tier
          unlimitedReadings: false,
          customMetrics: false,
          trendPredictions: false,
        );

        expect(freeAccess.advancedAnalytics, false);
        expect(freeAccess.dataExport, false);
        expect(freeAccess.cloudSync, false);
        expect(freeAccess.unlimitedReadings, false);
        expect(freeAccess.adaptivePacing, true); // Basic adaptive pacing free
      });

      test('should create premium feature access', () {
        const premiumAccess = FeatureAccess(
          advancedAnalytics: true,
          dataExport: true,
          cloudSync: true,
          premiumSupport: true,
          adaptivePacing: true,
          unlimitedReadings: true,
          customMetrics: true,
          trendPredictions: true,
        );

        expect(premiumAccess.advancedAnalytics, true);
        expect(premiumAccess.dataExport, true);
        expect(premiumAccess.cloudSync, true);
        expect(premiumAccess.premiumSupport, true);
        expect(premiumAccess.unlimitedReadings, true);
        expect(premiumAccess.customMetrics, true);
        expect(premiumAccess.trendPredictions, true);
      });

      test('should serialize to and from JSON correctly', () {
        const originalAccess = FeatureAccess(
          advancedAnalytics: true,
          dataExport: false,
          cloudSync: true,
          premiumSupport: false,
          adaptivePacing: true,
          unlimitedReadings: true,
          customMetrics: false,
          trendPredictions: true,
        );

        // Convert to JSON and back
        final json = originalAccess.toJson();
        final deserializedAccess = FeatureAccess.fromJson(json);

        expect(deserializedAccess.advancedAnalytics, originalAccess.advancedAnalytics);
        expect(deserializedAccess.dataExport, originalAccess.dataExport);
        expect(deserializedAccess.cloudSync, originalAccess.cloudSync);
        expect(deserializedAccess.premiumSupport, originalAccess.premiumSupport);
        expect(deserializedAccess.adaptivePacing, originalAccess.adaptivePacing);
        expect(deserializedAccess.unlimitedReadings, originalAccess.unlimitedReadings);
        expect(deserializedAccess.customMetrics, originalAccess.customMetrics);
        expect(deserializedAccess.trendPredictions, originalAccess.trendPredictions);
      });
    });

    group('Enums', () {
      test('should handle SubscriptionType enum values', () {
        expect(SubscriptionType.values.length, 4);
        expect(SubscriptionType.values, contains(SubscriptionType.monthly));
        expect(SubscriptionType.values, contains(SubscriptionType.annual));
        expect(SubscriptionType.values, contains(SubscriptionType.lifetime));
        expect(SubscriptionType.values, contains(SubscriptionType.free));
      });

      test('should handle SubscriptionDuration enum values', () {
        expect(SubscriptionDuration.values.length, 4);
        expect(SubscriptionDuration.values, contains(SubscriptionDuration.month));
        expect(SubscriptionDuration.values, contains(SubscriptionDuration.year));
        expect(SubscriptionDuration.values, contains(SubscriptionDuration.lifetime));
        expect(SubscriptionDuration.values, contains(SubscriptionDuration.free));
      });
    });
  });
}