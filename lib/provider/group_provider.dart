import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flutter/material.dart';

class GroupProvider extends ChangeNotifier {
  ///公司标签
  BaseListProvider<TagsModel>? _groupCompanyListProvider;
  BaseListProvider<TagsModel>? get groupCompanyListProvider =>
      _groupCompanyListProvider;

  void setGroupCompanyListProvider(
      BaseListProvider<TagsModel>? groupCompanyListProvider) {
    _groupCompanyListProvider = groupCompanyListProvider;
    notifyListeners();
  }

  ///人员标签
  BaseListProvider<TagsModel>? _groupPersonnelListProvider;
  BaseListProvider<TagsModel>? get groupPersonnelListProvider =>
      _groupPersonnelListProvider;

  void setGroupPersonnelListProvider(
      BaseListProvider<TagsModel>? groupPersonnelListProvider) {
    _groupPersonnelListProvider = groupPersonnelListProvider;
    notifyListeners();
  }

  ///产品标签
  BaseListProvider<TagsModel>? _groupProductListProvider;
  BaseListProvider<TagsModel>? get groupProductListProvider =>
      _groupProductListProvider;

  void setGroupProductListProvider(
      BaseListProvider<TagsModel>? groupProductListProvider) {
    _groupProductListProvider = groupProductListProvider;
    notifyListeners();
  }

  ///品牌标签
  BaseListProvider<TagsModel>? _groupBrandListProvider;
  BaseListProvider<TagsModel>? get groupBrandListProvider =>
      _groupBrandListProvider;

  void setGroupBrandListProvider(
      BaseListProvider<TagsModel>? groupBrandListProvider) {
    _groupBrandListProvider = groupBrandListProvider;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
