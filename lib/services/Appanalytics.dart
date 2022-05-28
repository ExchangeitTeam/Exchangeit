import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static Future<void> setLogEvent(
      {required String eventName, Map<String, dynamic>? params}) async {
    await analytics.logEvent(
      name: eventName,
      parameters: params,
    );
  }

  static Future<void> setCurrentScreen({required String screenName}) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<void> setUserId({required String userId}) async {
    await analytics.setUserId(id: userId);
  }
}
