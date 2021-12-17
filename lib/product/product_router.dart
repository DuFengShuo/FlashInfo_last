import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/page/product_details_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';

class ProductRouter implements IRouterProvider {
  static String productDetailsPage = '/productDetails';

  @override
  void initRouter(FluroRouter router) {
    router.define(productDetailsPage,
        handler: Handler(handlerFunc: (context, params) {
      final String productId = params['productId']?.first ?? '';
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as ProductsModel;
      return ProductDetailsPage(
        productId: productId,
        model: args,
      );
    }));
  }
}
