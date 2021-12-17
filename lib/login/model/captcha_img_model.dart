import 'package:json_annotation/json_annotation.dart';

part 'captcha_img_model.g.dart';

@JsonSerializable()
class CaptchaImgModel {
  @JsonKey(name: 'captcha_image_key')
  final String? captchaImageKey;

  @JsonKey(name: 'expired_at')
  final String? expiredAt;

  @JsonKey(name: 'captcha_image_content')
  String? captchaImageContent;

  @JsonKey(name: 'captcha_image_code')
  String? captchaImageCode;

  @JsonKey(name: 'message')
  final String? message;

  CaptchaImgModel(
    this.captchaImageKey,
    this.expiredAt,
    this.captchaImageContent,
    this.captchaImageCode,
    this.message,
  );

  factory CaptchaImgModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaImgModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaImgModelToJson(this);
}
