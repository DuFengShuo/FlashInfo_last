// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyContactModel _$CompanyContactModelFromJson(Map<String, dynamic> json) {
  return CompanyContactModel(
    (json['mobile'] as List<dynamic>?)
        ?.map((dynamic e) => Mobile.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['email'] as List<dynamic>?)
        ?.map((dynamic e) => Email.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$CompanyContactModelToJson(
        CompanyContactModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'email': instance.email,
      'message': instance.message,
    };

Mobile _$MobileFromJson(Map<String, dynamic> json) {
  return Mobile(
    json['mobile'] as String?,
  );
}

Map<String, dynamic> _$MobileToJson(Mobile instance) => <String, dynamic>{
      'mobile': instance.mobile,
    };

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email(
    json['email'] as String?,
  );
}

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'email': instance.email,
    };
