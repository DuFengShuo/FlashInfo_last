import 'package:flashinfo/product/model/products_details_bean.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier {
  ProductsDetailsBean? _productsDetailsBean;
  ProductsDetailsBean? get productsDetailsBean => _productsDetailsBean;

  void setProductDetailModel(ProductsDetailsBean productsDetailsBean) {
    _productsDetailsBean = productsDetailsBean;
    notifyListeners();
  }

  StateType _stateType = StateType.company;
  StateType get stateType => _stateType;

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }
}
