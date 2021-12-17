import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
// //统计类封装

class FireBaseAnalyticUtil {
  factory FireBaseAnalyticUtil() => _instance;
  FireBaseAnalyticUtil._internal();
  static final FireBaseAnalyticUtil _instance = FireBaseAnalyticUtil._internal();
  static final FirebaseAnalytics  analytics = FirebaseAnalytics(); //事件实例
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);  //路由

}
