import 'package:json_annotation/json_annotation.dart';

part 'captcha_sms_model.g.dart';

@JsonSerializable()
class CaptchaSmsModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'captcha_sms_key')
  final String? captchaSmsKey;

  @JsonKey(name: 'expired_at')
  final String? expiredAt;

  @JsonKey(name: 'captcha_sms_code')
  final String? captchaSmsCode;

  CaptchaSmsModel(
    this.captchaSmsKey,
    this.expiredAt,
    this.captchaSmsCode,
    this.message,
  );

  factory CaptchaSmsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CaptchaSmsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CaptchaSmsModelToJson(this);
}
