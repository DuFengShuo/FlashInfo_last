import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'honors_bean.g.dart';

@JsonSerializable()
class HonorsBean {
  @JsonKey(name: 'data')
  late List<HonorsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  HonorsBean(
    this.list,
    this.meta,
  );

  factory HonorsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$HonorsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HonorsBeanToJson(this);
}

@JsonSerializable()
class HonorsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'honor_name')
  final String? honorName;

  @JsonKey(name: 'organization_name')
  final String? organizationName;

  @JsonKey(name: 'year')
  final String? year;

  HonorsModel(
    this.id,
    this.honorName,
    this.organizationName,
    this.year,
  );

  factory HonorsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HonorsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HonorsModelToJson(this);
}
