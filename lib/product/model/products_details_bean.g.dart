// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_details_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsDetailsBean _$ProductsDetailsBeanFromJson(Map<String, dynamic> json) =>
    ProductsDetailsBean(
      json['id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
      json['desc'] as String?,
      json['website'] as String?,
      json['is_unlock'] as bool?,
      json['background_logo'] as String?,
      json['is_collect'] as bool?,
      json['browsing_count'] as int?,
      (json['category'] as List<dynamic>?)
          ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['albums'] == null
          ? null
          : Albums.fromJson(json['albums'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
      json['comments'] == null
          ? null
          : Reviews.fromJson(json['comments'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$ProductsDetailsBeanToJson(
        ProductsDetailsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'desc': instance.desc,
      'website': instance.website,
      'background_logo': instance.backgroundLogo,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
      'browsing_count': instance.browsingCount,
      'category': instance.category,
      'albums': instance.albums,
      'company': instance.company,
      'comments': instance.comments,
      'message': instance.message,
    };

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => AlbumsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total'] as int?,
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'data': instance.list,
      'total': instance.total,
    };
