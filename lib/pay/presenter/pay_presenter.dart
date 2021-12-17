import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/pay/iview/pay_iview.dart';
import 'package:flashinfo/pay/model/go_pay_bean.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:provider/provider.dart';

enum PaymentType {
  GOOGLE,
  IOS,
  STRIPE,
  PAYPAL,
}

class PaymentsParams {
  String? paymentType;
  int? orderType;
  int? skuId;
  int? quantity;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (paymentType != null) {
      map['payment_type'] = paymentType;
    }
    if (orderType != null) {
      map['order_type'] = orderType;
    }
    if (skuId != null) {
      map['sku_id'] = skuId;
    }
    map['quantity'] = quantity ?? 1;

    return map;
  }
}

// product_id IOS内购商品ID
// receiptdata IOS返回的验证数据
// order_on 订单号
class PayParams {
  String? productId;
  String? orderOn;
  String? receiptdata;
  String? purchaseToken;
  String? subscriptionId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (productId != null) {
      map['product_id'] = productId;
    }
    if (orderOn != null) {
      map['order_on'] = orderOn;
    }
    if (receiptdata != null) {
      map['receiptdata'] = receiptdata;
    }
    if (purchaseToken != null) {
      map['purchase_token'] = purchaseToken;
    }
    if (subscriptionId != null) {
      map['subscription_id'] = subscriptionId;
    }
    return map;
  }
}

class PayPresenter extends BasePagePresenter<PayIMvpView> {
  // 获取google、ios内购商品ID
  Future getproducts(PaymentsParams params,
      {Function(GoProductsModel?)? success}) {
    return requestNetwork<GoProductsModel>(Method.post,
        url: HttpApi.paymentsGetproducts,
        params: params.toJson(),
        isShow: true, onSuccess: (GoProductsModel? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message ?? '');
        }
        success!(model);
      } else {
        success!(null);
      }
    }, onError: (_, __) {
      success!(null);
    });
  }

  Future getOrderOn(PaymentsParams params, {Function(GoPayModel?)? success}) {
    return requestNetwork<GoPayBean>(Method.post,
        url: HttpApi.payments,
        params: params.toJson(),
        isShow: true, onSuccess: (GoPayBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          view.showToast(model.message ?? '');
        }
        if ((model.goPayModel?.orderOn ?? '').isNotEmpty) {
          success!(model.goPayModel);
        }
      }
    }, onError: (_, __) {
      NavigatorUtils.goBack(view.getContext());
    });
  }

  ///验证ios支付订单
  Future iosPay(PayParams params, {Function? paySuccess}) {
    return requestNetwork<GoPayBean>(Method.post,
        url: HttpApi.iosPay,
        params: params.toJson(),
        isShow: true, onSuccess: (GoPayBean? model) async {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          Toast.show(model.message ?? '');
        }
        if (model.payStatus == 1) {
          paySuccess!();
        }
      }
    }, onError: (_, __) {});
  }

  ///验证安卓支付订单
  Future googlePay(PayParams params, {Function? paySuccess}) {
    return requestNetwork<GoPayBean>(Method.post,
        url: HttpApi.googlePay,
        params: params.toJson(),
        isShow: true, onSuccess: (GoPayBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          Toast.show(model.message ?? '');
        }
        paySuccess!();
      }
    }, onError: (_, __) {});
  }

  ///验证安卓支付订单
  Future googSubscriptionlePay(PayParams params, {Function? paySuccess}) {
    return requestNetwork<GoPayBean>(Method.post,
        url: HttpApi.googSubscriptionlePay,
        params: params.toJson(),
        isShow: true, onSuccess: (GoPayBean? model) {
      if (model != null) {
        if (model.message!.isNotEmpty) {
          Toast.show(model.message ?? '');
        }
        paySuccess!();
      }
    }, onError: (_, __) {});
  }

  // 获取用户信息
  Future getUserInfo({Function? success}) async {
    return requestNetwork<UserInfoModel>(Method.get,
        url: HttpApi.userInfo, isShow: true, onSuccess: (UserInfoModel? model) {
      if (model != null) {
        success!();
        view.getContext().read<UserInfoProvider>().setUserInfoModel(model);
      }
    });
  }
}
