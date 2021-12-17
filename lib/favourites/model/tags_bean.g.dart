// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagsBean _$TagsBeanFromJson(Map<String, dynamic> json) => TagsBean(
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => TagsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$TagsBeanToJson(TagsBean instance) => <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

TagsModel _$TagsModelFromJson(Map<String, dynamic> json) => TagsModel(
      json['id'] as String?,
      json['name'] as String?,
      json['content_count'] as int?,
      json['created_at'] as String?,
      json['creation_time'] as String?,
      json['type'] as int?,
      json['is_default'] as int?,
      json['message'] as String?,
      json['favorite_count'] as int?,
    );

Map<String, dynamic> _$TagsModelToJson(TagsModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content_count': instance.contentCount,
      'created_at': instance.createdAt,
      'creation_time': instance.creationTime,
      'favorite_count': instance.favoriteCount,
      'type': instance.type,
      'is_default': instance.isDefault,
      'message': instance.message,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      defaultContentCount: json['default_content_count'] as int?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'pagination': instance.pagination,
      'default_content_count': instance.defaultContentCount,
    };
