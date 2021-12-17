import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'peoples_bean.g.dart';

@JsonSerializable()
class PeoplesBean {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<PeoplesModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  PeoplesBean(
    this.list,
    this.meta,
    this.message,
  );

  factory PeoplesBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PeoplesBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeoplesBeanToJson(this);
}

@JsonSerializable()
class PeoplesModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'is_unlock')
  bool? isUnlock;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'province')
  final String? province;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'area')
  final String? area;

  @JsonKey(name: 'country_img')
  final CountryImg? countryImg;

  @JsonKey(name: 'company')
  final CompanyModel? companyModel;

  @JsonKey(name: 'education')
  final Education? education;

  PeoplesModel(
    this.id,
    this.country,
    this.avatar,
    this.position,
    this.email,
    this.name,
    this.mobile,
    this.countryImg,
    this.education,
    this.isCollect,
    this.isUnlock,
    this.intro,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.province,
    this.city,
    this.area,
    this.companyModel,
  );

  factory PeoplesModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PeoplesModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeoplesModelToJson(this);
}

@JsonSerializable()
class CountryImg {
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
class Education {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  Education(
    this.id,
    this.name,
    this.logo,
  );

  factory Education.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}
