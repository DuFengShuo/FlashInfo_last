import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tags_bean.g.dart';

@JsonSerializable()
class TagsBean {
  @JsonKey(name: 'data')
  final List<TagsModel>? list;

  @JsonKey(name: 'meta')
  final Meta? meta;

  @JsonKey(name: 'message')
  final String? message;

  TagsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory TagsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$TagsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsBeanToJson(this);
}

@JsonSerializable()
class TagsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'content_count')
  int? contentCount;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'creation_time')
  final String? creationTime;

  @JsonKey(name: 'favorite_count')
  final int? favoriteCount; //关注的个数
  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'is_default')
  final int? isDefault;

  @JsonKey(name: 'message')
  final String? message;

  TagsModel(
    this.id,
    this.name,
    this.contentCount,
    this.createdAt,
    this.creationTime,
    this.type,
    this.isDefault,
    this.message,
    this.favoriteCount,
  );

  factory TagsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TagsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagsModelToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'pagination')
  final Pagination? pagination;
  @JsonKey(name: 'default_content_count')
  final int? defaultContentCount;

  Meta({
    this.pagination,
    this.defaultContentCount,
  });

  factory Meta.fromJson(Map<String, dynamic> srcJson) =>
      _$MetaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
