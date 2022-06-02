import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> setLogEventUtil(
    {required String eventName, Map<String, dynamic>? params}) async {
  await FirebaseAnalytics.instance.logEvent(
    name: eventName,
    parameters: params,
  );
}

Future<void> setCurrentScreenUtil({required String screenName}) async {
  await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
}
