// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsBean _$ProductsBeanFromJson(Map<String, dynamic> json) => ProductsBean(
      (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$ProductsBeanToJson(ProductsBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.list,
      'meta': instance.meta,
    };

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      json['id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
      json['desc'] as String?,
      json['is_collect'] as bool?,
      (json['category'] as List<dynamic>?)
          ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      json['tag_id'] as String?,
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'name': instance.name,
      'logo': instance.logo,
      'desc': instance.desc,
      'is_collect': instance.isCollect,
      'category': instance.category,
      'company': instance.companyModel,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
