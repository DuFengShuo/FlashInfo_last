import 'package:flashinfo/brand/iview/brand_list_iview.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class BrandListPresenter extends BasePagePresenter<BrandListIMvpView> {
  int _page = 1;
  String keyword = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getBrandsList() {
    if (_page == 1) {
      view.searcBrandListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page.toString();
    params['keyword'] = keyword;
    params['per_page'] = 20;
    return requestNetwork<BrandListBean>(Method.post,
        url: HttpApi.searchBrands,
        params: params,
        isShow: false, onSuccess: (BrandListBean? bean) async {
      view.searcBrandListProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.company != null) {
        view.searcBrandListProvider.setHasMore(bean.company?.length == 20);
        if (_page == 1) {
          view.searcBrandListProvider.clear();
          if (bean.company!.isEmpty) {
            view.searcBrandListProvider.setStateType(StateType.company);
          } else {
            view.searcBrandListProvider.addAll(bean.company!);
          }
        } else {
          view.searcBrandListProvider.addAll(bean.company!);
        }
      } else {
        /// 加载失败
        view.searcBrandListProvider.setHasMore(false);
        view.searcBrandListProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.searcBrandListProvider.setHasMore(false);
      view.searcBrandListProvider.setStateType(StateType.company);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getBrandsList();
  }

  Future<void> loadMore() async {
    _page++;
    await getBrandsList();
  }
}
