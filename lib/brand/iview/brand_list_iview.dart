import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class BrandListIMvpView implements IMvpView {
  BaseListProvider<BrandItemModel> get searcBrandListProvider;
}
