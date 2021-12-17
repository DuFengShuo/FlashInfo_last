// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'honors_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HonorsBean _$HonorsBeanFromJson(Map<String, dynamic> json) {
  return HonorsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => HonorsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HonorsBeanToJson(HonorsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
    };

HonorsModel _$HonorsModelFromJson(Map<String, dynamic> json) {
  return HonorsModel(
    json['id'] as String?,
    json['honor_name'] as String?,
    json['organization_name'] as String?,
    json['year'] as String?,
  );
}

Map<String, dynamic> _$HonorsModelToJson(HonorsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'honor_name': instance.honorName,
      'organization_name': instance.organizationName,
      'year': instance.year,
    };
