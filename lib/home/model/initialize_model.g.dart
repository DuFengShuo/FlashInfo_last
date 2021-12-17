// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialize_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitializeModel _$InitializeModelFromJson(Map<String, dynamic> json) {
  return InitializeModel(
    json['data'] as String?,
    (json['hotWords'] as List<dynamic>?)
        ?.map((dynamic e) => e as String)
        .toList(),
    json['icon'] == null
        ? null
        : IconModel.fromJson(json['icon'] as Map<String, dynamic>),
    json['search'] == null
        ? null
        : SearchModel.fromJson(json['search'] as Map<String, dynamic>),
    json['news'] == null
        ? null
        : NewsBean.fromJson(json['news'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InitializeModelToJson(InitializeModel instance) =>
    <String, dynamic>{
      'data': instance.updateTime,
      'hotWords': instance.hotWords,
      'icon': instance.icon,
      'search': instance.search,
      'news': instance.newsbean,
    };

IconModel _$IconModelFromJson(Map<String, dynamic> json) {
  return IconModel(
    (json['nationalFlag'] as Map<String, dynamic>?)?.map(
      (k, dynamic e) => MapEntry(k, e as String),
    ),
    json['education'] == null
        ? null
        : Education.fromJson(json['education'] as Map<String, dynamic>),
    (json['flagicon'] as List<dynamic>?)
        ?.map((dynamic e) => AreaCodeModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['details'] as Map<String, dynamic>?)?.map(
      (k, dynamic e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$IconModelToJson(IconModel instance) => <String, dynamic>{
      'nationalFlag': instance.nationalFlag,
      'flagicon': instance.flagicon,
      'education': instance.education,
      'details': instance.details,
    };

Education _$EducationFromJson(Map<String, dynamic> json) {
  return Education(
    json['default'] as String?,
  );
}

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'default': instance.defaults,
    };

IconDetailsModel _$IconDetailsModelFromJson(Map<String, dynamic> json) {
  return IconDetailsModel(
    json['industry'] as String?,
    json['phone'] as String?,
    json['email'] as String?,
    json['operatingStatus'] as String?,
    json['foundedDate'] as String?,
    json['revenue'] as String?,
    json['numOfPeople'] as String?,
    json['website'] as String?,
    json['hq'] as String?,
    json['work'] as String?,
    json['registerNumber'] as String?,
    json['cinNumber'] as String?,
    json['companyContact'] as String?,
    json['branches'] as String?,
    json['companyType'] as String?,
  );
}

Map<String, dynamic> _$IconDetailsModelToJson(IconDetailsModel instance) =>
    <String, dynamic>{
      'industry': instance.industry,
      'phone': instance.phone,
      'email': instance.email,
      'operatingStatus': instance.operatingStatus,
      'foundedDate': instance.foundedDate,
      'revenue': instance.revenue,
      'numOfPeople': instance.numOfPeople,
      'website': instance.website,
      'hq': instance.hq,
      'work': instance.work,
      'registerNumber': instance.registerNumber,
      'cinNumber': instance.cinNumber,
      'companyContact': instance.companyContact,
      'branches': instance.branches,
      'companyType': instance.companyType,
    };

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
    (json['country'] as List<dynamic>?)
        ?.map((dynamic e) => e as String)
        .toList(),
    (json['industry'] as List<dynamic>?)
        ?.map((dynamic e) => Industry.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['fund_amount'] as List<dynamic>?)
        ?.map((dynamic e) => FundAmount.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'industry': instance.industry,
      'fund_amount': instance.fundAmount,
    };

Industry _$IndustryFromJson(Map<String, dynamic> json) {
  return Industry(
    json['name'] as String?,
  );
}

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'name': instance.name,
    };

FundAmount _$FundAmountFromJson(Map<String, dynamic> json) {
  return FundAmount(
    json['revenue_min'] as int?,
    json['revenue_max'] as int?,
  );
}

Map<String, dynamic> _$FundAmountToJson(FundAmount instance) =>
    <String, dynamic>{
      'revenue_min': instance.revenueMin,
      'revenue_max': instance.revenueMax,
    };

HotWordsModel _$HotWordsModelFromJson(Map<String, dynamic> json) {
  return HotWordsModel(
    (json['hot_words'] as List<dynamic>?)
        ?.map((dynamic e) =>
            HotWordsItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$HotWordsModelToJson(HotWordsModel instance) =>
    <String, dynamic>{
      'hot_words': instance.hotWords,
      'message': instance.message,
    };

HotWordsItemModel _$HotWordsItemModelFromJson(Map<String, dynamic> json) {
  return HotWordsItemModel(
    json['name'] as String?,
    json['type'] as String?,
  );
}

Map<String, dynamic> _$HotWordsItemModelToJson(HotWordsItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };
