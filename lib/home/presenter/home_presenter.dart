import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_finder/data_finder.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePresenter extends BasePagePresenter<IMvpView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _sendAnalyticsEvent();
      getInit();
      hotWords();
      final String? accessToken = SpUtil.getString(Constant.accessToken);
      if (accessToken != null && accessToken.isNotEmpty) {
        getUserInfo();
      }
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    FireBaseAnalyticUtil.analytics.logEvent(name: 'home_look', parameters: {
      'name': 'home_look',
    }).then((value) {
      print('首页统计事件发送成功');
    });
    FireBaseAnalyticUtil.analytics.logLogin().then((value) {
      print('事件统计登录了');
    });

    DataFinder.onEventV3(
      'home_look',
    );
  }

  // 获取配置信息
  Future getInit() async {
    String url = '';
    switch (Constant.baseUrl) {
      case Constant.debugUrl:
      case Constant.testUrl:
        url = 'init_v2_debug.json';
        break;
      case Constant.mastOnLineUrl:
      case Constant.onLineUrl:
        url = 'init_v2.json';
        break;
      default:
    }
    return requestNetwork<InitializeModel>(Method.get, url: url, isShow: false,
        onSuccess: (InitializeModel? model) async {
      if (model != null) {
        view.getContext().read<CommonProvider>().setInitializeModel(model);
      }
    });
  }

  // 获取用户信息
  Future getUserInfo() async {
    return requestNetwork<UserInfoModel>(Method.get,
        url: HttpApi.userInfo,
        isShow: false, onSuccess: (UserInfoModel? model) {
      if (model != null) {
        view.getContext().read<UserInfoProvider>().setUserInfoModel(model);
      }
    });
  }

  // 获取热词
  Future hotWords() async {
    return requestNetwork<HotWordsModel>(Method.get,
        url: HttpApi.hotWords,
        isShow: false, onSuccess: (HotWordsModel? model) {
      if (model != null) {
        view.getContext().read<CommonProvider>().setHotWordsModel(model);
      }
    });
  }
}
