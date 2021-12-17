// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peoples_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeoplesBean _$PeoplesBeanFromJson(Map<String, dynamic> json) => PeoplesBean(
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => PeoplesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$PeoplesBeanToJson(PeoplesBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.list,
      'meta': instance.meta,
    };

PeoplesModel _$PeoplesModelFromJson(Map<String, dynamic> json) => PeoplesModel(
      json['id'] as String?,
      json['country'] as String?,
      json['avatar'] as String?,
      json['position'] as String?,
      json['email'] as String?,
      json['name'] as String?,
      json['mobile'] as String?,
      json['country_img'] == null
          ? null
          : CountryImg.fromJson(json['country_img'] as Map<String, dynamic>),
      json['education'] == null
          ? null
          : Education.fromJson(json['education'] as Map<String, dynamic>),
      json['is_collect'] as bool?,
      json['is_unlock'] as bool?,
      json['intro'] as String?,
      json['twitter'] as String?,
      json['linkedin'] as String?,
      json['facebook'] as String?,
      json['province'] as String?,
      json['city'] as String?,
      json['area'] as String?,
      json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PeoplesModelToJson(PeoplesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'avatar': instance.avatar,
      'name': instance.name,
      'position': instance.position,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
      'email': instance.email,
      'mobile': instance.mobile,
      'intro': instance.intro,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'province': instance.province,
      'city': instance.city,
      'area': instance.area,
      'country_img': instance.countryImg,
      'company': instance.companyModel,
      'education': instance.education,
    };

CountryImg _$CountryImgFromJson(Map<String, dynamic> json) => CountryImg(
      json['img_type'] as String?,
      json['img_name'] as String?,
    );

Map<String, dynamic> _$CountryImgToJson(CountryImg instance) =>
    <String, dynamic>{
      'img_type': instance.imgType,
      'img_name': instance.imgName,
    };

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      json['id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
