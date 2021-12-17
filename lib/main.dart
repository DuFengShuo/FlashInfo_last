import 'package:dio/dio.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/home/splash_page.dart';
import 'package:flashinfo/net/dio_utils.dart';
import 'package:flashinfo/net/intercept.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/routers/not_found_page.dart';
import 'package:flashinfo/routers/routers.dart';
import 'package:flashinfo/setting/provider/locale_provider.dart';
import 'package:flashinfo/setting/provider/theme_provider.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/handle_error_utils.dart';
import 'package:flashinfo/util/log_utils.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:sp_util/sp_util.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'provider/common_provider.dart';
import 'provider/group_provider.dart';

Future<void> main() async {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;

  /// 确保初始化完成
  WidgetsFlutterBinding.ensureInitialized();
  if (Device.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  /// 去除URL中的“#”(hash)，仅针对Web。默认为setHashUrlStrategy
  /// 注意本地部署和远程部署时`web/index.html`中的base标签，https://github.com/flutter/flutter/issues/69760
  setPathUrlStrategy();

  /// sp初始化
  await SpUtil.getInstance();

  /// 1.22 预览功能: 在输入频率与显示刷新率不匹配情况下提供平滑的滚动效果
  // GestureBinding.instance?.resamplingEnabled = true;
  /// 异常处理
  handleError(runApp(MyApp()));

  /// 隐藏状态栏。为启动页、引导页设置。完成后修改回显示状态栏。
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  // TODO(weilu): 启动体验不佳。状态栏、导航栏在冷启动开始的一瞬间为黑色，且无法通过隐藏、修改颜色等方式进行处理。。。
  // 相关问题跟踪：https://github.com/flutter/flutter/issues/73351
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.home, this.theme}) : super(key: key) {
    Log.init();
    initDio();
    Routes.initRoutes();
  }

  final Widget? home;
  final ThemeData? theme;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  void initDio() {
    final List<Interceptor> interceptors = <Interceptor>[];

    /// 统一添加身份验证请求头
    interceptors.add(AuthInterceptor());

    /// 刷新Token
    interceptors.add(TokenInterceptor());

    /// 打印Log(生产模式去除)
    if (!Constant.inProduction) {
      interceptors.add(LoggingInterceptor());
    }

    /// 适配数据(根据自己的数据结构，可自行选择添加)
    interceptors.add(AdapterInterceptor());
    configDio(
      baseUrl: Constant.baseUrl,
      interceptors: interceptors,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget app = MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => UserInfoProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
      ],
      child: Consumer5<ThemeProvider, LocaleProvider, UserInfoProvider,
          GroupProvider, CommonProvider>(
        builder: (_,
            ThemeProvider provider,
            LocaleProvider localeProvider,
            UserInfoProvider userInfoProvider,
            GroupProvider groupProvider,
            CommonProvider commonProvider,
            __) {
          return _buildMaterialApp(provider, localeProvider);
        },
      ),
    );

    /// Toast 配置
    return OKToast(
        child: app,
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }

  Widget _buildMaterialApp(
      ThemeProvider provider, LocaleProvider localeProvider) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // allowFontScaling: false,
      builder: () => MaterialApp(
        title: 'FlashInfo',
        // showPerformanceOverlay: true, //显示性能标签
        // debugShowCheckedModeBanner: false, // 去除右上角debug的标签
        // checkerboardRasterCacheImages: true,
        // showSemanticsDebugger: true, // 显示语义视图
        // checkerboardOffscreenLayers: true, // 检查离屏渲染
        theme: theme ?? provider.getTheme(),
        darkTheme: provider.getTheme(isDarkMode: true),
        themeMode: provider.getThemeMode(),
        home: home ?? const SplashPage(),
        onGenerateRoute: Routes.router.generator,
        locale: localeProvider.locale,
        navigatorKey: navigatorKey,
        builder: (BuildContext context, Widget? child) {
          /// 仅针对安卓
          if (Device.isAndroid) {
            /// 切换深色模式会触发此方法，这里设置导航栏颜色
            ThemeUtils.setSystemNavigationBar(provider.getThemeMode());
          }

          /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },

        /// 因为使用了fluro，这里设置主要针对Web
        onUnknownRoute: (_) {
          return MaterialPageRoute<void>(
            builder: (BuildContext context) => const NotFoundPage(),
          );
        },
        restorationScopeId: 'app',
      ),
    );
  }
}
