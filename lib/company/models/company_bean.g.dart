// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBean _$CompanyBeanFromJson(Map<String, dynamic> json) => CompanyBean(
      list: (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CompanyBeanToJson(CompanyBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.list,
      'meta': instance.meta,
    };

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      json['id'] as String?,
      json['tag_id'] as String?,
      json['country'] as String?,
      json['logo'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['location'] as String?,
      json['mobile'] as String?,
      json['website'] as String?,
      json['people_number'] as String?,
      json['intro'] as String?,
      json['company_status'] as String?,
      json['extensions'] as String?,
      (json['industry'] as List<dynamic>?)
          ?.map((dynamic e) => Industry.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['city'] as String?,
      json['province'] as String?,
      json['founder'] as String?,
      json['fund_of_amount'] as String?,
      json['found_date'] as String?,
      json['found_time'] as String?,
      json['register_date'] as int?,
      json['mobile_count'] as String?,
      json['fund_amount'] as int?,
      json['is_website'] as int?,
      json['is_contacts'] as int?,
      (json['products'] as List<dynamic>?)
          ?.map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_email'] as int?,
      json['operation_status'] as String?,
      json['establish_years'] as int?,
      json['employee_count_min'] as int?,
      json['employee_count_max'] as int?,
      (json['people'] as List<dynamic>?)
          ?.map((dynamic e) => PeoplesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['supply_for'] as String?,
      json['is_collect'] as bool?,
      json['country_img'] == null
          ? null
          : CountryImg.fromJson(json['country_img'] as Map<String, dynamic>),
      json['entity_type'] as int?,
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagId,
      'entity_type': instance.entityType,
      'country': instance.country,
      'logo': instance.logo,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'location': instance.location,
      'website': instance.website,
      'people_number': instance.peopleNumber,
      'intro': instance.intro,
      'company_status': instance.companyStatus,
      'extensions': instance.extensions,
      'industry': instance.industry,
      'city': instance.city,
      'province': instance.province,
      'founder': instance.founder,
      'fund_of_amount': instance.fundOfAmount,
      'found_date': instance.foundDate,
      'found_time': instance.foundTime,
      'register_date': instance.registerDate,
      'mobile_count': instance.mobileCount,
      'fund_amount': instance.fundAmount,
      'is_website': instance.isWebsite,
      'is_contacts': instance.isContacts,
      'products': instance.products,
      'is_email': instance.isEmail,
      'operation_status': instance.operationStatus,
      'establish_years': instance.establishYears,
      'employee_count_min': instance.employeeCountMin,
      'employee_count_max': instance.employeeCountMax,
      'people': instance.people,
      'supply_for': instance.supplyFor,
      'is_collect': instance.isCollect,
      'country_img': instance.countryImg,
    };

Industry _$IndustryFromJson(Map<String, dynamic> json) => Industry(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'name': instance.name,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
    };
