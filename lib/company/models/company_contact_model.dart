import 'package:json_annotation/json_annotation.dart';

part 'company_contact_model.g.dart';

@JsonSerializable()
class CompanyContactModel {
  @JsonKey(name: 'mobile')
  late List<Mobile>? mobile;

  @JsonKey(name: 'email')
  late List<Email>? email;

  @JsonKey(name: 'message')
  final String? message;

  CompanyContactModel(
    this.mobile,
    this.email,
    this.message,
  );

  factory CompanyContactModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyContactModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyContactModelToJson(this);
}

@JsonSerializable()
class Mobile {
  @JsonKey(name: 'mobile')
  final String? mobile;

  Mobile(
    this.mobile,
  );

  factory Mobile.fromJson(Map<String, dynamic> srcJson) =>
      _$MobileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MobileToJson(this);
}

@JsonSerializable()
class Email {
  @JsonKey(name: 'email')
  final String? email;

  Email(
    this.email,
  );

  factory Email.fromJson(Map<String, dynamic> srcJson) =>
      _$EmailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}
