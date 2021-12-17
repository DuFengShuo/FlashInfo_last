import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_bean.g.dart';

@JsonSerializable()
class CompanyBean {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<CompanyModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  CompanyBean({
    this.list,
    this.meta,
    this.message,
  });

  factory CompanyBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyBeanToJson(this);
}

@JsonSerializable()
class CompanyModel {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'tag_id')
  String? tagId;
  @JsonKey(name: 'entity_type')
  final int? entityType;
  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'people_number')
  final String? peopleNumber;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'company_status')
  final String? companyStatus;

  @JsonKey(name: 'extensions')
  final String? extensions;

  @JsonKey(name: 'industry')
  late List<Industry>? industry;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'province')
  final String? province;

  @JsonKey(name: 'founder')
  final String? founder;

  @JsonKey(name: 'fund_of_amount')
  final String? fundOfAmount;

  @JsonKey(name: 'found_date')
  final String? foundDate;

  @JsonKey(name: 'found_time')
  final String? foundTime;

  @JsonKey(name: 'register_date')
  final int? registerDate;

  @JsonKey(name: 'mobile_count')
  final String? mobileCount;

  @JsonKey(name: 'fund_amount')
  final int? fundAmount;

  @JsonKey(name: 'is_website')
  final int? isWebsite;

  @JsonKey(name: 'is_contacts')
  final int? isContacts;

  @JsonKey(name: 'products')
  late List<Product>? products;

  @JsonKey(name: 'is_email')
  final int? isEmail;

  @JsonKey(name: 'operation_status')
  final String? operationStatus;

  @JsonKey(name: 'establish_years')
  final int? establishYears;

  @JsonKey(name: 'employee_count_min')
  final int? employeeCountMin;

  @JsonKey(name: 'employee_count_max')
  final int? employeeCountMax;

  @JsonKey(name: 'people')
  late List<PeoplesModel>? people;

  @JsonKey(name: 'supply_for')
  final String? supplyFor;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'country_img')
  final CountryImg? countryImg;

  CompanyModel(
    this.id,
    this.tagId,
    this.country,
    this.logo,
    this.name,
    this.email,
    this.location,
    this.mobile,
    this.website,
    this.peopleNumber,
    this.intro,
    this.companyStatus,
    this.extensions,
    this.industry,
    this.city,
    this.province,
    this.founder,
    this.fundOfAmount,
    this.foundDate,
    this.foundTime,
    this.registerDate,
    this.mobileCount,
    this.fundAmount,
    this.isWebsite,
    this.isContacts,
    this.products,
    this.isEmail,
    this.operationStatus,
    this.establishYears,
    this.employeeCountMin,
    this.employeeCountMax,
    this.people,
    this.supplyFor,
    this.isCollect,
    this.countryImg,
    this.entityType,
  );

  factory CompanyModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}

@JsonSerializable()
class Industry {
  @JsonKey(name: 'name')
  final String? name;

  Industry({
    this.name,
  });

  factory Industry.fromJson(Map<String, dynamic> srcJson) =>
      _$IndustryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'desc')
  final String? desc;
  Product({
    this.name,
    this.desc,
  });

  factory Product.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
