// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha_img_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaImgModel _$CaptchaImgModelFromJson(Map<String, dynamic> json) {
  return CaptchaImgModel(
    json['captcha_image_key'] as String?,
    json['expired_at'] as String?,
    json['captcha_image_content'] as String?,
    json['captcha_image_code'] as String?,
    json['message'] as String?,
  );
}

Map<String, dynamic> _$CaptchaImgModelToJson(CaptchaImgModel instance) =>
    <String, dynamic>{
      'captcha_image_key': instance.captchaImageKey,
      'expired_at': instance.expiredAt,
      'captcha_image_content': instance.captchaImageContent,
      'captcha_image_code': instance.captchaImageCode,
      'message': instance.message,
    };
