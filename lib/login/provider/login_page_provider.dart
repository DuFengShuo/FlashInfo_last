import 'package:flashinfo/login/model/captcha_img_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class LoginPageProvider extends ChangeNotifier {
  final PublishSubject<bool>? _smsSubject = PublishSubject<bool>();
  PublishSubject? get smsSubject => _smsSubject;

  CaptchaImgModel? _captchaImgModel;
  CaptchaImgModel? get captchaImgModel => _captchaImgModel;

  void setCaptchaImgModel(CaptchaImgModel model) {
    _captchaImgModel = model;
    notifyListeners();
  }
}
