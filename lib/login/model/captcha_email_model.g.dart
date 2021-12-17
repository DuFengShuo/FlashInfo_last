// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaEmailModel _$CaptchaEmailModelFromJson(Map<String, dynamic> json) {
  return CaptchaEmailModel(
    json['captcha_email_key'] as String,
    json['expired_at'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$CaptchaEmailModelToJson(CaptchaEmailModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'captcha_email_key': instance.captchaEmailKey,
      'expired_at': instance.expiredAt,
    };

CaptchaNumsModel _$CaptchaNumsModelFromJson(Map<String, dynamic> json) {
  return CaptchaNumsModel(
    json['send_nums'] as int?,
    json['is_need_captcha'] as int?,
    json['message'] as String?,
  );
}

Map<String, dynamic> _$CaptchaNumsModelToJson(CaptchaNumsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'send_nums': instance.sendNums,
      'is_need_captcha': instance.isNeedCaptcha,
    };
