import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:provider/provider.dart';

class PersonalParams {
  String? name;
  String? companyName;
  String? companyInfo;
  String? companyAddress;
  String? revenue;
  String? legalRepresetive;
  String? industry;
  String? email;
  String? country;
  String? position;
  String? lastName;
  String? firstName;
  String? companyWebsite;
  String? companyEmail;
  int? workStatus;
  String? companyId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    if (name != null) {
      map['name'] = name;
    }
    if (companyName != null) {
      map['company_name'] = companyName;
    }
    if (companyInfo != null) {
      map['company_info'] = companyInfo;
    }
    if (companyAddress != null) {
      map['company_address'] = companyAddress;
    }
    if (revenue != null) {
      map['revenue'] = revenue;
    }

    if (legalRepresetive != null) {
      map['legal_represetive'] = legalRepresetive;
    }
    if (industry != null) {
      map['industry'] = industry;
    }
    if (email != null) {
      map['email'] = email;
    }
    if (country != null) {
      map['country'] = country;
    }
    if (position != null) {
      map['position'] = position;
    }
    if (lastName != null) {
      map['last_name'] = lastName;
    }
    if (firstName != null) {
      map['first_name'] = firstName;
    }
    if (companyWebsite != null) {
      map['company_website'] = companyWebsite;
    }
    if (companyEmail != null) {
      map['company_email'] = companyEmail;
    }
    if (workStatus != null) {
      map['work_status'] = workStatus;
    }
    if (companyId != null) {
      map['company_id'] = companyId;
    }

    return map;
  }
}

class PersonalPresenter extends BasePagePresenter<IMvpView> {
  @override
  void initState() {
    super.initState();
  }

  // / 修改个人信息
  Future updateUser(Map<String, dynamic> params,
      {Function(bool)? success}) async {
    return requestNetwork<UserInfoModel>(Method.patch,
        url: HttpApi.userUpdate,
        params: params,
        isShow: true, onSuccess: (UserInfoModel? model) async {
      if (model != null) {
        if (model.message!.isEmpty) {
          Toast.show(model.message!);
        }
        await view
            .getContext()
            .read<UserInfoProvider>()
            .setUserInfoModel(model);
        success!(true);
      } else {
        success!(false);
      }
    }, onError: (_, __) async {
      success!(false);
    });
  }

  /// 上传图片实现
  Future renewAvatar(File image) async {
    try {
      final String path = image.path;
      final String name = path.substring(path.lastIndexOf('/') + 1);
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'avatar': await MultipartFile.fromFile(path, filename: name)
      });
      await requestNetwork<UserInfoModel>(Method.post,
          url: HttpApi.renewAvatar,
          params: formData, onSuccess: (UserInfoModel? model) async {
        if (model != null) {
          if (model.message!.isEmpty) {
            Toast.show(model.message!);
          }
          await view
              .getContext()
              .read<UserInfoProvider>()
              .setUserInfoModel(model);
        }
      });
    } catch (e) {
      view.closeProgress();
      view.showToast('Failed to upload pictures！');
    }
  }
}
