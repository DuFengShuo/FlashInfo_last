import 'package:flashinfo/util/pay_manger.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

import 'page/pay_copy_page.dart';
import 'page/pay_list_page.dart';
import 'page/pay_page.dart';
import 'page/pay_success_page.dart';
import 'page/payment_page.dart';

class PayRouter implements IRouterProvider {
  static String paymentPage = '/payment';
  static String payListPage = '/payList';
  static String payPage = '/pay';
  static String payCopyPage = '/payCopy';
  static String paySuccessPage = 'paySuccess';

  @override
  void initRouter(FluroRouter router) {
    router.define(paymentPage, handler: Handler(handlerFunc: (context, params) {
      final String exportCount = params['exportCount']?.first ?? '';

      /// 类参数
      final args = context!.settings!.arguments! as SkuIdType;
      return PaymentPage(skuIdType: args, exportCount: exportCount);
    }));
    router.define(payListPage,
        handler: Handler(handlerFunc: (_, __) => const PayListPage()));
    router.define(payPage,
        handler: Handler(handlerFunc: (_, __) => const PayPage()));
    router.define(payCopyPage,
        handler: Handler(handlerFunc: (_, __) => const PayCopyPage()));
    router.define(paySuccessPage,
        handler: Handler(handlerFunc: (_, __) => const PaySuccessPage()));
  }
}
