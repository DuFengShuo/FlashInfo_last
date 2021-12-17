import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:flashinfo/personal/model/personal_details_bean.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flutter/material.dart';

class PersonalProvider extends ChangeNotifier {
  PeoplesNewBean? _personalDetailsBean;
  PeoplesNewBean? get personalDetailsBean => _personalDetailsBean;

  void setPersonalDetailsBean(PeoplesNewBean personalDetailsBean) {
    _personalDetailsBean = personalDetailsBean;
    notifyListeners();
  }

  StateType _stateType = StateType.company;
  StateType get stateType => _stateType;

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }
}


class PersonalExperienceCountProvider extends ChangeNotifier {
  late int count = 0 ;

  Future setCount(int counts) async {
    count = counts;
  }
}
