// ignore: import_of_legacy_library_into_null_safe
import 'package:data_finder/data_finder.dart';
import 'package:flashinfo/util/firedata_analytics.dart';

class AnalyticEventUtil {
  factory AnalyticEventUtil() => _instance;

  AnalyticEventUtil._internal();

  static final AnalyticEventUtil _instance = AnalyticEventUtil._internal();
  static final AnalyticEventUtil analyticsUtil = AnalyticEventUtil(); //事件实例

  Future<void> sendAnalyticsEvent(String eventName) async {
    FireBaseAnalyticUtil.analytics.logEvent(name: '$eventName', parameters: {
      'name': '$eventName',
    });

    DataFinder.onEventV3(
      eventName,
    );
  }
}
