// ignore: import_of_legacy_library_into_null_safe
import 'package:data_finder/data_finder.dart';
import 'package:flashinfo/brand/iview/brand_detail_iview.dart';
import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class BrandDetailPresenter extends BasePagePresenter<BrandDetailIMvpView> {
  String companyId = '';
  int contact_limit = 0; //0公司所有人员 1公司关键联系人

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        //Company_PageView
        sendAnalyticsEvent('Company_PageView'); //事件统计
      },
    );
  }

  Future<void> sendAnalyticsEvent(String eventName) async {
    FireBaseAnalyticUtil.analytics.logEvent(name: '$eventName', parameters: {
      'name': '$eventName',
    }).then((value) {
      // print('首页统计事件发送成功');
    });
    FireBaseAnalyticUtil.analytics.logLogin().then((value) {
      // print('事件统计登录了');
    });

    DataFinder.onEventV3(
      '$eventName',
    );
  }

  //获取品牌详情
  Future getBrandDetail(String brandId) {
    return requestNetwork<BrandBean>(Method.get,
        url: HttpApi.brandDetail + '/$brandId',
        isShow: false, onSuccess: (BrandBean? model) {
      if (model != null) {
        view.brandProvider.setBrandBean(model);
      } else {
        view.brandProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.brandProvider.setStateType(StateType.company);
    });
  }
}

class BrandEventsPresenter extends BasePagePresenter<BrandEventIMvpView> {
  int _page = 1;
  String brandId = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  // 请求公司产品
  Future getBrandEventList() {
    if (_page == 1) {
      view.brandEventProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<Events>(Method.post,
        url: HttpApi.brandEvents + brandId,
        queryParameters: params,
        isShow: false, onSuccess: (Events? bean) {
      if (bean != null && bean.eventList != null) {
        view.brandEventProvider.setHasMore(bean.eventList?.length == 20);
        if (_page == 1) {
          view.brandEventProvider.clear();
          if (bean.eventList!.isEmpty) {
            view.brandEventProvider.setStateType(StateType.personnel);
          } else {
            view.brandEventProvider.addAll(bean.eventList!);
          }
        } else {
          view.brandEventProvider.addAll(bean.eventList!);
        }
      } else {
        /// 加载失败
        view.brandEventProvider.setHasMore(false);
        view.brandEventProvider.setStateType(StateType.personnel);
      }
    }, onError: (_, __) {
      view.brandEventProvider.setHasMore(false);
      view.brandEventProvider.setStateType(StateType.personnel);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getBrandEventList();
  }

  Future loadMore() async {
    _page++;
    await getBrandEventList();
  }
}
