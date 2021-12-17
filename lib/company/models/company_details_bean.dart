import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_details_bean.g.dart';

@JsonSerializable()
class CompanyDetailsBean {
  @JsonKey(name: 'info')
  late Info? info;

  @JsonKey(name: 'summary')
  late Summary? summary;

  @JsonKey(name: 'officers')
  late Officers? officers;

  @JsonKey(name: 'branches')
  late Branches? branches;

  @JsonKey(name: 'business')
  late BusinessDatas? business;

  @JsonKey(name: 'reviews')
  late Reviews? reviews;

  @JsonKey(name: 'message')
  final String? message;

  CompanyDetailsBean(
    this.info,
    this.summary,
    this.officers,
    this.branches,
    this.business,
    this.reviews,
    this.message,
  );

  factory CompanyDetailsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyDetailsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyDetailsBeanToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'entity_type')
  final int? entityType;

  @JsonKey(name: 'company_tag')
  final String? companyTag;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'youtube')
  final String? youtube;

  @JsonKey(name: 'instagram')
  final String? instagram;

  Info(
    this.id,
    this.logo,
    this.name,
    this.entityType,
    this.companyTag,
    this.isCollect,
    this.linkedin,
    this.twitter,
    this.facebook,
    this.youtube,
    this.instagram,
  );

  factory Info.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Summary {
  @JsonKey(name: 'registration_info')
  late RegistrationInfo? registrationInfo;

  @JsonKey(name: 'industry_classification')
  late IndustryClassification? industryClassification;

  Summary(
    this.registrationInfo,
    this.industryClassification,
  );

  factory Summary.fromJson(Map<String, dynamic> srcJson) =>
      _$SummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class RegistrationInfo {
  @JsonKey(name: 'identification_number')
  final String? identificationNumber;

  @JsonKey(name: 'incorporation_date')
  final String? incorporationDate;

  @JsonKey(name: 'previous_name')
  late List<String>? previousName;

  @JsonKey(name: 'operation_status')
  final String? operationStatus;

  @JsonKey(name: 'nonprofit')
  final String? nonprofit;

  @JsonKey(name: 'company_type')
  final String? companyType;

  @JsonKey(name: 'jurisdiction')
  final String? jurisdiction;

  @JsonKey(name: 'branch')
  late Branch? branch;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'address')
  final String? address;

  RegistrationInfo(
    this.identificationNumber,
    this.incorporationDate,
    this.previousName,
    this.operationStatus,
    this.nonprofit,
    this.companyType,
    this.jurisdiction,
    this.branch,
    this.phoneNumber,
    this.email,
    this.website,
    this.address,
  );

  factory RegistrationInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$RegistrationInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RegistrationInfoToJson(this);
}

@JsonSerializable()
class Branch {
  @JsonKey(name: 'nums')
  final int? nums;

  @JsonKey(name: 'country')
  final String? country;

  Branch(
    this.nums,
    this.country,
  );

  factory Branch.fromJson(Map<String, dynamic> srcJson) =>
      _$BranchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable()
class IndustryClassification {
  @JsonKey(name: 'offical_industry')
  final String? officalIndustry;

  @JsonKey(name: 'sic_code')
  late List<dynamic>? sicCode;

  @JsonKey(name: 'naics_code')
  late List<dynamic>? naicsCode;

  IndustryClassification(
    this.officalIndustry,
    this.sicCode,
    this.naicsCode,
  );

  factory IndustryClassification.fromJson(Map<String, dynamic> srcJson) =>
      _$IndustryClassificationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndustryClassificationToJson(this);
}

@JsonSerializable()
class Officers {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<OfficersModel>? data;

  Officers(
    this.total,
    this.data,
  );

  factory Officers.fromJson(Map<String, dynamic> srcJson) =>
      _$OfficersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficersToJson(this);
}

@JsonSerializable()
class OfficersModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'update_date')
  final String? updateDate;

  @JsonKey(name: 'occupation')
  final String? occupation;

  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  @JsonKey(name: 'nationality')
  final String? nationality;

  @JsonKey(name: 'country_of_residence')
  final String? countryOfResidence;

  @JsonKey(name: 'jurisdiction')
  final String? jurisdiction;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'personnel_id')
  final String? personnelId;

  OfficersModel(
    this.id,
    this.companyId,
    this.name,
    this.type,
    this.position,
    this.startDate,
    this.endDate,
    this.updateDate,
    this.occupation,
    this.dateOfBirth,
    this.nationality,
    this.countryOfResidence,
    this.jurisdiction,
    this.address,
    this.personnelId,
  );

  factory OfficersModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OfficersModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OfficersModelToJson(this);
}

@JsonSerializable()
class Branches {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<BranchesModel>? data;

  Branches(
    this.total,
    this.data,
  );

  factory Branches.fromJson(Map<String, dynamic> srcJson) =>
      _$BranchesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BranchesToJson(this);
}

@JsonSerializable()
class BranchesModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'province')
  final String? province;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'company_status')
  final String? companyStatus;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'sn')
  final int? sn;

  BranchesModel(
    this.id,
    this.name,
    this.country,
    this.province,
    this.city,
    this.companyStatus,
    this.location,
    this.sn,
  );

  factory BranchesModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BranchesModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BranchesModelToJson(this);
}

@JsonSerializable()
class BusinessDatas {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<BusinessModel>? data;

  BusinessDatas(
    this.total,
    this.data,
  );

  factory BusinessDatas.fromJson(Map<String, dynamic> srcJson) =>
      _$BusinessDatasFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BusinessDatasToJson(this);
}

@JsonSerializable()
class BusinessModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'tags')
  late List<String>? tags;

  BusinessModel(
    this.id,
    this.name,
    this.logo,
    this.intro,
    this.tags,
  );

  factory BusinessModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BusinessModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BusinessModelToJson(this);
}

@JsonSerializable()
class Reviews {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<ReviewsModel>? data;
  @JsonKey(name: 'meta')
  late MetaModel? meta;
  Reviews(
    this.total,
    this.data,
    this.meta,
  );

  factory Reviews.fromJson(Map<String, dynamic> srcJson) =>
      _$ReviewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}

@JsonSerializable()
class ReviewsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'company_relationship')
  final int? companyRelationship;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'comments')
  final String? comments;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'wtripartite')
  final int? wtripartite;

  @JsonKey(name: 'user')
  late User? user;

  @JsonKey(name: 'creation_time')
  final String? creationTime;

  ReviewsModel(
    this.id,
    this.type,
    this.userId,
    this.companyRelationship,
    this.position,
    this.title,
    this.comments,
    this.createdAt,
    this.wtripartite,
    this.user,
    this.creationTime,
  );

  factory ReviewsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ReviewsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReviewsModelToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'user_avatar')
  final String? userAvatar;

  @JsonKey(name: 'user_name')
  final String? userName;

  User(
    this.userAvatar,
    this.userName,
  );

  factory User.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
