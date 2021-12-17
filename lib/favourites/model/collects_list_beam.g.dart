// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collects_list_beam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectsListBeam _$CollectsListBeamFromJson(Map<String, dynamic> json) =>
    CollectsListBeam(
      (json['product'] as List<dynamic>?)
          ?.map((dynamic e) =>
              ProductTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['company'] as List<dynamic>?)
          ?.map((dynamic e) =>
              CompanyTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['personnel'] as List<dynamic>?)
          ?.map((dynamic e) =>
              PersonnelTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['brand'] as List<dynamic>?)
          ?.map(
              (dynamic e) => BrandTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$CollectsListBeamToJson(CollectsListBeam instance) =>
    <String, dynamic>{
      'company': instance.companyList,
      'personnel': instance.personnelList,
      'product': instance.productList,
      'brand': instance.brandList,
      'meta': instance.meta,
      'message': instance.message,
    };

CompanyTagModel _$CompanyTagModelFromJson(Map<String, dynamic> json) =>
    CompanyTagModel(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['data_type'] as int,
      json['detail'] == null
          ? null
          : CompanyModel.fromJson(json['detail'] as Map<String, dynamic>),
      json['created_at'] as String?,
    );

Map<String, dynamic> _$CompanyTagModelToJson(CompanyTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'data_type': instance.dataType,
      'created_at': instance.createdAt,
      'detail': instance.companyModel,
    };

PersonnelTagModel _$PersonnelTagModelFromJson(Map<String, dynamic> json) =>
    PersonnelTagModel(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['data_type'] as int,
      json['detail'] == null
          ? null
          : PeoplesModel.fromJson(json['detail'] as Map<String, dynamic>),
      json['created_at'] as String?,
    );

Map<String, dynamic> _$PersonnelTagModelToJson(PersonnelTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'data_type': instance.dataType,
      'created_at': instance.createdAt,
      'detail': instance.peoplesModel,
    };

ProductTagModel _$ProductTagModelFromJson(Map<String, dynamic> json) =>
    ProductTagModel(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['data_type'] as int,
      json['detail'] == null
          ? null
          : ProductsModel.fromJson(json['detail'] as Map<String, dynamic>),
      json['created_at'] as String?,
    );

Map<String, dynamic> _$ProductTagModelToJson(ProductTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'data_type': instance.dataType,
      'created_at': instance.createdAt,
      'detail': instance.productsModel,
    };

BrandTagModel _$BrandTagModelFromJson(Map<String, dynamic> json) =>
    BrandTagModel(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['data_type'] as int?,
      json['created_at'] as String?,
      BrandDetail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BrandTagModelToJson(BrandTagModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'data_type': instance.dataType,
      'created_at': instance.createdAt,
      'detail': instance.brandDetail,
    };

BrandDetail _$BrandDetailFromJson(Map<String, dynamic> json) => BrandDetail(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
      json['country'] as String?,
      CountryImg.fromJson(json['country_img'] as Map<String, dynamic>),
      json['company_status'] as String?,
      (json['industry'] as List<dynamic>)
          .map((dynamic e) => Industry.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['found_date'] as String?,
      json['people_number'] as String?,
      json['founder'] as String?,
      json['mobile'] as String?,
      json['location'] as String?,
      json['is_collect'] as bool,
      json['mobile_count'] as String?,
      json['revenue'] as String?,
      json['website'] as String?,
      json['intro'] as String?,
      json['twitter'] as String?,
      json['linkedin'] as String?,
      json['facebook'] as String?,
      json['email'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$BrandDetailToJson(BrandDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'name': instance.name,
      'logo': instance.logo,
      'country': instance.country,
      'country_img': instance.countryImg,
      'company_status': instance.companyStatus,
      'industry': instance.industry,
      'found_date': instance.foundDate,
      'people_number': instance.peopleNumber,
      'founder': instance.founder,
      'mobile': instance.mobile,
      'location': instance.location,
      'is_collect': instance.isCollect,
      'mobile_count': instance.mobileCount,
      'revenue': instance.revenue,
      'website': instance.website,
      'intro': instance.intro,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'email': instance.email,
      'address': instance.address,
    };

CountryImg _$CountryImgFromJson(Map<String, dynamic> json) => CountryImg(
      json['img_type'] as String?,
      json['img_name'] as String?,
    );

Map<String, dynamic> _$CountryImgToJson(CountryImg instance) =>
    <String, dynamic>{
      'img_type': instance.imgType,
      'img_name': instance.imgName,
    };

Industry _$IndustryFromJson(Map<String, dynamic> json) => Industry(
      json['name'] as String?,
    );

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'name': instance.name,
    };
