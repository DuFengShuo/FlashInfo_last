import 'package:flashinfo/profile/presenter/personal_presenter.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/guide_employer_page.dart';
import 'page/guide_job_page.dart';
import 'page/guide_name_page.dart';
import 'page/guide_phone_page.dart';

class GuideRouter implements IRouterProvider {
  static String guideJobPage = '/guideJob';
  static String guideEmployerPage = '/guideEmployer';
  static String guideNamePage = '/guideName';
  static String guidePhonePage = '/guidePhone';

  @override
  void initRouter(FluroRouter router) {
    router.define(guideJobPage,
        handler: Handler(handlerFunc: (_, __) => const GuideJobPage()));

    router.define(guideEmployerPage,
        handler: Handler(handlerFunc: (context, params) {
      /// 类参数
      final args = context!.settings!.arguments! as PersonalParams;
      return GuideEmployerPage(
        personalParams: args,
      );
    }));
    router.define(guideNamePage,
        handler: Handler(handlerFunc: (context, params) {
      /// 类参数
      final args = context!.settings!.arguments! as PersonalParams;
      return GuideNamePage(
        personalParams: args,
      );
    }));
    router.define(guidePhonePage,
        handler: Handler(handlerFunc: (context, params) {
      /// 类参数
      final args = context!.settings!.arguments! as PersonalParams;
      return GuidePhonePage(
        personalParams: args,
      );
    }));
  }
}
