import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/pay/model/go_pay_bean.dart';
import 'package:flashinfo/pay/model/pay_ments_list_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class PayIMvpView implements IMvpView {
  GoPayModel get payModel;
}

abstract class PriceListIMvpView implements IMvpView {}

abstract class PaymentsIMvpView implements IMvpView {
  BaseListProvider<PayMentsListModel> get paymentsListModelProvider;
}
