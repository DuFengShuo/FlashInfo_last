// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExportBean _$ExportBeanFromJson(Map<String, dynamic> json) {
  return ExportBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => ExportModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$ExportBeanToJson(ExportBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

ExportModel _$ExportModelFromJson(Map<String, dynamic> json) {
  return ExportModel(
    json['id'] as String?,
    json['export_quantity'] as int?,
    json['format'] as String?,
    json['email'] as String?,
    json['send_status'] as int?,
    json['source'] as String?,
    json['created_at'] as String?,
    json['model_type'] as int?,
    json['download_path'] as String?,
    json['condition'] as Map<String, dynamic>?,
    json['message'] as String?,
    json['vip_data'] == null
        ? null
        : VipData.fromJson(json['vip_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExportModelToJson(ExportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'export_quantity': instance.exportQuantity,
      'format': instance.format,
      'email': instance.email,
      'send_status': instance.sendStatus,
      'source': instance.source,
      'created_at': instance.createdAt,
      'model_type': instance.modelType,
      'download_path': instance.downloadPath,
      'condition': instance.condition,
      'vip_data': instance.vipData,
      'message': instance.message,
    };
