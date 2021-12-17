// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      message: json['message'] as String?,
      status: json['status'] as int?,
      favoriteCount: json['favorite_count'] as int?,
      collectResult: (json['collectResult'] as Map<String, dynamic>?)?.map(
        (k, dynamic e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$StatusModelToJson(StatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'favorite_count': instance.favoriteCount,
      'collectResult': instance.collectResult,
    };
