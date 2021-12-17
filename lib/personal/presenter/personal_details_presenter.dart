// class PersonalDetailPresenter extends BasePagePresenter<CompanyDetialIMvpView> {}

import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/personal/iview/personal_ivew.dart';
import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalDetailPresenter
    extends BasePagePresenter<PersonalDetialIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {},
    );
  }

  // 请求人员详情数据
  Future getPersonalDetail(String personalId) {
    return requestNetwork<PeoplesNewBean>(Method.get,
         url: HttpApi.peoplesDetail + '$personalId',
        // url: HttpApi.peoplesDetail + 'Bq841L0E4d0O9K3l',
        isShow: false, onSuccess: (PeoplesNewBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message ?? '');
        }
        // view
        //     .getContext()
        //     .read<UserInfoProvider>()
        //     .updateUserBrowsingCount(model.browsingCount);
        view.personalProvider.setPersonalDetailsBean(model);
      } else {
        view.personalProvider.setStateType(StateType.company);
      }
    }, onError: (_, __) {
      view.personalProvider.setStateType(StateType.company);
    });
  }
}
