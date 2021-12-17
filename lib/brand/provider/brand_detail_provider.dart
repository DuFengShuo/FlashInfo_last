import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class BrandProvider extends ChangeNotifier {
  BrandBean? _brandBean;
  BrandBean? get brandBean => _brandBean;

  StateType _stateType = StateType.company;
  StateType get stateType => _stateType;

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }

  void setBrandBean(BrandBean brandBean) {
    _brandBean = brandBean;
    notifyListeners();
  }

}


