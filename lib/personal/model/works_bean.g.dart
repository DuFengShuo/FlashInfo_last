// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'works_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorksBean _$WorksBeanFromJson(Map<String, dynamic> json) {
  return WorksBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => WorksModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WorksBeanToJson(WorksBean instance) => <String, dynamic>{
      'data': instance.worksList,
      'meta': instance.meta,
    };

WorksModel _$WorksModelFromJson(Map<String, dynamic> json) {
  return WorksModel(
    json['id'] as String?,
    json['company_id'] as String?,
    json['company_name'] as String?,
    json['company_logo'] as String?,
    json['position'] as String?,
    json['entry_time'] as String?,
    json['leave_time'] as String?,
    json['total_time'] as String?,
  );
}

Map<String, dynamic> _$WorksModelToJson(WorksModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'position': instance.position,
      'entry_time': instance.entryTime,
      'leave_time': instance.leaveTime,
      'total_time': instance.totalTime,
    };

PeopleAchievementBean _$PeopleAchievementBeanFromJson(
    Map<String, dynamic> json) {
  return PeopleAchievementBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            PeopleAchievementModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PeopleAchievementBeanToJson(
        PeopleAchievementBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

PeopleAchievementModel _$PeopleAchievementModelFromJson(
    Map<String, dynamic> json) {
  return PeopleAchievementModel(
    json['id'] as String,
    json['honor_name'] as String,
    json['organization_name'] as String,
    json['year'] as String,
  );
}

Map<String, dynamic> _$PeopleAchievementModelToJson(
        PeopleAchievementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'honor_name': instance.honorName,
      'organization_name': instance.organizationName,
      'year': instance.year,
    };

PeopleEducationsBean _$PeopleEducationsBeanFromJson(Map<String, dynamic> json) {
  return PeopleEducationsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            PeopleEducationsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PeopleEducationsBeanToJson(
        PeopleEducationsBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.meta,
    };

PeopleEducationsModel _$PeopleEducationsModelFromJson(
    Map<String, dynamic> json) {
  return PeopleEducationsModel(
    json['id'] as String?,
    json['edu_id'] as String?,
    json['edu_name'] as String?,
    json['edu_logo'] as String?,
    json['subject'] as String?,
    json['start_year'] as String?,
    json['end_year'] as String?,
  );
}

Map<String, dynamic> _$PeopleEducationsModelToJson(
        PeopleEducationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'edu_id': instance.eduId,
      'edu_name': instance.eduName,
      'edu_logo': instance.eduLogo,
      'subject': instance.subject,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
    };
