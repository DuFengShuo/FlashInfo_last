import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:rxdart/rxdart.dart';

import 'device_utils.dart';
import 'dart:async';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_ios/in_app_purchase_ios.dart';
import 'package:in_app_purchase_ios/store_kit_wrappers.dart';

class PayManger {
  factory PayManger() => _instance;
  PayManger._internal();
  static final PayManger _instance = PayManger._internal();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  // ignore: unused_field
  late bool _isAvailable = false;
  // ignore: unused_field
  late String? _queryProductError;
  // ignore: unused_field
  late List<ProductDetails> products = [];

  late PublishSubject<List<ProductDetails>> productsubject;
  late PublishSubject<PurchaseStatusModel> purchasedSubject;

  // ignore: unused_field
  late bool _purchasePending = false;
  void init(SkuIdType skuIdType, List<String> skuIdList) {
    productsubject = PublishSubject<List<ProductDetails>>();
    purchasedSubject = PublishSubject<PurchaseStatusModel>();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (dynamic error) {
      // handle error here.
    });
    initStoreInfo(skuIdType, skuIdList);
  }

  Future<void> initStoreInfo(
      SkuIdType skuIdType, List<String> skuIdList) async {
    ///如果支付平台准备就绪并且可用，则返回 `true`。
    _isAvailable = await _inAppPurchase.isAvailable();
    //结束上一次购买事物
    if (Device.isIOS) {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      transactions.forEach((transaction) async {
        await paymentWrapper.finishTransaction(transaction);
      });
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(skuIdList.toSet());
    if (productDetailResponse.error != null) {
      _queryProductError = productDetailResponse.error!.message;
      products = [];
      productsubject.add(products);
      _purchasePending = false;
    } else {
      products = productDetailResponse.productDetails;
      products.sort((left, right) => left.rawPrice.compareTo(right.rawPrice));
      _purchasePending = false;
      productsubject.add(products);
    }
  }

  void restorePurchases() {
    _inAppPurchase.restorePurchases();
  }

  void goPay(ProductDetails productDetails, bool isConsum) {
    late PurchaseParam purchaseParam;

    if (Device.isAndroid) {
      //注意:如果您正在进行订阅购买/升级/降级，我们建议您
//通过使用服务器端接收验证来验证订阅的最新状态
//并相应地更新UI。所显示的订阅购买状态
//应用内部可能不准确。
      purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails,
          applicationUserName: null,
          changeSubscriptionParam: null);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );
    }

    if (isConsum) {
      _inAppPurchase.buyConsumable(
          purchaseParam: purchaseParam, autoConsume: Device.isIOS);
    } else {
      _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    final PurchaseStatusModel model = PurchaseStatusModel();
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      model.purchaseDetails = purchaseDetails;
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('购买过程待定。');
        model.isShowProgress = true;
        purchasedSubject.add(model);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          model.isShowProgress = false;
          purchasedSubject.add(model);

          print('购买失败');
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          print('购买完成并成功。');
          model.isShowProgress = false;
          purchasedSubject.add(model);
          //支付结果
          AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Payment_Result');
        }
        if (Device.isAndroid) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchaseDetails);
        }
        restorePurchases();
      }
    });
  }

  void dispose() {
    if (Device.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseIosPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    products = [];
    _queryProductError = null;
    if (subscription != null) {
      subscription.cancel();
    }
    if (productsubject != null) {
      productsubject.close();
    }
    if (purchasedSubject != null) {
      purchasedSubject.close();
    }
  }
}

///实例实现
//(“SKPaymentQueueDelegate”)(https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc)。
///
///可以实现支付队列委托来提供信息
//需要完成事务
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

enum SkuIdType {
  pro,
  starter,
  contact,
  csv,
}

class PurchaseStatusModel {
  bool? isShowProgress;
  PurchaseDetails? purchaseDetails;
}
