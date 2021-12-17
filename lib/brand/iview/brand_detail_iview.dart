import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/brand/provider/brand_detail_provider.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class BrandDetailIMvpView implements IMvpView {
  BrandProvider get brandProvider;
  // BaseListProvider<CompanyModel> get companyListProvider;
  // BaseListProvider<PeoplesModel> get peopleContactProvider;
}

abstract class BrandEventIMvpView implements IMvpView {
  BaseListProvider<EventModel> get  brandEventProvider;
}
