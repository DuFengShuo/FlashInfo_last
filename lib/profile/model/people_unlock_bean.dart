import 'package:flashinfo/mvp/meta_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'people_unlock_bean.g.dart';

@JsonSerializable()
class PeopleUnlockBean {
  @JsonKey(name: 'data')
  late List<PeopleUnlockModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  PeopleUnlockBean(
    this.list,
    this.meta,
    this.message,
  );

  factory PeopleUnlockBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleUnlockBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleUnlockBeanToJson(this);
}

@JsonSerializable()
class PeopleUnlockModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'contact_name')
  final String? contactName;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'province')
  final String? province;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'unlock_date')
  final String? unlockDate;

  PeopleUnlockModel(
    this.id,
    this.contactName,
    this.avatar,
    this.email,
    this.mobile,
    this.country,
    this.province,
    this.address,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.companyName,
    this.unlockDate,
  );

  factory PeopleUnlockModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleUnlockModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleUnlockModelToJson(this);
}
