import 'package:json_annotation/json_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable()
class VersionModel {
  @JsonKey(name: 'version_check')
  final VersionCheck? versionCheck;

  @JsonKey(name: 'message')
  final String? message;

  VersionModel(
    this.versionCheck,
    this.message,
  );

  factory VersionModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VersionModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}

@JsonSerializable()
class VersionCheck {
  @JsonKey(name: 'is_renew')
  final int? isRenew;

  @JsonKey(name: 'is_force_update')
  final int? isForceUpdate;

  @JsonKey(name: 'download_url')
  final String? downloadUrl;

  @JsonKey(name: 'version')
  final String? version;

  @JsonKey(name: 'info')
  final List<String>? info;

  VersionCheck(
    this.isRenew,
    this.isForceUpdate,
    this.downloadUrl,
    this.version,
    this.info,
  );

  factory VersionCheck.fromJson(Map<String, dynamic> srcJson) =>
      _$VersionCheckFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VersionCheckToJson(this);
}
