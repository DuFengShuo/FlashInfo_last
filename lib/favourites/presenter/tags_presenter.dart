import 'package:flashinfo/favourites/iview/tags_iview.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/group_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagsPresenter extends BasePagePresenter<TagsIMvpView> {
  int _page = 1;
  int indexType = 0;
  String type = 'company';
  late StateType stateType;
  @override
  void initState() {
    switch (indexType) {
      case 0:
        type = 'company';
        stateType = StateType.company;
        break;
      case 1:
        type = 'brand';
        stateType = StateType.personnel;
        break;
      case 2:
        type = 'product';
        stateType = StateType.product;
        break;
      case 3:
        type = 'personnel';
        stateType = StateType.personnel;
        break;
      default:
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // getTags();
    });
  }

  ///获取标签列表
  Future getTags() async {
    if (_page == 1) {
      view.tagsListProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page;
    return requestNetwork<TagsBean>(Method.get,
        url: HttpApi.tags + type,
        queryParameters: params,
        isShow: false, onSuccess: (TagsBean? bean) async {
      if (bean != null && bean.list != null) {
        view.tagsListProvider.setHasMore(bean.list?.length == 10);
        if (_page == 1) {
          view.tagsListProvider.clear();
          if (bean.list!.isEmpty) {
            view.tagsListProvider.setStateType(stateType);
          } else {
            view.tagsListProvider.addAll(bean.list!);
          }
        } else {
          view.tagsListProvider.addAll(bean.list!);
        }
        setGroupistProvider();
      } else {
        /// 加载失败
        view.tagsListProvider.setHasMore(false);
        view.tagsListProvider.setStateType(stateType);
      }
    }, onError: (_, __) {
      view.tagsListProvider.setHasMore(false);
      view.tagsListProvider.setStateType(StateType.network);
    });
  }

  //新闻下拉
  Future<void> onRefresh() async {
    _page = 1;
    await getTags();
  }

  //新闻上拉
  Future loadMore() async {
    _page++;
    await getTags();
  }

  ///添加标签
  Future addTags(String name, Function(bool)? addSuccessful) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['name'] = name;
    params['type'] = type;
    return requestNetwork<TagsModel>(Method.post,
        url: HttpApi.tags,
        params: params,
        isShow: true, onSuccess: (TagsModel? bean) async {
      if (bean != null) {
        addSuccessful!(true);
        view.tagsListProvider.insert(3, bean);
        setGroupistProvider();
      }
    }, onError: (_, __) {});
  }

  ///删除标签
  Future deleteTags(String? id, int index) async {
    return requestNetwork<TagsModel>(Method.delete,
        url: HttpApi.tags + '$id',
        isShow: true, onSuccess: (TagsModel? bean) async {
      if (bean != null) {
        view.tagsListProvider.removeAt(index);
        if (view.tagsListProvider.list.isEmpty) {
          view.tagsListProvider.setStateType(stateType);
        }
        view
            .getContext()
            .read<UserInfoProvider>()
            .updateUserFavoriteCount(bean.favoriteCount);
        setGroupistProvider();
      }
    }, onError: (_, __) {});
  }

  ///全局保存数据
  void setGroupistProvider({TagsModel? model}) {
    final GroupProvider groupProvider = view.getContext().read<GroupProvider>();
    switch (indexType) {
      case 0:
        groupProvider.setGroupCompanyListProvider(view.tagsListProvider);
        break;
      case 1:
        groupProvider.setGroupBrandListProvider(view.tagsListProvider);
        break;
      case 2:
        groupProvider.setGroupProductListProvider(view.tagsListProvider);
        break;
      case 3:
        groupProvider.setGroupPersonnelListProvider(view.tagsListProvider);
        break;
    }
  }
}
