import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommend_bean.g.dart';

@JsonSerializable()
class RecommendBean {
  @JsonKey(name: 'company')
  late List<CompanyModel>? companyList;

  @JsonKey(name: 'people')
  late List<PeoplesModel>? personnelList;
  @JsonKey(name: 'product')
  late List<ProductsModel>? productList;

  @JsonKey(name: 'lead')
  late List<CompanyModel>? leadList;

  @JsonKey(name: 'data')
  late List<BrandItemModel>? brandList;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  RecommendBean({
    this.brandList,
    this.companyList,
    this.personnelList,
    this.productList,
    this.leadList,
    this.meta,
    this.message,
  });

  factory RecommendBean.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendBeanToJson(this);
}
