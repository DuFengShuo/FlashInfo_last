import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/favourites/page/group_list_page.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectsPresenter extends BasePagePresenter<CollectsIMvpView> {
  int indexType = 0;
  String type = 'company';
  @override
  void initState() {
    switch (indexType) {
      case 0:
        type = 'company';
        break;
      case 1:
        type = 'brand';
        break;
      case 2:
        type = 'product';
        break;
      case 3:
        type = 'personnel';
        break;
      default:
    }
  }

  ///添加收藏
  Future addCollects(String tagId, String? relatedId,
      Function(StatusModel)? collectSuccessful) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['tag_id'] = tagId;
    params['type'] = type;
    params['related_id'] = relatedId;
    return requestNetwork<StatusModel>(Method.post,
        url: HttpApi.collect,
        params: params,
        isShow: true, onSuccess: (StatusModel? bean) async {
      if (bean != null) {
        if (bean.message!.isNotEmpty) {
          Toast.show(bean.message!);
        }
        if (bean.status == 0) {
          view
              .getContext()
              .read<UserInfoProvider>()
              .updateUserFavoriteCount(bean.favoriteCount);
          collectSuccessful!(bean);
        }
      }
    }, onError: (_, __) {});
  }

  ///取消收藏
  Future cancelCollects(
      String? relatedId, Function(StatusModel)? collectCancel) async {
    return requestNetwork<StatusModel>(Method.delete,
        url: HttpApi.collect + (relatedId ?? ''),
        isShow: true, onSuccess: (StatusModel? bean) async {
      if (bean != null) {
        if (bean.message!.isNotEmpty) {
          Toast.show(bean.message!);
        }
        if (bean.status == 0) {
          view
              .getContext()
              .read<UserInfoProvider>()
              .updateUserFavoriteCount(bean.favoriteCount);
          collectCancel!(bean);
        }
      }
    }, onError: (_, __) {});
  }

  ///取消收藏
  Future cancelCollectAll(
      String? relatedId, Function(StatusModel)? collectCancel) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['related_id'] = relatedId;
    return requestNetwork<StatusModel>(Method.post,
        url: HttpApi.cancelCollect + type,
        params: params,
        isShow: true, onSuccess: (StatusModel? bean) async {
      if (bean != null) {
        if (bean.message!.isNotEmpty) {
          Toast.show(bean.message!);
        }
        if (bean.status == 0) {
          view
              .getContext()
              .read<UserInfoProvider>()
              .updateUserFavoriteCount(bean.favoriteCount);
          collectCancel!(bean);
        }
      }
    }, onError: (_, __) {});
  }
}

