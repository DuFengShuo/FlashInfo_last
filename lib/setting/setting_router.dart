import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/feedback_page.dart';
import 'page/setting_page.dart';

class SettingRouter implements IRouterProvider {
  static String settingPage = '/setting';
  static String feedbackPage = '/setting/feedback';

  @override
  void initRouter(FluroRouter router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, __) => const SettingPage()));
    router.define(feedbackPage,
        handler: Handler(handlerFunc: (_, __) => const FeedbackPage()));
  }
}
