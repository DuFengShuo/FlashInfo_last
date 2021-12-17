// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return VersionModel(
    json['version_check'] == null
        ? null
        : VersionCheck.fromJson(json['version_check'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'version_check': instance.versionCheck,
      'message': instance.message,
    };

VersionCheck _$VersionCheckFromJson(Map<String, dynamic> json) {
  return VersionCheck(
    json['is_renew'] as int?,
    json['is_force_update'] as int?,
    json['download_url'] as String?,
    json['version'] as String?,
    (json['info'] as List<dynamic>?)?.map((dynamic e) => e as String).toList(),
  );
}

Map<String, dynamic> _$VersionCheckToJson(VersionCheck instance) =>
    <String, dynamic>{
      'is_renew': instance.isRenew,
      'is_force_update': instance.isForceUpdate,
      'download_url': instance.downloadUrl,
      'version': instance.version,
      'info': instance.info,
    };
