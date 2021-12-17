import 'package:json_annotation/json_annotation.dart';

part 'captcha_email_model.g.dart';

@JsonSerializable()
class CaptchaEmailModel {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'captcha_email_key')
  String captchaEmailKey;

  @JsonKey(name: 'expired_at')
  String expiredAt;

  CaptchaEmailModel(
    this.captchaEmailKey,
    this.expiredAt,
    this.message,
  );

  factory CaptchaEmailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaEmailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaEmailModelToJson(this);
}

@JsonSerializable()
class CaptchaNumsModel {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'send_nums')
  int? sendNums;

  @JsonKey(name: 'is_need_captcha')
  int? isNeedCaptcha;

  CaptchaNumsModel(
    this.sendNums,
    this.isNeedCaptcha,
    this.message,
  );

  factory CaptchaNumsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaNumsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaNumsModelToJson(this);
}
