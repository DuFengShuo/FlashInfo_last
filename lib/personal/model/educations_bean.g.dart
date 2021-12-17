// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'educations_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationsBean _$EducationsBeanFromJson(Map<String, dynamic> json) {
  return EducationsBean(
    (json['data'] as List<dynamic>?)
        ?.map(
            (dynamic e) => EducationsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EducationsBeanToJson(EducationsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
    };

EducationsModel _$EducationsModelFromJson(Map<String, dynamic> json) {
  return EducationsModel(
    json['id'] as String?,
    json['edu_id'] as String?,
    json['edu_name'] as String?,
    json['edu_logo'] as String?,
    json['subject'] as String?,
    json['start_year'] as String?,
    json['end_year'] as String?,
  );
}

Map<String, dynamic> _$EducationsModelToJson(EducationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'edu_id': instance.eduId,
      'edu_name': instance.eduName,
      'edu_logo': instance.eduLogo,
      'subject': instance.subject,
      'start_year': instance.startYear,
      'end_year': instance.endYear,
    };
