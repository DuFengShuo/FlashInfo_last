import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'area_code')
  final String? areaCode;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'company_lnfo')
  final String? companyLnfo;

  @JsonKey(name: 'company_address')
  final String? companyAddress;

  @JsonKey(name: 'revenue')
  final String? revenue;

  @JsonKey(name: 'legal_represetive')
  final String? legalRepresetive;

  @JsonKey(name: 'created_at')
  final int? createdAt;

  @JsonKey(name: 'updated_at')
  final int? updatedAt;

  @JsonKey(name: 'register_time')
  final String? registerTime;

  @JsonKey(name: 'scale')
  final String? scale;

  @JsonKey(name: 'industry')
  final String? industry;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'company_website')
  final String? companyWebsite;

  @JsonKey(name: 'company_email')
  final String? companyEmail;

  @JsonKey(name: 'is_first_login')
  final bool? isFirstLogin;

  @JsonKey(name: 'work_status')
  final int? workStatus;

  @JsonKey(name: 'is_vip')
  final int? isVip;

  @JsonKey(name: 'vip_data')
  late VipData? vipData;

  @JsonKey(name: 'unlock_contacts')
  int? unlockContacts;

  @JsonKey(name: 'favorite_count')
  int? favoriteCount;

  @JsonKey(name: 'browsing_count')
  int? browsingCount;

  @JsonKey(name: 'socials')
  late Socials? socials;

  @JsonKey(name: 'meta')
  late Meta? meta;

  @JsonKey(name: 'message')
  final String? message;

  UserInfoModel(
    this.id,
    this.name,
    this.email,
    this.areaCode,
    this.mobile,
    this.avatar,
    this.companyName,
    this.companyLnfo,
    this.companyAddress,
    this.revenue,
    this.legalRepresetive,
    this.createdAt,
    this.updatedAt,
    this.registerTime,
    this.scale,
    this.industry,
    this.country,
    this.position,
    this.lastName,
    this.firstName,
    this.companyWebsite,
    this.companyEmail,
    this.isFirstLogin,
    this.workStatus,
    this.isVip,
    this.vipData,
    this.unlockContacts,
    this.favoriteCount,
    this.browsingCount,
    this.socials,
    this.meta,
    this.message,
  );

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}

@JsonSerializable()
class Socials {
  @JsonKey(name: 'data')
  late List<BindData>? bindList;

  Socials(
    this.bindList,
  );

  factory Socials.fromJson(Map<String, dynamic> srcJson) =>
      _$SocialsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SocialsToJson(this);
}

@JsonSerializable()
class BindData {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'nickname')
  final String? nickName;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  BindData(this.id, this.type, this.nickName, this.name, this.avatar);

  factory BindData.fromJson(Map<String, dynamic> srcJson) =>
      _$BindDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BindDataToJson(this);
}

@JsonSerializable()
class VipData {
  @JsonKey(name: 'vip_info')
  late VipInfo? vipInfo;

  @JsonKey(name: 'balance_unlock')
  late BalanceUnlock? balanceUnlock;

  @JsonKey(name: 'balance_export')
  late BalanceExport? balanceExport;

  VipData(
    this.vipInfo,
    this.balanceUnlock,
    this.balanceExport,
  );

  factory VipData.fromJson(Map<String, dynamic> srcJson) =>
      _$VipDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VipDataToJson(this);
}

@JsonSerializable()
class VipInfo {
  @JsonKey(name: 'sku_type')
  final int? skuType;

  @JsonKey(name: 'sku_subtype')
  final int? skuSubtype;

  @JsonKey(name: 'expired_at')
  final String? expiredAt;

  @JsonKey(name: 'vip_name')
  final String? vipName;

  @JsonKey(name: 'expired_days')
  final int? expiredDays;

  @JsonKey(name: 'unlock_monthly')
  final int? unlockMonthly;

  @JsonKey(name: 'export_monthly')
  final int? exportMonthly;

  VipInfo(
    this.skuType,
    this.skuSubtype,
    this.expiredAt,
    this.vipName,
    this.expiredDays,
    this.unlockMonthly,
    this.exportMonthly,
  );

  factory VipInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$VipInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VipInfoToJson(this);
}

@JsonSerializable()
class BalanceUnlock {
  @JsonKey(name: 'balance_vip')
  final int? balanceVip;

  @JsonKey(name: 'balance_quantity')
  final int? balanceQuantity;

  BalanceUnlock(
    this.balanceVip,
    this.balanceQuantity,
  );

  factory BalanceUnlock.fromJson(Map<String, dynamic> srcJson) =>
      _$BalanceUnlockFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BalanceUnlockToJson(this);
}

@JsonSerializable()
class BalanceExport {
  @JsonKey(name: 'balance_vip')
  final int? balanceVip;

  @JsonKey(name: 'balance_quantity')
  final int? balanceQuantity;

  BalanceExport(
    this.balanceVip,
    this.balanceQuantity,
  );

  factory BalanceExport.fromJson(Map<String, dynamic> srcJson) =>
      _$BalanceExportFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BalanceExportToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'token_type')
  final String? tokenType;

  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  Meta(
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  );

  factory Meta.fromJson(Map<String, dynamic> srcJson) =>
      _$MetaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
