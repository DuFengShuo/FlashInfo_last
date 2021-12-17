import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unlock_contact_model.g.dart';

@JsonSerializable()
class UnlockContactModel {
  @JsonKey(name: 'data')
  late UnlockContact? nlockContact;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status;

  UnlockContactModel(
    this.nlockContact,
    this.message,
    this.status,
  );

  factory UnlockContactModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UnlockContactModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UnlockContactModelToJson(this);
}

@JsonSerializable()
class UnlockContact {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'vip_data')
  late VipData? vipData;

  UnlockContact(
    this.id,
    this.email,
    this.mobile,
    this.vipData,
  );

  factory UnlockContact.fromJson(Map<String, dynamic> srcJson) =>
      _$UnlockContactFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UnlockContactToJson(this);
}
