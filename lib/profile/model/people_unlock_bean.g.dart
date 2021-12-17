// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_unlock_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeopleUnlockBean _$PeopleUnlockBeanFromJson(Map<String, dynamic> json) {
  return PeopleUnlockBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            PeopleUnlockModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$PeopleUnlockBeanToJson(PeopleUnlockBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

PeopleUnlockModel _$PeopleUnlockModelFromJson(Map<String, dynamic> json) {
  return PeopleUnlockModel(
    json['id'] as String?,
    json['contact_name'] as String?,
    json['avatar'] as String?,
    json['email'] as String?,
    json['mobile'] as String?,
    json['country'] as String?,
    json['province'] as String?,
    json['address'] as String?,
    json['twitter'] as String?,
    json['linkedin'] as String?,
    json['facebook'] as String?,
    json['company_name'] as String?,
    json['unlock_date'] as String?,
  );
}

Map<String, dynamic> _$PeopleUnlockModelToJson(PeopleUnlockModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_name': instance.contactName,
      'avatar': instance.avatar,
      'email': instance.email,
      'mobile': instance.mobile,
      'country': instance.country,
      'province': instance.province,
      'address': instance.address,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'company_name': instance.companyName,
      'unlock_date': instance.unlockDate,
    };
