import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/product/provider/product_provider.dart';

abstract class ProductDetialIMvpView implements IMvpView {
  ProductProvider get productProvider;
}