class CollectsListPresenter extends BasePagePresenter<CollectsListIMvpView> {
  int _page = 1;
  int indexType = 0;
  StateType _stateType = StateType.company;
  String type = 'company';
  @override
  void initState() {
    switch (indexType) {
      case 0:
        type = 'company';
        _stateType = StateType.company;
        break;
      case 1:
        type = 'brand';
        _stateType = StateType.personnel;
        break;
      case 2:
        type = 'product';
        _stateType = StateType.product;
        break;
      case 3:
        type = 'personnel';
        _stateType = StateType.personnel;
        break;
      default:
    }
    switch (indexType) {
      case 0:
        view.companyTagListProvider.setStateTypeNotNotify(_stateType);
        break;
      case 1:
        view.brandTagListProvider.setStateTypeNotNotify(_stateType);
        break;
      case 2:
        view.productTagListProvider.setStateTypeNotNotify(_stateType);
        break;
      case 3:
        view.peopleTagListProvider.setStateTypeNotNotify(_stateType);
        break;
      default:
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // getTags();
    });
  }

  //导出收藏
  Future<void> sendAnalyticsEvent() async {
    await FireBaseAnalyticUtil.analytics
        .logEvent(name: 'export_favorite', parameters: {
      'add_group': 'value',
    }).then((value) {
      print('导出收藏');
    });
    // DataFinder.onEventV3("add_group", params: {
    //   "add_group": "value",
    // });
  }

  //下拉
  Future<void> onRefresh(GroupListParam? groupListParam) async {
    _page = 1;
    switch (indexType) {
      case 0:
        view.companyTagListProvider.setStateType(StateType.listLayout);
        break;
      case 1:
        view.brandTagListProvider.setStateType(StateType.listLayout);
        break;
      case 2:
        view.productTagListProvider.setStateType(StateType.listLayout);
        break;
      case 3:
        view.peopleTagListProvider.setStateType(StateType.listLayout);
        break;
      default:
    }
    await collectsList(groupListParam);
  }

  //上拉
  Future loadMore(GroupListParam? groupListParam) async {
    _page++;
    await collectsList(groupListParam);
  }

  ///收藏列表
  Future collectsList(GroupListParam? groupListParam) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    params['type'] = type;
    params['tag_id'] = groupListParam?.tagsModel?.id;
    if (_page == 1) {
      view.collectsListProvider.setStateType(StateType.listLayout);
    }
    return requestNetwork<CollectsListBeam>(Method.get,
        url: HttpApi.collect,
        queryParameters: params,
        isShow: true, onSuccess: (CollectsListBeam? bean) async {
      if (bean != null) {
        if (bean.message != null && bean.message!.isNotEmpty) {
          view.showToast(bean.message!);
        }
        switch (indexType) {
          case 0:
            companyTagList(bean.companyList, bean.meta);
            break;
          case 1:
            brandTagList(bean.brandList, bean.meta);
            break;
          case 2:
            productTagList(bean.productList, bean.meta);
            break;
          case 3:
            peopleTagList(bean.personnelList, bean.meta);
            break;
          default:
        }
      }
    }, onError: (_, __) {});
  }

  ///编辑标签
  Future changeTagName(String name, String id, int index,
      Function(TagsModel?) changeSuccess) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['name'] = name;
    return requestNetwork<TagsModel>(Method.patch,
        url: HttpApi.tags + '$id',
        params: params,
        isShow: true, onSuccess: (TagsModel? bean) async {
      if (bean != null) {
        changeSuccess(bean);
        // view
        //     .getContext()
        //     .read<UserInfoProvider>()
        //     .updateUserFavoriteCount(bean.favoriteCount);
      }
    }, onError: (_, __) {});
  }

  ///删除标签
  Future deleteCollects(String id, int index, MetaModel metaModel) async {
    return requestNetwork<StatusModel>(Method.delete,
        url: HttpApi.collect + '$id',
        isShow: true, onSuccess: (StatusModel? bean) async {
      if (bean != null) {
        if (bean.message != null && bean.message!.isNotEmpty) {
          view.showToast(bean.message!);
        }
        if (metaModel.pagination!.total != 0) {
          metaModel.pagination!.total = (metaModel.pagination?.total ?? 1) - 1;
        }
        switch (indexType) {
          case 0:
            view.companyTagListProvider.setMetaModel(metaModel);
            view.companyTagListProvider.removeAt(index);
            break;
          case 1:
            view.brandTagListProvider.setMetaModel(metaModel);
            view.brandTagListProvider.removeAt(index);
            break;
          case 2:
            view.productTagListProvider.setMetaModel(metaModel);
            view.productTagListProvider.removeAt(index);
            break;
          case 3:
            view.peopleTagListProvider.setMetaModel(metaModel);
            view.peopleTagListProvider.removeAt(index);
            break;
          default:
        }
        view
            .getContext()
            .read<UserInfoProvider>()
            .updateUserFavoriteCount(bean.favoriteCount);
      }
      initState();
    }, onError: (_, __) {
      initState();
    });
  }

  void companyTagList(List<CompanyTagModel>? list, MetaModel? metaModel) {
    view.companyTagListProvider.setMetaModel(metaModel);

    if (list == null || list.isEmpty) {
      if (_page == 1) {
        view.companyTagListProvider.clear();
      }
      view.companyTagListProvider.setStateTypeNotNotify(_stateType);
      view.companyTagListProvider.setHasMore(false);
    } else {
      view.companyTagListProvider.setHasMore(list.length == 10);
      if (_page == 1) {
        view.companyTagListProvider.clear();
        view.companyTagListProvider.addAll(list);
      } else {
        view.companyTagListProvider.addAll(list);
      }
    }
  }

  void peopleTagList(List<PersonnelTagModel>? list, MetaModel? metaModel) {
    view.peopleTagListProvider.setMetaModel(metaModel);

    if (list == null || list.isEmpty) {
      if (_page == 1) {
        view.peopleTagListProvider.clear();
      }
      view.peopleTagListProvider.setStateTypeNotNotify(_stateType);
      view.peopleTagListProvider.setHasMore(false);
    } else {
      view.peopleTagListProvider.setHasMore(list.length == 10);
      if (_page == 1) {
        view.peopleTagListProvider.clear();
        view.peopleTagListProvider.addAll(list);
      } else {
        view.peopleTagListProvider.addAll(list);
      }
    }
  }

  void productTagList(List<ProductTagModel>? list, MetaModel? metaModel) {
    view.productTagListProvider.setMetaModel(metaModel);

    if (list == null || list.isEmpty) {
      if (_page == 1) {
        view.productTagListProvider.clear();
      }
      view.productTagListProvider.setStateTypeNotNotify(_stateType);
      view.productTagListProvider.setHasMore(false);
    } else {
      view.productTagListProvider.setHasMore(list.length == 10);
      if (_page == 1) {
        view.productTagListProvider.clear();
        view.productTagListProvider.addAll(list);
      } else {
        view.productTagListProvider.addAll(list);
      }
    }
  }

  void brandTagList(List<BrandTagModel>? list, MetaModel? metaModel) {
    view.brandTagListProvider.setMetaModel(metaModel);

    if (list == null || list.isEmpty) {
      if (_page == 1) {
        view.brandTagListProvider.clear();
      }
      view.brandTagListProvider.setStateTypeNotNotify(_stateType);
      view.brandTagListProvider.setHasMore(false);
    } else {
      view.brandTagListProvider.setHasMore(list.length == 10);
      if (_page == 1) {
        view.brandTagListProvider.clear();
        view.brandTagListProvider.addAll(list);
      } else {
        view.brandTagListProvider.addAll(list);
      }
    }
  }
}
