// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendBean _$RecommendBeanFromJson(Map<String, dynamic> json) =>
    RecommendBean(
      brandList: (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => BrandItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyList: (json['company'] as List<dynamic>?)
          ?.map((dynamic e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      personnelList: (json['people'] as List<dynamic>?)
          ?.map((dynamic e) => PeoplesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productList: (json['product'] as List<dynamic>?)
          ?.map(
              (dynamic e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      leadList: (json['lead'] as List<dynamic>?)
          ?.map((dynamic e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RecommendBeanToJson(RecommendBean instance) =>
    <String, dynamic>{
      'company': instance.companyList,
      'people': instance.personnelList,
      'product': instance.productList,
      'lead': instance.leadList,
      'data': instance.brandList,
      'meta': instance.meta,
      'message': instance.message,
    };
