import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  int unlockCount = 0;
  int exportCount = 0;
  bool isVip = false;

  Future setUserInfoModel(UserInfoModel? userInfoModel) async {
    _userInfoModel = userInfoModel;
    if (userInfoModel != null) {
      isVip = userInfoModel.isVip == 1 ? true : false;
      unlockCount =
          (userInfoModel.vipData?.balanceUnlock?.balanceQuantity ?? 0) +
              (userInfoModel.vipData?.balanceUnlock?.balanceVip ?? 0);
      exportCount =
          (userInfoModel.vipData?.balanceExport?.balanceQuantity ?? 0) +
              (userInfoModel.vipData?.balanceExport?.balanceVip ?? 0);
      await SpUtil.putBool(Constant.isLogin, true);
      if (userInfoModel.meta != null &&
          userInfoModel.meta?.accessToken != null) {
        await SpUtil.putString(Constant.accessToken,
            '${userInfoModel.meta?.tokenType} ${userInfoModel.meta?.accessToken}');
      }
    }
    refresh();
  }

  Future logOut() async {
    await setUserInfoModel(null);
    await SpUtil.putBool(Constant.isLogin, false);
    await SpUtil.putString(Constant.accessToken, '');
    await SpUtil.putString(Constant.phone, '');
    await SpUtil.putString(Constant.email, '');
    isVip = false;
    refresh();
  }

  void updateUserFavoriteCount(int? count) {
    if (userInfoModel != null) {
      userInfoModel?.favoriteCount = count;
      refresh();
    }
  }

  void updateUserBrowsingCount(int? count) {
    if (userInfoModel != null) {
      userInfoModel?.browsingCount = count;
      refresh();
    }
  }

  VipData? _vipData;
  VipData? get vipData => _vipData;
  Future setVipData(VipData? vipData) async {
    _vipData = vipData;
    userInfoModel?.vipData = vipData;

    setUserInfoModel(userInfoModel);
    refresh();
  }

  Future setUnlockContacts({int? count}) async {
    if (count != null) {
      userInfoModel?.unlockContacts = count;
    } else {
      userInfoModel?.unlockContacts = (userInfoModel?.unlockContacts ?? 0) + 1;
    }

    setUserInfoModel(userInfoModel);
    refresh();
  }

  void refresh() {
    notifyListeners();
  }
}
