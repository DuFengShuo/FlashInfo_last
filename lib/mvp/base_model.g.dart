// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return BaseModel(
    message: json['message'] as String?,
    statusCode: json['status_code'] as int?,
  );
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'message': instance.message,
      'status_code': instance.statusCode,
    };
