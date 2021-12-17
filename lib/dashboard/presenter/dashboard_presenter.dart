import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/dashboard/iview/dashboard_iview.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/dashboard/models/recommend_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPagePresenter extends BasePagePresenter<DashboardIMvpView> {
  int _newsPage = 1;
  int _recommendPage = 1;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _sendAnalyticsEvent();
      getNewsList();
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    FireBaseAnalyticUtil.analytics.logEvent(name: 'home_news', parameters: {
      'name': 'home_news',
    }).then((value) {
      print('首页新闻页面');
    });

    // DataFinder.onEventV3("news_show", params: {
    //   "params1": "value1",
    // });
  }

  ///获取新闻列表
  Future getNewsList() async {
    if (_newsPage == 1) {
      view.newsListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _newsPage;
    return requestNetwork<NewsBean>(Method.get,
        url: HttpApi.news,
        queryParameters: params,
        isShow: false, onSuccess: (NewsBean? bean) async {
      if (bean != null && bean.news != null) {
        view.newsListProvider.setHasMore(bean.news?.length == 20);
        if (_newsPage == 1) {
          view.newsListProvider.clear();
          if (bean.news!.isEmpty) {
            view.newsListProvider.setStateType(StateType.company);
          } else {
            view.newsListProvider.addAll(bean.news!);
          }
        } else {
          view.newsListProvider.addAll(bean.news!);
        }
      } else {
        /// 加载失败
        view.newsListProvider.setHasMore(false);
        view.newsListProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.newsListProvider.setHasMore(false);
      view.newsListProvider.setStateType(StateType.network);
    });
  }

  //新闻下拉刷新
  Future<void> onRefreshNews() async {
    _newsPage = 1;
    await getNewsList();
  }

  //新闻上拉加载
  Future loadMoreNews() async {
    _newsPage++;
    await getNewsList();
  }

  ///获取推荐公司列表
  Future getRecommendList() async {
    final BaseListProvider<BrandItemModel>? recompanyListProvider =
        view.getContext().read<CommonProvider>().recompanyListProvider;
    if (_recommendPage == 1) {
      recompanyListProvider!.setStateType(StateType.listLayout);
    }
    view
        .getContext()
        .read<CommonProvider>()
        .setRecompanyListProvider(recompanyListProvider);
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _recommendPage;
    return requestNetwork<RecommendBean>(Method.get,
        url: HttpApi.recommends,
        queryParameters: params,
        isShow: false, onSuccess: (RecommendBean? bean) async {
      if (bean != null && bean.brandList != null) {
        recompanyListProvider!.setHasMore(bean.brandList?.length == 20);
        if (_recommendPage == 1) {
          recompanyListProvider.clear();
          if (bean.brandList!.isEmpty) {
            recompanyListProvider.setStateType(StateType.company);
          } else {
            recompanyListProvider.addAll(bean.brandList!);
          }
        } else {
          recompanyListProvider.addAll(bean.brandList!);
        }
      } else {
        /// 加载失败
        recompanyListProvider!.setHasMore(false);
        recompanyListProvider.setStateType(StateType.company);
      }
      view
          .getContext()
          .read<CommonProvider>()
          .setRecompanyListProvider(recompanyListProvider);
    }, onError: (_, __) {
      recompanyListProvider!.setHasMore(false);
      recompanyListProvider.setStateType(StateType.network);
      view
          .getContext()
          .read<CommonProvider>()
          .setRecompanyListProvider(recompanyListProvider);
    });
  }

  //新闻下拉刷新
  Future<void> onRefreshCompany() async {
    _recommendPage = 1;
    await getRecommendList();
  }

  //新闻上拉加载
  Future loadMoreCompany() async {
    _recommendPage++;
    await getRecommendList();
  }
}

class NewsPagePresenter extends BasePagePresenter<NewsIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }
}
