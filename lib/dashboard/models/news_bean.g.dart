// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsBean _$NewsBeanFromJson(Map<String, dynamic> json) {
  return NewsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => BrandNewModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$NewsBeanToJson(NewsBean instance) => <String, dynamic>{
      'data': instance.news,
      'meta': instance.meta,
      'message': instance.message,
    };

BrandNewModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return BrandNewModel(
    json['news_id'] as String?,
    json['title'] as String?,
    json['logo'] as String?,
    json['publish_time'] as String?,
    json['link'] as String?,
    json['source'] as String?,
  );
}

Map<String, dynamic> _$NewsModelToJson(BrandNewModel instance) => <String, dynamic>{
      'news_id': instance.newsId,
      'title': instance.title,
      'logo': instance.logo,
      'publish_time': instance.publishTime,
      'link': instance.link,
      'source': instance.source,
    };
