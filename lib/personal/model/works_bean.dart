import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'works_bean.g.dart';

@JsonSerializable()
class WorksBean {
  @JsonKey(name: 'data')
  final List<WorksModel>? worksList;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  WorksBean(
    this.worksList,
    this.meta,
  );

  factory WorksBean.fromJson(Map<String, dynamic> srcJson) =>
      _$WorksBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorksBeanToJson(this);
}

@JsonSerializable()
class WorksModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'company_name')
  final String? companyName;

  @JsonKey(name: 'company_logo')
  final String? companyLogo;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'entry_time')
  final String? entryTime;

  @JsonKey(name: 'leave_time')
  final String? leaveTime;

  @JsonKey(name: 'total_time')
  final String? totalTime;

  WorksModel(
    this.id,
    this.companyId,
    this.companyName,
    this.companyLogo,
    this.position,
    this.entryTime,
    this.leaveTime,
    this.totalTime,
  );

  factory WorksModel.fromJson(Map<String, dynamic> srcJson) =>
      _$WorksModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorksModelToJson(this);
}

@JsonSerializable()
class PeopleAchievementBean {
  @JsonKey(name: 'data')
  final List<PeopleAchievementModel>? data;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  PeopleAchievementBean(
    this.data,
    this.meta,
  );

  factory PeopleAchievementBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleAchievementBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleAchievementBeanToJson(this);
}

@JsonSerializable()
class PeopleAchievementModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'honor_name')
  String honorName;

  @JsonKey(name: 'organization_name')
  String organizationName;

  @JsonKey(name: 'year')
  String year;

  PeopleAchievementModel(
    this.id,
    this.honorName,
    this.organizationName,
    this.year,
  );

  factory PeopleAchievementModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleAchievementModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleAchievementModelToJson(this);
}

@JsonSerializable()
class PeopleEducationsBean {
  @JsonKey(name: 'data')
  final List<PeopleEducationsModel>? data;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  PeopleEducationsBean(
    this.data,
    this.meta,
  );

  factory PeopleEducationsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleEducationsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleEducationsBeanToJson(this);
}

@JsonSerializable()
class PeopleEducationsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'edu_id')
  final String? eduId;

  @JsonKey(name: 'edu_name')
  final String? eduName;

  @JsonKey(name: 'edu_logo')
  final String? eduLogo;

  @JsonKey(name: 'subject')
  final String? subject;

  @JsonKey(name: 'start_year')
  final String? startYear;

  @JsonKey(name: 'end_year')
  final String? endYear;

  PeopleEducationsModel(
    this.id,
    this.eduId,
    this.eduName,
    this.eduLogo,
    this.subject,
    this.startYear,
    this.endYear,
  );

  factory PeopleEducationsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PeopleEducationsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PeopleEducationsModelToJson(this);
}
