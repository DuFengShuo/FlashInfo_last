import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/pay/iview/pay_iview.dart';
import 'package:flashinfo/pay/model/pay_ments_list_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentsPresenter extends BasePagePresenter<PaymentsIMvpView> {
  int _page = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) async {
        allBalance();
      },
    );
  }

  Future paymentsList() {
    if (_page == 1) {
      view.paymentsListModelProvider.setStateType(StateType.listLayout);
    }
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = _page.toString();
    return requestNetwork<PayMentsListBean>(Method.get,
        url: HttpApi.payments,
        params: params,
        isShow: false, onSuccess: (PayMentsListBean? bean) {
      if (bean != null && bean.list != null) {
        view.paymentsListModelProvider.setHasMore(bean.list?.length == 20);
        if (_page == 1) {
          view.paymentsListModelProvider.clear();
          if (bean.list!.isEmpty) {
            view.paymentsListModelProvider
                .setStateType(StateType.exportHistory);
          } else {
            view.paymentsListModelProvider.addAll(bean.list!);
          }
        } else {
          view.paymentsListModelProvider.addAll(bean.list!);
        }
      } else {
        /// 加载失败
        view.paymentsListModelProvider.setHasMore(false);
        view.paymentsListModelProvider.setStateType(StateType.exportHistory);
      }
    }, onError: (_, __) {
      view.paymentsListModelProvider.setHasMore(false);
      view.paymentsListModelProvider.setStateType(StateType.exportHistory);
    });
  }

  Future<void> onRefresh() async {
    _page = 1;
    await paymentsList();
  }

  Future<void> loadMore() async {
    _page++;
    await paymentsList();
  }

  Future allBalance() {
    return requestNetwork<VipData>(Method.get,
        url: HttpApi.allBalance,
        isShow: false, onSuccess: (VipData? bean) async {
      if (bean != null) {
        await view.getContext().read<UserInfoProvider>().setVipData(bean);
      }
    }, onError: (_, __) {});
  }
}
