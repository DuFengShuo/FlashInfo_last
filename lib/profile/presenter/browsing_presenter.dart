import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/profile/iview/browsing_iview.dart';
import 'package:flashinfo/profile/model/browsing_bean.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class BrowsingPresenter extends BasePagePresenter<BrowsingIMvpView> {
  int _page = 1;
  int indexType = 0;
  String type = 'all';
  late StateType stateType;
  @override
  void initState() {
    switch (indexType) {
      case 0:
        type = 'company';
        stateType = StateType.company;
        break;
      case 1:
        type = 'personnel';
        stateType = StateType.personnel;
        break;
      case 2:
        type = 'product';
        stateType = StateType.product;
        break;
      default:
        type = 'all';
        break;
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getHistoryRecord();
    });
  }

  ///获取标签列表
  Future getHistoryRecord() async {
    if (_page == 1) {
      view.browsingProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<BrowsingBean>(Method.get,
        url: HttpApi.historyRecord + type,
        queryParameters: params,
        isShow: false, onSuccess: (BrowsingBean? bean) async {
      if (bean != null && bean.list != null) {
        view.browsingProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.browsingProvider.clear();
          if (bean.list!.isEmpty) {
            view.browsingProvider.setStateType(stateType);
          } else {
            view.browsingProvider.addAll(bean.list!);
          }
        } else {
          view.browsingProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.browsingProvider.setHasMore(false);
        view.browsingProvider.setStateType(stateType);
      }
    }, onError: (_, __) {
      view.browsingProvider.setHasMore(false);
      view.browsingProvider.setStateType(StateType.network);
    });
  }

  //新闻下拉
  Future<void> onRefresh() async {
    _page = 1;
    await getHistoryRecord();
  }

  //新闻上拉
  Future loadMore() async {
    _page++;
    await getHistoryRecord();
  }
}
