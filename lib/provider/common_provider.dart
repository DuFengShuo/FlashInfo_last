import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  ///推荐品牌数据
  BaseListProvider<BrandItemModel>? _recompanyListProvider =
      BaseListProvider<BrandItemModel>();
  BaseListProvider<BrandItemModel>? get recompanyListProvider =>
      _recompanyListProvider;

  void setRecompanyListProvider(
      BaseListProvider<BrandItemModel>? recompanyListProvider) {
    _recompanyListProvider = recompanyListProvider;
    notifyListeners();
  }

  InitializeModel? _initializeModel;
  InitializeModel? get initializeModel => _initializeModel;
  void setInitializeModel(InitializeModel? initializeModel) {
    _initializeModel = initializeModel;
  }

  HotWordsModel? _hotWordsModel;
  HotWordsModel? get hotWordsModel => _hotWordsModel;
  Future setHotWordsModel(HotWordsModel hotWordsModel) async {
    _hotWordsModel = hotWordsModel;
    notifyListeners();
  }
}
