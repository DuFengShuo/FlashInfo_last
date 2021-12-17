import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'educations_bean.g.dart';

@JsonSerializable()
class EducationsBean {
  @JsonKey(name: 'data')
  late List<EducationsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  EducationsBean(
    this.list,
    this.meta,
  );

  factory EducationsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationsBeanToJson(this);
}

@JsonSerializable()
class EducationsModel {
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

  EducationsModel(
    this.id,
    this.eduId,
    this.eduName,
    this.eduLogo,
    this.subject,
    this.startYear,
    this.endYear,
  );

  factory EducationsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationsModelToJson(this);
}
