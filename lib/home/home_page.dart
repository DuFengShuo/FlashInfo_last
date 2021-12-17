import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/dashboard/page/dashboard_page.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/profile/page/profile_page.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/home/provider/home_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/theme_utils.dart';
import 'package:flashinfo/widgets/double_tap_back_exit_app.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'presenter/home_presenter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with RestorationMixin, BasePageMixin<Home, PowerPresenter> {
  static const double _imageSize = 25.0;
  static const double _bottomSize = 6.0;

  late List<Widget> _pageList;
  final List<String> _appBarTitles = ['Dashboard', 'Profile'];
  final PageController _pageController = PageController();
  late StreamSubscription<ConnectivityResult> _resultSubject;
  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem>? _list;
  late HomePresenter _homePresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _homePresenter = HomePresenter();
    powerPresenter.requestPresenter([_homePresenter]);
    return powerPresenter;
  }

  late AppsflyerSdk _appsflyerSdk;
  @override
  void initState() {
    super.initState();
    if (Constant.baseUrl == Constant.onLineUrl) {
      final AppsFlyerOptions options = AppsFlyerOptions(
          afDevKey: Device.isIOS
              ? 'ginbRpL65eyphs4BDymppE'
              : 'fxsf9SZHTq96uj2VbyHQW8',
          appId: Device.isIOS ? '1576818769' : 'com.kuliang.android.flashInfo',
          showDebug: true,
          timeToWaitForATTUserAuthorization: 30);

      _appsflyerSdk = AppsflyerSdk(options);
      _appsflyerSdk.initSdk(
          registerConversionDataCallback: true,
          registerOnAppOpenAttributionCallback: true,
          registerOnDeepLinkingCallback: true);
      _appsflyerSdk.onAppOpenAttribution((dynamic res) {
        print('onAppOpenAttribution res: ' + res.toString());
      });
      _appsflyerSdk.onInstallConversionData((dynamic res) {
        print('onInstallConversionData res:' + res.toString());
      });
      _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
        switch (dp.status) {
          case Status.FOUND:
            print(dp.deepLink?.toString());
            print('deep link value: ${dp.deepLink?.deepLinkValue}');
            break;
          case Status.NOT_FOUND:
            print('deep link not found');
            break;
          case Status.ERROR:
            print('deep link error: ${dp.error}');
            break;
          case Status.PARSE_ERROR:
            print('deep link status parsing error');
            break;
        }
        print('onDeepLinking res: ' + dp.toString());
      });
    }

    initData();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      /// 显示状态栏和导航栏
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

      _resultSubject = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        // Got a new connectivity status!
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          // I am connected to a mobile network.
          if (SpUtil.getBool(Constant.isLogin, defValue: false) ?? false) {
            await _homePresenter.getUserInfo();
          }

          print('当前处于移动网络');
        } else {
          print('网络无连接');
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _resultSubject.cancel();
    super.dispose();
  }

  void initData() {
    _pageList = [
      const DashboardPage(),
      const ProfilePage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const _tabImages = [
        [
          IconFont(
              name: 0xe615,
              size: _imageSize,
              bottomSize: _bottomSize,
              color: Colours.unselected_item_color),
          IconFont(
              name: 0xe615,
              size: _imageSize,
              bottomSize: _bottomSize,
              color: Colours.app_main)
        ],
        [
          IconFont(
              name: 0xe60e,
              size: _imageSize,
              bottomSize: _bottomSize,
              color: Colours.unselected_item_color),
          IconFont(
              name: 0xe60e,
              size: _imageSize,
              bottomSize: _bottomSize,
              color: Colours.app_main)
        ],
      ];
      _list = List.generate(_tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }
    return _list!;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
            bottomNavigationBar: Consumer<HomeProvider>(
              builder: (_, provider, __) {
                return BottomNavigationBar(
                  backgroundColor: context.backgroundColor,
                  items: _buildBottomNavigationBarItem(),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: provider.value,
                  elevation: 5.0,
                  iconSize: 16.0,
                  selectedFontSize: Dimens.font_sp10,
                  unselectedFontSize: Dimens.font_sp10,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: isDark
                      ? Colours.dark_unselected_item_color
                      : Colours.unselected_item_color,
                  onTap: (index) => _pageController.jumpToPage(index),
                );
              },
            ),
            // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
            body: PageView(
              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
              controller: _pageController,
              onPageChanged: (int index) => provider.value = index,
              children: _pageList,
            )),
      ),
    );
  }

  @override
  String? get restorationId => 'home';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(provider, 'BottomNavigationBarCurrentIndex');
  }
}
