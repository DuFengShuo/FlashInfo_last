// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_details_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetailsBean _$CompanyDetailsBeanFromJson(Map<String, dynamic> json) =>
    CompanyDetailsBean(
      json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
      json['officers'] == null
          ? null
          : Officers.fromJson(json['officers'] as Map<String, dynamic>),
      json['branches'] == null
          ? null
          : Branches.fromJson(json['branches'] as Map<String, dynamic>),
      json['business'] == null
          ? null
          : BusinessDatas.fromJson(json['business'] as Map<String, dynamic>),
      json['reviews'] == null
          ? null
          : Reviews.fromJson(json['reviews'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$CompanyDetailsBeanToJson(CompanyDetailsBean instance) =>
    <String, dynamic>{
      'info': instance.info,
      'summary': instance.summary,
      'officers': instance.officers,
      'branches': instance.branches,
      'business': instance.business,
      'reviews': instance.reviews,
      'message': instance.message,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['id'] as String?,
      json['logo'] as String?,
      json['name'] as String?,
      json['entity_type'] as int?,
      json['company_tag'] as String?,
      json['is_collect'] as bool?,
      json['linkedin'] as String?,
      json['twitter'] as String?,
      json['facebook'] as String?,
      json['youtube'] as String?,
      json['instagram'] as String?,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'entity_type': instance.entityType,
      'company_tag': instance.companyTag,
      'is_collect': instance.isCollect,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'facebook': instance.facebook,
      'youtube': instance.youtube,
      'instagram': instance.instagram,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
      json['registration_info'] == null
          ? null
          : RegistrationInfo.fromJson(
              json['registration_info'] as Map<String, dynamic>),
      json['industry_classification'] == null
          ? null
          : IndustryClassification.fromJson(
              json['industry_classification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'registration_info': instance.registrationInfo,
      'industry_classification': instance.industryClassification,
    };

RegistrationInfo _$RegistrationInfoFromJson(Map<String, dynamic> json) =>
    RegistrationInfo(
      json['identification_number'] as String?,
      json['incorporation_date'] as String?,
      (json['previous_name'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      json['operation_status'] as String?,
      json['nonprofit'] as String?,
      json['company_type'] as String?,
      json['jurisdiction'] as String?,
      json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      json['phone_number'] as String?,
      json['email'] as String?,
      json['website'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$RegistrationInfoToJson(RegistrationInfo instance) =>
    <String, dynamic>{
      'identification_number': instance.identificationNumber,
      'incorporation_date': instance.incorporationDate,
      'previous_name': instance.previousName,
      'operation_status': instance.operationStatus,
      'nonprofit': instance.nonprofit,
      'company_type': instance.companyType,
      'jurisdiction': instance.jurisdiction,
      'branch': instance.branch,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'website': instance.website,
      'address': instance.address,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      json['nums'] as int?,
      json['country'] as String?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'nums': instance.nums,
      'country': instance.country,
    };

IndustryClassification _$IndustryClassificationFromJson(
        Map<String, dynamic> json) =>
    IndustryClassification(
      json['offical_industry'] as String?,
      json['sic_code'] as List<dynamic>?,
      json['naics_code'] as List<dynamic>?,
    );

Map<String, dynamic> _$IndustryClassificationToJson(
        IndustryClassification instance) =>
    <String, dynamic>{
      'offical_industry': instance.officalIndustry,
      'sic_code': instance.sicCode,
      'naics_code': instance.naicsCode,
    };

Officers _$OfficersFromJson(Map<String, dynamic> json) => Officers(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => OfficersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfficersToJson(Officers instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.data,
    };

OfficersModel _$OfficersModelFromJson(Map<String, dynamic> json) =>
    OfficersModel(
      json['id'] as String?,
      json['company_id'] as String?,
      json['name'] as String?,
      json['type'] as String?,
      json['position'] as String?,
      json['start_date'] as String?,
      json['end_date'] as String?,
      json['update_date'] as String?,
      json['occupation'] as String?,
      json['date_of_birth'] as String?,
      json['nationality'] as String?,
      json['country_of_residence'] as String?,
      json['jurisdiction'] as String?,
      json['address'] as String?,
      json['personnel_id'] as String?,
    );

Map<String, dynamic> _$OfficersModelToJson(OfficersModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'name': instance.name,
      'type': instance.type,
      'position': instance.position,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'update_date': instance.updateDate,
      'occupation': instance.occupation,
      'date_of_birth': instance.dateOfBirth,
      'nationality': instance.nationality,
      'country_of_residence': instance.countryOfResidence,
      'jurisdiction': instance.jurisdiction,
      'address': instance.address,
      'personnel_id': instance.personnelId,
    };

Branches _$BranchesFromJson(Map<String, dynamic> json) => Branches(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => BranchesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchesToJson(Branches instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.data,
    };

BranchesModel _$BranchesModelFromJson(Map<String, dynamic> json) =>
    BranchesModel(
      json['id'] as String?,
      json['name'] as String?,
      json['country'] as String?,
      json['province'] as String?,
      json['city'] as String?,
      json['company_status'] as String?,
      json['location'] as String?,
      json['sn'] as int?,
    );

Map<String, dynamic> _$BranchesModelToJson(BranchesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'company_status': instance.companyStatus,
      'location': instance.location,
      'sn': instance.sn,
    };

BusinessDatas _$BusinessDatasFromJson(Map<String, dynamic> json) =>
    BusinessDatas(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => BusinessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BusinessDatasToJson(BusinessDatas instance) =>
    <String, dynamic>{
      'total': instance.total,
      'data': instance.data,
    };

BusinessModel _$BusinessModelFromJson(Map<String, dynamic> json) =>
    BusinessModel(
      json['id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
      json['intro'] as String?,
      (json['tags'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BusinessModelToJson(BusinessModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'intro': instance.intro,
      'tags': instance.tags,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => ReviewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.data,
      'meta': instance.meta,
    };

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) => ReviewsModel(
      json['id'] as String?,
      json['type'] as int?,
      json['user_id'] as int?,
      json['company_relationship'] as int?,
      json['position'] as String?,
      json['title'] as String?,
      json['comments'] as String?,
      json['created_at'] as String?,
      json['wtripartite'] as int?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['creation_time'] as String?,
    );

Map<String, dynamic> _$ReviewsModelToJson(ReviewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'user_id': instance.userId,
      'company_relationship': instance.companyRelationship,
      'position': instance.position,
      'title': instance.title,
      'comments': instance.comments,
      'created_at': instance.createdAt,
      'wtripartite': instance.wtripartite,
      'user': instance.user,
      'creation_time': instance.creationTime,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['user_avatar'] as String?,
      json['user_name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_avatar': instance.userAvatar,
      'user_name': instance.userName,
    };
