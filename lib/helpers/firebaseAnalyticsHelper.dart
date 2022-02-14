import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsHelper {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static logAppOpen() async {
    await analytics.logAppOpen();
  }

  static logNewsMarqueeOpen({
    required String slug,
    required String title,
  }) async {
    await analytics.logEvent(name: 'news_marquee_open', parameters: {
      'slug': slug,
      'title': title
    });
  }
}