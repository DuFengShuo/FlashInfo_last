// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDetailsBean _$PersonalDetailsBeanFromJson(Map<String, dynamic> json) {
  return PersonalDetailsBean(
    json['id'] as String?,
    json['name'] as String?,
    json['avatar'] as String?,
    json['intro'] as String?,
    json['current_position'] as String?,
    json['is_collect'] as bool?,
    json['is_unlock'] as bool?,
    json['browsing_count'] as int?,
    json['twitter'] as String?,
    json['linkedin'] as String?,
    json['facebook'] as String?,
    json['background_logo'] as String?,
    (json['details'] as List<dynamic>?)
        ?.map((dynamic e) => Details.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['languages'] as List<dynamic>?)
        ?.map((dynamic e) => Languages.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['currentCompany'] == null
        ? null
        : CurrentCompany.fromJson(
            json['currentCompany'] as Map<String, dynamic>),
    json['workExperience'] == null
        ? null
        : WorkExperience.fromJson(
            json['workExperience'] as Map<String, dynamic>),
    json['educationExperience'] == null
        ? null
        : EducationExperience.fromJson(
            json['educationExperience'] as Map<String, dynamic>),
    json['achievementExperience'] == null
        ? null
        : AchievementExperience.fromJson(
            json['achievementExperience'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$PersonalDetailsBeanToJson(
        PersonalDetailsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'intro': instance.intro,
      'avatar': instance.avatar,
      'current_position': instance.currentPosition,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
      'browsing_count': instance.browsingCount,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'background_logo': instance.backgroundLogo,
      'details': instance.details,
      'languages': instance.languages,
      'currentCompany': instance.currentCompany,
      'workExperience': instance.workExperience,
      'educationExperience': instance.educationExperience,
      'achievementExperience': instance.achievementExperience,
      'message': instance.message,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details(
    json['title'] as String?,
    json['img_type'] as String?,
    json['img_name'] as String?,
    json['value'] as String?,
  );
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'title': instance.title,
      'img_type': instance.imgType,
      'img_name': instance.imgName,
      'value': instance.value,
    };

Languages _$LanguagesFromJson(Map<String, dynamic> json) {
  return Languages(
    json['name'] as String?,
  );
}

Map<String, dynamic> _$LanguagesToJson(Languages instance) => <String, dynamic>{
      'name': instance.name,
    };

CurrentCompany _$CurrentCompanyFromJson(Map<String, dynamic> json) {
  return CurrentCompany(
    json['id'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    json['location'] as String?,
    json['intro'] as String?,
  );
}

Map<String, dynamic> _$CurrentCompanyToJson(CurrentCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'location': instance.location,
      'intro': instance.intro,
    };

WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) {
  return WorkExperience(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => WorksModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WorkExperienceToJson(WorkExperience instance) =>
    <String, dynamic>{
      'data': instance.list,
    };

EducationExperience _$EducationExperienceFromJson(Map<String, dynamic> json) {
  return EducationExperience(
    (json['data'] as List<dynamic>?)
        ?.map(
            (dynamic e) => EducationsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EducationExperienceToJson(
        EducationExperience instance) =>
    <String, dynamic>{
      'data': instance.list,
    };

AchievementExperience _$AchievementExperienceFromJson(
    Map<String, dynamic> json) {
  return AchievementExperience(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => HonorsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AchievementExperienceToJson(
        AchievementExperience instance) =>
    <String, dynamic>{
      'data': instance.list,
    };
