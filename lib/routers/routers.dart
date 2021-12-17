import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/favourites/favourites_router.dart';
import 'package:flashinfo/guide/guide_router.dart';
import 'package:flashinfo/home/home_page.dart';
import 'package:flashinfo/home/webview_page.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/search/search_router.dart';
import 'package:flashinfo/setting/setting_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/routers/not_found_page.dart';
import 'package:flashinfo/routers/i_router.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return const NotFoundPage();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    const Home()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first ?? '';
      final String url = params['url']?.first ?? '';
      return WebViewPage(title: title, url: url);
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(GuideRouter());
    _listRouter.add(ProfileRouter());
    _listRouter.add(SettingRouter());
    _listRouter.add(SearchRouter());
    _listRouter.add(FavouritesRouter());
    _listRouter.add(CompanyRouder());
    _listRouter.add(PayRouter());
    _listRouter.add(PersonalRouter());
    _listRouter.add(ProductRouter());
    _listRouter.add(BrandRouder());
    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
