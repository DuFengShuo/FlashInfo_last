import 'package:flashinfo/personal/model/works_bean.dart';
import 'package:json_annotation/json_annotation.dart';

import 'educations_bean.dart';
import 'honors_bean.dart';

part 'personal_details_bean.g.dart';

@JsonSerializable()
class PersonalDetailsBean {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'current_position')
  final String? currentPosition;

  @JsonKey(name: 'is_collect')
  bool? isCollect;
  @JsonKey(name: 'is_unlock')
  bool? isUnlock;

  @JsonKey(name: 'browsing_count')
  final int? browsingCount;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'background_logo')
  final String? backgroundLogo;

  @JsonKey(name: 'details')
  late List<Details>? details;

  @JsonKey(name: 'languages')
  late List<Languages>? languages;

  @JsonKey(name: 'currentCompany')
  late CurrentCompany? currentCompany;

  @JsonKey(name: 'workExperience')
  late WorkExperience? workExperience;

  @JsonKey(name: 'educationExperience')
  late EducationExperience? educationExperience;

  @JsonKey(name: 'achievementExperience')
  late AchievementExperience? achievementExperience;

  @JsonKey(name: 'message')
  final String? message;

  PersonalDetailsBean(
    this.id,
    this.name,
    this.avatar,
    this.intro,
    this.currentPosition,
    this.isCollect,
    this.isUnlock,
    this.browsingCount,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.backgroundLogo,
    this.details,
    this.languages,
    this.currentCompany,
    this.workExperience,
    this.educationExperience,
    this.achievementExperience,
    this.message,
  );

  factory PersonalDetailsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonalDetailsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonalDetailsBeanToJson(this);
}

@JsonSerializable()
class Details {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'img_type')
  final String? imgType;

  @JsonKey(name: 'img_name')
  final String? imgName;

  @JsonKey(name: 'value')
  String? value;

  Details(
    this.title,
    this.imgType,
    this.imgName,
    this.value,
  );

  factory Details.fromJson(Map<String, dynamic> srcJson) =>
      _$DetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Languages {
  @JsonKey(name: 'name')
  final String? name;

  Languages(
    this.name,
  );

  factory Languages.fromJson(Map<String, dynamic> srcJson) =>
      _$LanguagesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LanguagesToJson(this);
}

@JsonSerializable()
class CurrentCompany {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'intro')
  final String? intro;

  CurrentCompany(
    this.id,
    this.name,
    this.logo,
    this.location,
    this.intro,
  );

  factory CurrentCompany.fromJson(Map<String, dynamic> srcJson) =>
      _$CurrentCompanyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CurrentCompanyToJson(this);
}

@JsonSerializable()
class WorkExperience {
  @JsonKey(name: 'data')
  late List<WorksModel>? list;

  WorkExperience(
    this.list,
  );

  factory WorkExperience.fromJson(Map<String, dynamic> srcJson) =>
      _$WorkExperienceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkExperienceToJson(this);
}

@JsonSerializable()
class EducationExperience {
  @JsonKey(name: 'data')
  final List<EducationsModel>? list;

  EducationExperience(
    this.list,
  );

  factory EducationExperience.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationExperienceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationExperienceToJson(this);
}

@JsonSerializable()
class AchievementExperience {
  @JsonKey(name: 'data')
  final List<HonorsModel>? list;

  AchievementExperience(
    this.list,
  );

  factory AchievementExperience.fromJson(Map<String, dynamic> srcJson) =>
      _$AchievementExperienceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AchievementExperienceToJson(this);
}
