// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peoples_new_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeoplesNewBean _$PeoplesNewBeanFromJson(Map<String, dynamic> json) =>
    PeoplesNewBean(
      json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
      json['colleagues'] == null
          ? null
          : Colleagues.fromJson(json['colleagues'] as Map<String, dynamic>),
      (json['education'] as List<dynamic>?)
          ?.map((dynamic e) => Education.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['honors'] as List<dynamic>?)
          ?.map((dynamic e) => Honors.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['skills'] as List<dynamic>?)
          ?.map((dynamic e) => Skills.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['languages'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      json['message'] as String?,
    );

Map<String, dynamic> _$PeoplesNewBeanToJson(PeoplesNewBean instance) =>
    <String, dynamic>{
      'info': instance.info,
      'summary': instance.summary,
      'colleagues': instance.colleagues,
      'education': instance.education,
      'honors': instance.honors,
      'skills': instance.skills,
      'languages': instance.languages,
      'message': instance.message,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['id'] as String?,
      json['avatar'] as String?,
      json['name'] as String?,
      json['tag'] as String?,
      json['twitter'] as String?,
      json['linkedin'] as String?,
      json['facebook'] as String?,
      json['youtube'] as String?,
      json['instagram'] as String?,
      json['github'] as String?,
      (json['position'] as List<dynamic>?)
          ?.map((dynamic e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['intro'] as String?,
      json['is_collect'] as bool?,
      json['is_unlock'] as bool?,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'name': instance.name,
      'tag': instance.tag,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'youtube': instance.youtube,
      'instagram': instance.instagram,
      'github': instance.github,
      'position': instance.position,
      'intro': instance.intro,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      json['position'] as String?,
      json['company_name'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'position': instance.position,
      'company_name': instance.companyName,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
      json['overview'] == null
          ? null
          : Overview.fromJson(json['overview'] as Map<String, dynamic>),
      json['contact_info'] == null
          ? null
          : ContactInfo.fromJson(json['contact_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'overview': instance.overview,
      'contact_info': instance.contactInfo,
    };

Overview _$OverviewFromJson(Map<String, dynamic> json) => Overview(
      json['recent_experience'] == null
          ? null
          : RecentExperience.fromJson(
              json['recent_experience'] as Map<String, dynamic>),
      json['recent_education'] == null
          ? null
          : RecentEducation.fromJson(
              json['recent_education'] as Map<String, dynamic>),
      json['location'] as String?,
    );

Map<String, dynamic> _$OverviewToJson(Overview instance) => <String, dynamic>{
      'recent_experience': instance.recentExperience,
      'recent_education': instance.recentEducation,
      'location': instance.location,
    };

RecentExperience _$RecentExperienceFromJson(Map<String, dynamic> json) =>
    RecentExperience(
      json['company_id'] as String?,
      json['company_name'] as String?,
      json['company_logo'] as String?,
      json['entity_type'] as String?,
    );

Map<String, dynamic> _$RecentExperienceToJson(RecentExperience instance) =>
    <String, dynamic>{
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'entity_type': instance.entityType
    };

RecentEducation _$RecentEducationFromJson(Map<String, dynamic> json) =>
    RecentEducation(
      json['edu_id'] as String?,
      json['edu_name'] as String?,
      json['edu_logo'] as String?,
    );

Map<String, dynamic> _$RecentEducationToJson(RecentEducation instance) =>
    <String, dynamic>{
      'edu_id': instance.eduId,
      'edu_name': instance.eduName,
      'edu_logo': instance.eduLogo,
    };

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      json['mobile'] == null
          ? null
          : Mobile.fromJson(json['mobile'] as Map<String, dynamic>),
      json['email'] == null
          ? null
          : Email.fromJson(json['email'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'email': instance.email,
    };

Mobile _$MobileFromJson(Map<String, dynamic> json) => Mobile(
      json['total'] as int?,
      (json['list'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MobileToJson(Mobile instance) => <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
      json['total'] as int?,
      (json['list'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'total': instance.total,
      'list': instance.list,
    };

Colleagues _$ColleaguesFromJson(Map<String, dynamic> json) => Colleagues(
      json['info'] == null
          ? null
          : InfoModel.fromJson(json['info'] as Map<String, dynamic>),
      (json['list'] as List<dynamic>?)
          ?.map((dynamic e) => ListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$ColleaguesToJson(Colleagues instance) =>
    <String, dynamic>{
      'info': instance.info,
      'list': instance.list,
      'total': instance.total,
    };

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      json['company_id'] as String?,
      json['leave_time'] as int?,
      json['entry_time'] as int?,
      json['company_name'] as String?,
      json['company_logo'] as String?,
      json['entity_type'] as int?,
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'company_id': instance.companyId,
      'leave_time': instance.leaveTime,
      'entry_time': instance.entryTime,
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'entity_type': instance.entryType,
    };

ListModel _$ListModelFromJson(Map<String, dynamic> json) => ListModel(
      json['id'] as String?,
      json['name'] as String?,
      json['avatar'] as String?,
      json['mobile'] as String?,
      json['email'] as String?,
      json['position'] as String?,
      json['is_collect'] as bool?,
      json['is_unlock'] as bool?,
    );

Map<String, dynamic> _$ListModelToJson(ListModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'mobile': instance.mobile,
      'email': instance.email,
      'position': instance.position,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
    };

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      json['edu_name'] as String?,
      json['edu_logo'] as String?,
      json['edu_id'] as String?,
      json['subject'] as String?,
      json['start_date'] as String?,
      json['end_date'] as String?,
      json['desc'] as String?,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'edu_name': instance.eduName,
      'edu_logo': instance.eduLogo,
      'edu_id': instance.eduId,
      'subject': instance.subject,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'desc': instance.desc,
    };

Honors _$HonorsFromJson(Map<String, dynamic> json) => Honors(
      json['id'] as int?,
      json['personnel_id'] as int?,
      json['honor_name'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_at'] as String?,
      json['organization_name'] as String?,
      json['year'] as int?,
      json['desc'] as String?,
    );

Map<String, dynamic> _$HonorsToJson(Honors instance) => <String, dynamic>{
      'id': instance.id,
      'personnel_id': instance.personnelId,
      'honor_name': instance.honorName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'organization_name': instance.organizationName,
      'year': instance.year,
      'desc': instance.desc,
    };

Skills _$SkillsFromJson(Map<String, dynamic> json) => Skills(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SkillsToJson(Skills instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
