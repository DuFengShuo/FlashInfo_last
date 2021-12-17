import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_bean.g.dart';

@JsonSerializable()
class NewsBean {
  @JsonKey(name: 'data')
  late List<BrandNewModel>? news;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  NewsBean(
    this.news,
    this.meta,
    this.message,
  );

  factory NewsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsBeanToJson(this);
}

@JsonSerializable()
class BrandNewModel {
  @JsonKey(name: 'id')
  final String? newsId;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'publish_time')
  final String? publishTime;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'source')
  final String? source;

  BrandNewModel(
    this.newsId,
    this.title,
    this.logo,
    this.publishTime,
    this.link,
    this.source,
  );

  factory BrandNewModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}
