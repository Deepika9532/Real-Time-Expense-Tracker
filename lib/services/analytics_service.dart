import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  FirebaseAnalytics? _analytics;

  FirebaseAnalytics get analytics {
    _analytics ??= FirebaseAnalytics.instance;
    return _analytics!;
  }

  AnalyticsService({FirebaseAnalytics? analytics}) {
    _analytics = analytics;
  }

  /// Log a custom event
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e) {
      // Silently handle analytics errors to avoid affecting app functionality
      print('Analytics error: $e');
    }
  }

  /// Log screen view
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await analytics.logEvent(
        name: 'screen_view',
        parameters: {
          'screen_name': screenName,
          if (screenClass != null) 'screen_class': screenClass,
        },
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Log user sign in event
  Future<void> logLogin({required String loginMethod}) async {
    try {
      await analytics.logLogin(loginMethod: loginMethod);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Log user sign up event
  Future<void> logSignUp({required String signUpMethod}) async {
    try {
      await analytics.logSignUp(signUpMethod: signUpMethod);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Log purchase event
  Future<void> logPurchase({
    required double value,
    required String currency,
    String? transactionId,
  }) async {
    try {
      await analytics.logPurchase(
        value: value,
        currency: currency,
        transactionId: transactionId,
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Log add to cart event
  Future<void> logAddToCart({
    required double value,
    required String currency,
    String? itemId,
    String? itemName,
    String? itemType,
  }) async {
    try {
      await analytics.logEvent(
        name: 'add_to_cart',
        parameters: {
          'currency': currency,
          'value': value,
          if (itemId != null) 'item_id': itemId,
          if (itemName != null) 'item_name': itemName,
          if (itemType != null) 'item_category': itemType,
        },
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Set user property
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Set user ID
  Future<void> setUserId({required String userId}) async {
    try {
      await analytics.setUserId(id: userId);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Set current screen name
  Future<void> setCurrentScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {
    try {
      await analytics.logEvent(
        name: 'screen_view',
        parameters: {
          'screen_name': screenName,
          if (screenClassOverride != null) 'screen_class': screenClassOverride,
        },
      );
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Enable/disable analytics collection
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    try {
      await analytics.setAnalyticsCollectionEnabled(enabled);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  /// Reset analytics data
  Future<void> resetAnalyticsData() async {
    try {
      await analytics.resetAnalyticsData();
    } catch (e) {
      print('Analytics error: $e');
    }
  }
}
