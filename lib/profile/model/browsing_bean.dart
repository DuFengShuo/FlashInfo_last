import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'browsing_bean.g.dart';

@JsonSerializable()
class BrowsingBean {
  @JsonKey(name: 'data')
  final List<BrowsingModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  BrowsingBean(
    this.list,
    this.meta,
    this.message,
  );

  factory BrowsingBean.fromJson(Map<String, dynamic> srcJson) =>
      _$BrowsingBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrowsingBeanToJson(this);
}

@JsonSerializable()
class BrowsingModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'model')
  final String? model;

  @JsonKey(name: 'model_id')
  final String? modelId;

  @JsonKey(name: 'model_name')
  final String? modelName;

  @JsonKey(name: 'model_logo')
  final String? modelLogo;

  @JsonKey(name: 'model_intro')
  final String? modelIntro;

  @JsonKey(name: 'created_time')
  final String? createdTime;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'company_legal_representive')
  final String? companyLegalRepresentive;

  @JsonKey(name: 'company_people_number')
  final String? companyPeopleNumber;

  @JsonKey(name: 'company_website')
  final String? companyWebsite;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'product_website')
  final String? productWebsite;

  BrowsingModel(
    this.id,
    this.model,
    this.modelId,
    this.modelName,
    this.modelLogo,
    this.modelIntro,
    this.createdTime,
    this.companyName,
    this.companyLegalRepresentive,
    this.companyPeopleNumber,
    this.companyWebsite,
    this.address,
    this.productWebsite,
  );

  factory BrowsingModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BrowsingModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrowsingModelToJson(this);
}
