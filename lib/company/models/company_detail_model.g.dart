// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetailModel _$CompanyDetailModelFromJson(Map<String, dynamic> json) {
  return CompanyDetailModel(
    json['id'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    json['location'] as String?,
    json['intro'] as String?,
    json['revenue'] as String?,
    json['website'] as String?,
    (json['industry'] as List<dynamic>?)
        ?.map((dynamic e) => Industry.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['people_number'] as String?,
    json['browsing_count'] as int?,
    json['leader'] == null
        ? null
        : Leader.fromJson(json['leader'] as Map<String, dynamic>),
    json['background_logo'] as String?,
    json['is_collect'] as bool?,
    json['products_sum'] as int?,
    json['personnel_sum'] as int?,
    json['twitter'] as String?,
    json['linkedin'] as String?,
    json['facebook'] as String?,
    json['register_number'] as String?,
    json['unique_id'] as String?,
    (json['finance'] as Map<String, dynamic>?)?.map(
      (k, dynamic e) => MapEntry(k, e as String),
    ),
    json['comments'] == null
        ? null
        : Comments.fromJson(json['comments'] as Map<String, dynamic>),
    json['mobile'] as String?,
    json['email'] as String?,
    (json['details'] as List<dynamic>?)
        ?.map((dynamic e) => Details.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['personnel'] == null
        ? null
        : Personnel.fromJson(json['personnel'] as Map<String, dynamic>),
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    json['message'] as String?,
    json['country_img'] == null
        ? null
        : CountryImg.fromJson(json['country_img'] as Map<String, dynamic>),
    (json['welfare'] as List<dynamic>?)
        ?.map((dynamic e) => e as String)
        .toList(),
    json['staff_level'] == null
        ? null
        : StaffLevel.fromJson(json['staff_level'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompanyDetailModelToJson(CompanyDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'location': instance.location,
      'intro': instance.intro,
      'revenue': instance.revenue,
      'website': instance.website,
      'industry': instance.industry,
      'people_number': instance.peopleNumber,
      'browsing_count': instance.browsingCount,
      'leader': instance.leader,
      'background_logo': instance.backgroundLogo,
      'is_collect': instance.isCollect,
      'products_sum': instance.productsSum,
      'personnel_sum': instance.personnelSum,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
      'facebook': instance.facebook,
      'register_number': instance.registerNumber,
      'unique_id': instance.uniqueId,
      'finance': instance.finance,
      'comments': instance.comments,
      'mobile': instance.mobile,
      'email': instance.email,
      'details': instance.details,
      'personnel': instance.personnel,
      'product': instance.product,
      'message': instance.message,
      'country_img': instance.countryImg,
      'welfare': instance.welfare,
      'staff_level': instance.staffLevel,
    };

Industry _$IndustryFromJson(Map<String, dynamic> json) {
  return Industry(
    json['name'] as String?,
  );
}

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'name': instance.name,
    };

Leader _$LeaderFromJson(Map<String, dynamic> json) {
  return Leader(
    json['id'] as String?,
    json['name'] as String?,
    json['avatar'] as String?,
    json['position'] as String?,
  );
}

Map<String, dynamic> _$LeaderToJson(Leader instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'position': instance.position,
    };

Finance _$FinanceFromJson(Map<String, dynamic> json) {
  return Finance(
    json['total_funding_amount'] as String?,
    json['number_of_funding_rounds'] as String?,
    json['number_of_lead_investors'] as String?,
    json['number_of_investors'] as String?,
    json['number_of_investments'] as String?,
    json['number_of_lead_investments'] as String?,
  );
}

Map<String, dynamic> _$FinanceToJson(Finance instance) => <String, dynamic>{
      'total_funding_amount': instance.totalFundingAmount,
      'number_of_funding_rounds': instance.numberOfFundingRounds,
      'number_of_lead_investors': instance.numberOfLeadInvestors,
      'number_of_investors': instance.numberOfInvestors,
      'number_of_investments': instance.numberOfInvestments,
      'number_of_lead_investments': instance.numberOfLeadInvestments,
    };

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return Comments(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => CommentModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
  )..meta = json['meta'] == null
      ? null
      : MetaModel.fromJson(json['meta'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'data': instance.cmmentModel,
      'meta': instance.meta,
      'total': instance.total,
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    json['id'] as String?,
    json['type'] as int?,
    json['title'] as String?,
    json['comments'] as String?,
    json['position'] as String?,
    json['creation_time'] as String?,
    json['user'] == null
        ? null
        : UserInfoModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'comments': instance.comments,
      'position': instance.position,
      'creation_time': instance.creationTime,
      'user': instance.user,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) {
  return Details(
    json['title'] as String?,
    json['img_type'] as String?,
    json['img_name'] as String?,
    json['sign'] as String?,
    json['show_type'] as int?,
    json['value'] as String?,
  );
}

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'title': instance.title,
      'img_type': instance.imgType,
      'img_name': instance.imgName,
      'sign': instance.sign,
      'show_type': instance.showType,
      'value': instance.value,
    };

Personnel _$PersonnelFromJson(Map<String, dynamic> json) {
  return Personnel(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => PeoplesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PersonnelToJson(Personnel instance) => <String, dynamic>{
      'data': instance.personnelModel,
    };

CountryImg _$CountryImgFromJson(Map<String, dynamic> json) {
  return CountryImg(
    json['img_type'] as String?,
    json['img_name'] as String?,
  );
}

Map<String, dynamic> _$CountryImgToJson(CountryImg instance) =>
    <String, dynamic>{
      'img_type': instance.imgType,
      'img_name': instance.imgName,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'data': instance.productModel,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['id'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    json['desc'] as String?,
    json['product_update_time'] as int?,
    json['is_collect'] as bool?,
    (json['category'] as List<dynamic>?)
        ?.map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['website'] as String?,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'desc': instance.desc,
      'product_update_time': instance.productUpdateTime,
      'is_collect': instance.isCollect,
      'category': instance.category,
      'website': instance.website,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as String?,
    json['name'] as String?,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

StaffLevel _$StaffLevelFromJson(Map<String, dynamic> json) {
  return StaffLevel(
    json['data'] == null
        ? null
        : StaffLevelModel.fromJson(json['data'] as Map<String, dynamic>),
    json['issubvip'] as int?,
  );
}

Map<String, dynamic> _$StaffLevelToJson(StaffLevel instance) =>
    <String, dynamic>{
      'data': instance.staffLevelModel,
      'issubvip': instance.issubvip,
    };

StaffLevelModel _$StaffLevelModelFromJson(Map<String, dynamic> json) {
  return StaffLevelModel(
    (json['layer'] as List<dynamic>?)
        ?.map((dynamic e) => LayerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['second_floor'] as List<dynamic>?)
        ?.map((dynamic e) => LayerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StaffLevelModelToJson(StaffLevelModel instance) =>
    <String, dynamic>{
      'layer': instance.layer,
      'second_floor': instance.secondFloor,
    };

LayerModel _$LayerModelFromJson(Map<String, dynamic> json) {
  return LayerModel(
    json['id'] as String?,
    json['name'] as String?,
    json['avatar'] as String?,
    json['email_count'] as int?,
    json['mobile_count'] as int?,
    json['positions'] as String?,
  );
}

Map<String, dynamic> _$LayerModelToJson(LayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email_count': instance.emailCount,
      'mobile_count': instance.mobileCount,
      'positions': instance.positions,
    };
