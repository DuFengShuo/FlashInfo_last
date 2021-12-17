import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/profile/iview/contact_iview.dart';
import 'package:flashinfo/profile/model/people_unlock_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPresenter extends BasePagePresenter<ContactIMvpView> {
  int _page = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onRefresh();
    });
  }

  Future getPeopleUnlockList() {
    if (_page == 1) {
      view.peopleUnlocProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page.toString();
    return requestNetwork<PeopleUnlockBean>(Method.get,
        url: HttpApi.peopleUnlockList,
        params: params,
        isShow: false, onSuccess: (PeopleUnlockBean? bean) async {
      if (bean != null && bean.list != null) {
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setUnlockContacts(count: bean.meta?.pagination?.total);
        view.peopleUnlocProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.peopleUnlocProvider.clear();
          if (bean.list!.isEmpty) {
            view.peopleUnlocProvider.setStateType(StateType.exportHistory);
          } else {
            view.peopleUnlocProvider.addAll(bean.list!);
          }
        } else {
          view.peopleUnlocProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.peopleUnlocProvider.setHasMore(false);
        view.peopleUnlocProvider.setStateType(StateType.exportHistory);
      }
    }, onError: (_, __) {
      view.peopleUnlocProvider.setHasMore(false);
      view.peopleUnlocProvider.setStateType(StateType.exportHistory);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await getPeopleUnlockList();
  }

  Future<void> loadMore() async {
    _page++;
    await getPeopleUnlockList();
  }
}
