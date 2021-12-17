// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlock_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnlockContactModel _$UnlockContactModelFromJson(Map<String, dynamic> json) {
  return UnlockContactModel(
    json['data'] == null
        ? null
        : UnlockContact.fromJson(json['data'] as Map<String, dynamic>),
    json['message'] as String?,
    json['status'] as int?,
  );
}

Map<String, dynamic> _$UnlockContactModelToJson(UnlockContactModel instance) =>
    <String, dynamic>{
      'data': instance.nlockContact,
      'message': instance.message,
      'status': instance.status,
    };

UnlockContact _$UnlockContactFromJson(Map<String, dynamic> json) {
  return UnlockContact(
    json['id'] as String?,
    json['email'] as String?,
    json['mobile'] as String?,
    json['vip_data'] == null
        ? null
        : VipData.fromJson(json['vip_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UnlockContactToJson(UnlockContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'mobile': instance.mobile,
      'vip_data': instance.vipData,
    };
