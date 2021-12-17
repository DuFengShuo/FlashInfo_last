// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    json['id'] as String?,
    json['name'] as String?,
    json['email'] as String?,
    json['area_code'] as String?,
    json['mobile'] as String?,
    json['avatar'] as String?,
    json['company_name'] as String?,
    json['company_lnfo'] as String?,
    json['company_address'] as String?,
    json['revenue'] as String?,
    json['legal_represetive'] as String?,
    json['created_at'] as int?,
    json['updated_at'] as int?,
    json['register_time'] as String?,
    json['scale'] as String?,
    json['industry'] as String?,
    json['country'] as String?,
    json['position'] as String?,
    json['last_name'] as String?,
    json['first_name'] as String?,
    json['company_website'] as String?,
    json['company_email'] as String?,
    json['is_first_login'] as bool?,
    json['work_status'] as int?,
    json['is_vip'] as int?,
    json['vip_data'] == null
        ? null
        : VipData.fromJson(json['vip_data'] as Map<String, dynamic>),
    json['unlock_contacts'] as int?,
    json['favorite_count'] as int?,
    json['browsing_count'] as int?,
    json['socials'] == null
        ? null
        : Socials.fromJson(json['socials'] as Map<String, dynamic>),
    json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'area_code': instance.areaCode,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
      'company_name': instance.companyName,
      'company_lnfo': instance.companyLnfo,
      'company_address': instance.companyAddress,
      'revenue': instance.revenue,
      'legal_represetive': instance.legalRepresetive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'register_time': instance.registerTime,
      'scale': instance.scale,
      'industry': instance.industry,
      'country': instance.country,
      'position': instance.position,
      'last_name': instance.lastName,
      'first_name': instance.firstName,
      'company_website': instance.companyWebsite,
      'company_email': instance.companyEmail,
      'is_first_login': instance.isFirstLogin,
      'work_status': instance.workStatus,
      'is_vip': instance.isVip,
      'vip_data': instance.vipData,
      'unlock_contacts': instance.unlockContacts,
      'favorite_count': instance.favoriteCount,
      'browsing_count': instance.browsingCount,
      'socials': instance.socials,
      'meta': instance.meta,
      'message': instance.message,
    };

Socials _$SocialsFromJson(Map<String, dynamic> json) {
  return Socials(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => BindData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SocialsToJson(Socials instance) => <String, dynamic>{
      'data': instance.bindList,
    };

BindData _$BindDataFromJson(Map<String, dynamic> json) {
  return BindData(
    json['id'] as String?,
    json['type'] as String?,
    json['nickname'] as String?,
    json['name'] as String?,
    json['avatar'] as String?,
  );
}

Map<String, dynamic> _$BindDataToJson(BindData instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'nickname': instance.nickName,
      'name': instance.name,
      'avatar': instance.avatar,
    };

VipData _$VipDataFromJson(Map<String, dynamic> json) {
  return VipData(
    json['vip_info'] == null
        ? null
        : VipInfo.fromJson(json['vip_info'] as Map<String, dynamic>),
    json['balance_unlock'] == null
        ? null
        : BalanceUnlock.fromJson(
            json['balance_unlock'] as Map<String, dynamic>),
    json['balance_export'] == null
        ? null
        : BalanceExport.fromJson(
            json['balance_export'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VipDataToJson(VipData instance) => <String, dynamic>{
      'vip_info': instance.vipInfo,
      'balance_unlock': instance.balanceUnlock,
      'balance_export': instance.balanceExport,
    };

VipInfo _$VipInfoFromJson(Map<String, dynamic> json) {
  return VipInfo(
    json['sku_type'] as int?,
    json['sku_subtype'] as int?,
    json['expired_at'] as String?,
    json['vip_name'] as String?,
    json['expired_days'] as int?,
    json['unlock_monthly'] as int?,
    json['export_monthly'] as int?,
  );
}

Map<String, dynamic> _$VipInfoToJson(VipInfo instance) => <String, dynamic>{
      'sku_type': instance.skuType,
      'sku_subtype': instance.skuSubtype,
      'expired_at': instance.expiredAt,
      'vip_name': instance.vipName,
      'expired_days': instance.expiredDays,
      'unlock_monthly': instance.unlockMonthly,
      'export_monthly': instance.exportMonthly,
    };

BalanceUnlock _$BalanceUnlockFromJson(Map<String, dynamic> json) {
  return BalanceUnlock(
    json['balance_vip'] as int?,
    json['balance_quantity'] as int?,
  );
}

Map<String, dynamic> _$BalanceUnlockToJson(BalanceUnlock instance) =>
    <String, dynamic>{
      'balance_vip': instance.balanceVip,
      'balance_quantity': instance.balanceQuantity,
    };

BalanceExport _$BalanceExportFromJson(Map<String, dynamic> json) {
  return BalanceExport(
    json['balance_vip'] as int?,
    json['balance_quantity'] as int?,
  );
}

Map<String, dynamic> _$BalanceExportToJson(BalanceExport instance) =>
    <String, dynamic>{
      'balance_vip': instance.balanceVip,
      'balance_quantity': instance.balanceQuantity,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    json['access_token'] as String?,
    json['token_type'] as String?,
    json['expires_in'] as int?,
  );
}

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
