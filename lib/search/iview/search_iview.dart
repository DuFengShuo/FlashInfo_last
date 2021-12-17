import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

abstract class SearchCacheIMvpView implements IMvpView {
  String get searchValue;
  BaseListProvider<AutocompleteModel> get autoListProvider; //自动补全数据

}

abstract class SearchIMvpView implements IMvpView {
  int get indexType;
  String get searchValue;
  String get otherString; //其他文本
  BaseListProvider<AutocompleteModel> get autoListProvider; //自动补全数据

  BaseListProvider<CompanyModel> get searcCompanyListProvider;
  BaseListProvider<PeoplesModel> get searcPeopleListProvider;
  BaseListProvider<ProductsModel> get searcProductListProvider;
  BaseListProvider<BrandItemModel> get searcBrandListProvider;

  GZXDropdownMenuController get autocompleteMenuController; //自动补全下拉框
}
