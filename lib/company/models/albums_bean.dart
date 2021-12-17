import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'albums_bean.g.dart';

@JsonSerializable()
class AlbumsBean {
  @JsonKey(name: 'data')
  late List<AlbumsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  AlbumsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory AlbumsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumsBeanToJson(this);
}

@JsonSerializable()
class AlbumsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  AlbumsModel(
    this.id,
    this.name,
    this.logo,
  );

  factory AlbumsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumsModelToJson(this);
}
