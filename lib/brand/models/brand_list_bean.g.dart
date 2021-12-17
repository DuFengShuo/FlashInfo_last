// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandListBean _$BrandListBeanFromJson(Map<String, dynamic> json) =>
    BrandListBean(
      (json['company'] as List<dynamic>?)
          ?.map(
              (dynamic e) => BrandItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$BrandListBeanToJson(BrandListBean instance) =>
    <String, dynamic>{
      'company': instance.company,
      'meta': instance.meta,
      'message': instance.message,
    };

BrandItemModel _$BrandItemModelFromJson(Map<String, dynamic> json) =>
    BrandItemModel(
      json['id'] as String?,
      json['logo'] as String?,
      json['name'] as String?,
      json['intro'] as String?,
      json['entity_type'] as int?,
      json['is_contacts'] as int?,
      json['last_funding_type'] as String?,
      json['is_collect'] as bool?,
    );

Map<String, dynamic> _$BrandItemModelToJson(BrandItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'intro': instance.intro,
      'is_contacts': instance.isContacts,
      'is_collect': instance.isCollect,
      'entity_type': instance.entityType,
      'last_funding_type': instance.lastFundingType,
    };
