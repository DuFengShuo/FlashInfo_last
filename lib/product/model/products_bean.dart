import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_bean.g.dart';

@JsonSerializable()
class ProductsBean {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<ProductsModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  ProductsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory ProductsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsBeanToJson(this);
}

@JsonSerializable()
class ProductsModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'tag_id')
  String? tagId;
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'desc')
  final String? desc;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'category')
  final List<Category>? category;

  @JsonKey(name: 'company')
  final CompanyModel? companyModel;

  ProductsModel(
    this.id,
    this.name,
    this.logo,
    this.desc,
    this.isCollect,
    this.category,
    this.companyModel,
    this.tagId,
  );

  factory ProductsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  Category(
    this.id,
    this.name,
  );

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
