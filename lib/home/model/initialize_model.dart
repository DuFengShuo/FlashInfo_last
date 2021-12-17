import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/login/model/area_code_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'initialize_model.g.dart';

@JsonSerializable()
class InitializeModel {
  @JsonKey(name: 'data')
  final String? updateTime;

  @JsonKey(name: 'hotWords')
  late List<String>? hotWords;

  @JsonKey(name: 'icon')
  late IconModel? icon;

  @JsonKey(name: 'search')
  late SearchModel? search;

  @JsonKey(name: 'news')
  late NewsBean? newsbean;

  InitializeModel(
    this.updateTime,
    this.hotWords,
    this.icon,
    this.search,
    this.newsbean,
  );

  factory InitializeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$InitializeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InitializeModelToJson(this);
}

@JsonSerializable()
class IconModel {
  @JsonKey(name: 'nationalFlag')
  late Map<String, String>? nationalFlag;

  @JsonKey(name: 'flagicon')
  late List<AreaCodeModel>? flagicon;

  @JsonKey(name: 'education')
  final Education? education;

  @JsonKey(name: 'details')
  late Map<String, String>? details;

  IconModel(
    this.nationalFlag,
    this.education,
    this.flagicon,
    this.details,
  );

  factory IconModel.fromJson(Map<String, dynamic> srcJson) =>
      _$IconModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IconModelToJson(this);
}

// @JsonSerializable()
// class NationalFlag {
//   @JsonKey(name: 'in')
//   final String? ins;

//   @JsonKey(name: 'id')
//   final String? id;

//   @JsonKey(name: 'sg')
//   final String? sg;

//   @JsonKey(name: 'ph')
//   final String? ph;

//   @JsonKey(name: 'my')
//   final String? my;

//   @JsonKey(name: 'th')
//   final String? th;

//   @JsonKey(name: 'vn')
//   final String? vn;

//   @JsonKey(name: 'default')
//   final String? defaults;

//   NationalFlag(
//     this.ins,
//     this.id,
//     this.sg,
//     this.ph,
//     this.my,
//     this.th,
//     this.vn,
//     this.defaults,
//   );

//   factory NationalFlag.fromJson(Map<String, dynamic> srcJson) =>
//       _$NationalFlagFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$NationalFlagToJson(this);
// }

@JsonSerializable()
class Education {
  @JsonKey(name: 'default')
  final String? defaults;

  Education(
    this.defaults,
  );

  factory Education.fromJson(Map<String, dynamic> srcJson) =>
      _$EducationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class IconDetailsModel {
  @JsonKey(name: 'industry')
  final String? industry;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'operatingStatus')
  final String? operatingStatus;

  @JsonKey(name: 'foundedDate')
  final String? foundedDate;

  @JsonKey(name: 'revenue')
  final String? revenue;

  @JsonKey(name: 'numOfPeople')
  final String? numOfPeople;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'hq')
  final String? hq;

  @JsonKey(name: 'work')
  final String? work;

  @JsonKey(name: 'registerNumber')
  final String? registerNumber;

  @JsonKey(name: 'cinNumber')
  final String? cinNumber;

  @JsonKey(name: 'companyContact')
  final String? companyContact;

  @JsonKey(name: 'branches')
  final String? branches;

  @JsonKey(name: 'companyType')
  final String? companyType;

  IconDetailsModel(
    this.industry,
    this.phone,
    this.email,
    this.operatingStatus,
    this.foundedDate,
    this.revenue,
    this.numOfPeople,
    this.website,
    this.hq,
    this.work,
    this.registerNumber,
    this.cinNumber,
    this.companyContact,
    this.branches,
    this.companyType,
  );

  factory IconDetailsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$IconDetailsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IconDetailsModelToJson(this);
}

@JsonSerializable()
class SearchModel {
  @JsonKey(name: 'country')
  late List<String>? country;

  @JsonKey(name: 'industry')
  late List<Industry>? industry;

  @JsonKey(name: 'fund_amount')
  late List<FundAmount>? fundAmount;

  SearchModel(
    this.country,
    this.industry,
    this.fundAmount,
  );

  factory SearchModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}

@JsonSerializable()
class Industry {
  @JsonKey(name: 'name')
  final String? name;

  Industry(
    this.name,
  );

  factory Industry.fromJson(Map<String, dynamic> srcJson) =>
      _$IndustryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}

@JsonSerializable()
class FundAmount {
  @JsonKey(name: 'revenue_min')
  final int? revenueMin;

  @JsonKey(name: 'revenue_max')
  final int? revenueMax;

  FundAmount(
    this.revenueMin,
    this.revenueMax,
  );

  factory FundAmount.fromJson(Map<String, dynamic> srcJson) =>
      _$FundAmountFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FundAmountToJson(this);
}

@JsonSerializable()
class HotWordsModel {
  @JsonKey(name: 'hot_words')
  late List<HotWordsItemModel>? hotWords;

  @JsonKey(name: 'message')
  final String? message;

  HotWordsModel(
    this.hotWords,
    this.message,
  );

  factory HotWordsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HotWordsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWordsModelToJson(this);
}

@JsonSerializable()
class HotWordsItemModel {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'type')
  final String? type;

  HotWordsItemModel(
    this.name,
    this.type,
  );

  factory HotWordsItemModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HotWordsItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotWordsItemModelToJson(this);
}
