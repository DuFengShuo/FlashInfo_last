// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumsBean _$AlbumsBeanFromJson(Map<String, dynamic> json) {
  return AlbumsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => AlbumsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$AlbumsBeanToJson(AlbumsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

AlbumsModel _$AlbumsModelFromJson(Map<String, dynamic> json) {
  return AlbumsModel(
    json['id'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
  );
}

Map<String, dynamic> _$AlbumsModelToJson(AlbumsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
