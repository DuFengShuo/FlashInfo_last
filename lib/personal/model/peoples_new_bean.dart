import 'package:json_annotation/json_annotation.dart';

part 'peoples_new_bean.g.dart';

@JsonSerializable()
class PeoplesNewBean {
  @JsonKey(name: 'info')
  late Info? info;

  @JsonKey(name: 'summary')
  late Summary? summary;

  @JsonKey(name: 'colleagues')
  late Colleagues? colleagues;

  @JsonKey(name: 'education')
  late List<Education>? education;

  @JsonKey(name: 'honors')
  late List<Honors>? honors;

  @JsonKey(name: 'skills')
  late List<Skills>? skills;

  @JsonKey(name: 'languages')
  late List<String>? languages;

  @JsonKey(name: 'message')
  final String? message;

  PeoplesNewBean(
    this.info,
    this.summary,
    this.colleagues,
    this.education,
    this.honors,
    this.skills,
    this.languages,
    this.message,
  );

  factory PeoplesNewBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PeoplesNewBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeoplesNewBeanToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'tag')
  final String? tag;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'youtube')
  final String? youtube;

  @JsonKey(name: 'instagram')
  final String? instagram;

  @JsonKey(name: 'github')
  final String? github;

  @JsonKey(name: 'position')
  late List<Position>? position;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'is_collect')
  final bool? isCollect;

  @JsonKey(name: 'is_unlock')
  final bool? isUnlock;

  Info(
    this.id,
    this.avatar,
    this.name,
    this.tag,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.youtube,
    this.instagram,
    this.github,
    this.position,
    this.intro,
    this.isCollect,
    this.isUnlock,
  );

  factory Info.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Position {
  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'company_name')
  final String? companyName;

  Position(
    this.position,
    this.companyName,
  );

  factory Position.fromJson(Map<String, dynamic> srcJson) =>
      _$PositionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

@JsonSerializable()
class Summary {
  @JsonKey(name: 'overview')
  late Overview? overview;

  @JsonKey(name: 'contact_info')
  late ContactInfo? contactInfo;

  Summary(
    this.overview,
    this.contactInfo,
  );

  factory Summary.fromJson(Map<String, dynamic> srcJson) =>
      _$SummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class Overview {
  @JsonKey(name: 'recent_experience')
  late RecentExperience? recentExperience;

  @JsonKey(name: 'recent_education')
  late RecentEducation? recentEducation;

  @JsonKey(name: 'location')
  final String? location;

  Overview(
    this.recentExperience,
    this.recentEducation,
    this.location,
  );

  factory Overview.fromJson(Map<String, dynamic> srcJson) =>
      _$OverviewFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OverviewToJson(this);
}

@JsonSerializable()
class RecentExperience {
  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'company_logo')
  final String? companyLogo;

  @JsonKey(name: 'entity_type')
  final String? entityType;

  RecentExperience(
    this.companyId,
    this.companyName,
    this.companyLogo,
      this.entityType
  );

  factory RecentExperience.fromJson(Map<String, dynamic> srcJson) =>
      _$RecentExperienceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecentExperienceToJson(this);
}

@JsonSerializable()
class RecentEducation {
  @JsonKey(name: 'edu_id')
  final String? eduId;

  @JsonKey(name: 'edu_name')
  final String? eduName;

  @JsonKey(name: 'edu_logo')
  final String? eduLogo;

  RecentEducation(
    this.eduId,
    this.eduName,
    this.eduLogo,
  );

  factory RecentEducation.fromJson(Map<String, dynamic> srcJson) =>
      _$RecentEducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecentEducationToJson(this);
}

@JsonSerializable()
class ContactInfo {
  @JsonKey(name: 'mobile')
  late Mobile? mobile;

  @JsonKey(name: 'email')
  late Email? email;

  ContactInfo(
    this.mobile,
    this.email,
  );

  factory ContactInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ContactInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}

@JsonSerializable()
class Mobile {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'list')
  late List<String>? list;

  Mobile(
    this.total,
    this.list,
  );

  factory Mobile.fromJson(Map<String, dynamic> srcJson) =>
      _$MobileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MobileToJson(this);
}

@JsonSerializable()
class Email {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'list')
  late List<String>? list;

  Email(
    this.total,
    this.list,
  );

  factory Email.fromJson(Map<String, dynamic> srcJson) =>
      _$EmailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}

@JsonSerializable()
class Colleagues {
  @JsonKey(name: 'info')
  late InfoModel? info;

  @JsonKey(name: 'list')
  late List<ListModel>? list;

  @JsonKey(name: 'total')
  final int? total;

  Colleagues(
    this.info,
    this.list,
    this.total,
  );

  factory Colleagues.fromJson(Map<String, dynamic> srcJson) =>
      _$ColleaguesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColleaguesToJson(this);
}

@JsonSerializable()
class InfoModel {
  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'leave_time')
  final int? leaveTime;

  @JsonKey(name: 'entry_time')
  final int? entryTime;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'company_logo')
  final String? companyLogo;

  @JsonKey(name: 'entity_type')
  final int? entryType;

  InfoModel(
    this.companyId,
    this.leaveTime,
    this.entryTime,
    this.companyName, this.companyLogo, this.entryType,
  );

  factory InfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}

@JsonSerializable()
class ListModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'is_collect')
  final bool? isCollect;

  @JsonKey(name: 'is_unlock')
  final bool? isUnlock;

  ListModel(
    this.id,
    this.name,
    this.avatar,
    this.mobile,
    this.email,
    this.position,
    this.isCollect,
    this.isUnlock,
  );

  factory ListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}

@JsonSerializable()
class Education {
  @JsonKey(name: 'edu_name')
  final String? eduName;

  @JsonKey(name: 'edu_logo')
  final String? eduLogo;

  @JsonKey(name: 'edu_id')
  final String? eduId;

  @JsonKey(name: 'subject')
  final String? subject;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'desc')
  final String? desc;

  Education(
    this.eduName,
    this.eduLogo,
    this.eduId,
    this.subject,
    this.startDate,
    this.endDate,
    this.desc,
  );

  factory Education.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class Honors {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'personnel_id')
  final int? personnelId;

  @JsonKey(name: 'honor_name')
  final String? honorName;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  @JsonKey(name: 'organization_name')
  final String? organizationName;

  @JsonKey(name: 'year')
  final int? year;

  @JsonKey(name: 'desc')
  final String? desc;

  Honors(
    this.id,
    this.personnelId,
    this.honorName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.organizationName,
    this.year,
    this.desc,
  );

  factory Honors.fromJson(Map<String, dynamic> srcJson) =>
      _$HonorsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HonorsToJson(this);
}

@JsonSerializable()
class Skills {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  Skills(
    this.id,
    this.name,
  );

  factory Skills.fromJson(Map<String, dynamic> srcJson) =>
      _$SkillsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SkillsToJson(this);
}
