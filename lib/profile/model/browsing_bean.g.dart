// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browsing_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrowsingBean _$BrowsingBeanFromJson(Map<String, dynamic> json) {
  return BrowsingBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => BrowsingModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$BrowsingBeanToJson(BrowsingBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

BrowsingModel _$BrowsingModelFromJson(Map<String, dynamic> json) {
  return BrowsingModel(
    json['id'] as String?,
    json['model'] as String?,
    json['model_id'] as String?,
    json['model_name'] as String?,
    json['model_logo'] as String?,
    json['model_intro'] as String?,
    json['created_time'] as String?,
    json['company_name'] as String?,
    json['company_legal_representive'] as String?,
    json['company_people_number'] as String?,
    json['company_website'] as String?,
    json['address'] as String?,
    json['product_website'] as String?,
  );
}

Map<String, dynamic> _$BrowsingModelToJson(BrowsingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'model_id': instance.modelId,
      'model_name': instance.modelName,
      'model_logo': instance.modelLogo,
      'model_intro': instance.modelIntro,
      'created_time': instance.createdTime,
      'company_name': instance.companyName,
      'company_legal_representive': instance.companyLegalRepresentive,
      'company_people_number': instance.companyPeopleNumber,
      'company_website': instance.companyWebsite,
      'address': instance.address,
      'product_website': instance.productWebsite,
    };
