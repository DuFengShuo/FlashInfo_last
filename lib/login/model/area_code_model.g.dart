// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaCodeModel _$AreaCodeModelFromJson(Map<String, dynamic> json) {
  return AreaCodeModel(
    json['name_en'] as String?,
    json['name_zh'] as String?,
    json['code'] as String?,
    json['locale'] as String?,
    json['preg'] as String?,
    json['icon'] as String?,
  );
}

Map<String, dynamic> _$AreaCodeModelToJson(AreaCodeModel instance) =>
    <String, dynamic>{
      'name_en': instance.nameEn,
      'name_zh': instance.nameZh,
      'code': instance.code,
      'locale': instance.locale,
      'preg': instance.preg,
      'icon': instance.icon,
    };
