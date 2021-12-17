import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collects_list_beam.g.dart';

@JsonSerializable()
class CollectsListBeam {
  @JsonKey(name: 'company')
  final List<CompanyTagModel>? companyList;

  @JsonKey(name: 'personnel')
  final List<PersonnelTagModel>? personnelList;

  @JsonKey(name: 'product')
  final List<ProductTagModel>? productList;

  @JsonKey(name: 'brand')
  final List<BrandTagModel>? brandList;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  CollectsListBeam(
    this.productList,
    this.companyList,
    this.personnelList,
    this.brandList,
    this.meta,
    this.message,
  );

  factory CollectsListBeam.fromJson(Map<String, dynamic> srcJson) =>
      _$CollectsListBeamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CollectsListBeamToJson(this);
}

@JsonSerializable()
class CompanyTagModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'tag_id')
  final String? tagId;

  @JsonKey(name: 'data_type')
  int dataType;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'detail')
  late CompanyModel? companyModel;

  CompanyTagModel(
    this.id,
    this.tagId,
    this.dataType,
    this.companyModel,
    this.createdAt,
  );

  factory CompanyTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyTagModelToJson(this);
}

@JsonSerializable()
class PersonnelTagModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'tag_id')
  final String? tagId;

  @JsonKey(name: 'data_type')
  int dataType;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'detail')
  final PeoplesModel? peoplesModel;

  PersonnelTagModel(
    this.id,
    this.tagId,
    this.dataType,
    this.peoplesModel,
    this.createdAt,
  );

  factory PersonnelTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonnelTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonnelTagModelToJson(this);
}

@JsonSerializable()
class ProductTagModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'tag_id')
  final String? tagId;

  @JsonKey(name: 'data_type')
  int dataType;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'detail')
  final ProductsModel? productsModel;

  ProductTagModel(
      this.id, this.tagId, this.dataType, this.productsModel, this.createdAt);

  factory ProductTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductTagModelToJson(this);
}

@JsonSerializable()
class BrandTagModel extends Object {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'tag_id')
  final String? tagId;

  @JsonKey(name: 'data_type')
  final int? dataType;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'detail')
  BrandDetail brandDetail;

  BrandTagModel(
    this.id,
    this.tagId,
    this.dataType,
    this.createdAt,
    this.brandDetail,
  );

  factory BrandTagModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandTagModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandTagModelToJson(this);
}

@JsonSerializable()
class BrandDetail extends Object {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'tag_id')
  String? tagId;
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'country_img')
  CountryImg countryImg;

  @JsonKey(name: 'company_status')
  final String? companyStatus;

  @JsonKey(name: 'industry')
  List<Industry> industry;

  @JsonKey(name: 'found_date')
  final String? foundDate;

  @JsonKey(name: 'people_number')
  final String? peopleNumber;

  @JsonKey(name: 'founder')
  final String? founder;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'is_collect')
  bool isCollect;

  @JsonKey(name: 'mobile_count')
  final String? mobileCount;

  @JsonKey(name: 'revenue')
  final String? revenue;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'address')
  final String? address;

  BrandDetail(
    this.id,
    this.tagId,
    this.name,
    this.logo,
    this.country,
    this.countryImg,
    this.companyStatus,
    this.industry,
    this.foundDate,
    this.peopleNumber,
    this.founder,
    this.mobile,
    this.location,
    this.isCollect,
    this.mobileCount,
    this.revenue,
    this.website,
    this.intro,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.email,
    this.address,
  );

  factory BrandDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandDetailToJson(this);
}

@JsonSerializable()
class CountryImg extends Object {
  @JsonKey(name: 'img_type')
  final String? imgType;

  @JsonKey(name: 'img_name')
  final String? imgName;

  CountryImg(
    this.imgType,
    this.imgName,
  );

  factory CountryImg.fromJson(Map<String, dynamic> srcJson) =>
      _$CountryImgFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CountryImgToJson(this);
}

@JsonSerializable()
class Industry extends Object {
  @JsonKey(name: 'name')
  final String? name;

  Industry(
    this.name,
  );

  factory Industry.fromJson(Map<String, dynamic> srcJson) =>
      _$IndustryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}
