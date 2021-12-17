import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_list_bean.g.dart';

@JsonSerializable()
class BrandListBean {
  @JsonKey(name: 'company')
  late List<BrandItemModel>? company;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  BrandListBean(
    this.company,
    this.meta,
    this.message,
  );

  factory BrandListBean.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandListBeanToJson(this);
}

@JsonSerializable()
class BrandItemModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'intro')
  final String? intro;
  @JsonKey(name: 'is_contacts')
  final int? isContacts;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'entity_type')
  final int? entityType;

  @JsonKey(name: 'last_funding_type')
  final String? lastFundingType;

  BrandItemModel(
    this.id,
    this.logo,
    this.name,
    this.intro,
    this.entityType,
    this.isContacts,
    this.lastFundingType,
    this.isCollect,
  );

  factory BrandItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandItemModelToJson(this);
}
