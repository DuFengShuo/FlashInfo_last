// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandBean _$BrandBeanFromJson(Map<String, dynamic> json) => BrandBean(
      json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
      json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      Financials.fromJson(json['financials'] as Map<String, dynamic>),
      json['business'] == null
          ? null
          : Business.fromJson(json['business'] as Map<String, dynamic>),
      json['news'] == null
          ? null
          : News.fromJson(json['news'] as Map<String, dynamic>),
      json['events'] == null
          ? null
          : Events.fromJson(json['events'] as Map<String, dynamic>),
      json['photos'] == null
          ? null
          : Photos.fromJson(json['photos'] as Map<String, dynamic>),
      json['message'] as String?,
    );

Map<String, dynamic> _$BrandBeanToJson(BrandBean instance) => <String, dynamic>{
      'info': instance.info,
      'summary': instance.summary,
      'organization': instance.organization,
      'financials': instance.financials,
      'business': instance.business,
      'news': instance.news,
      'events': instance.events,
      'photos': instance.photos,
      'message': instance.message,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      json['id'] as String?,
      json['logo'] as String?,
      json['name'] as String?,
      json['entity_type'] as int?,
      json['company_tag'] as String?,
      json['is_collect'] as bool?,
      json['linkedin'] as String?,
      json['twitter'] as String?,
      json['facebook'] as String?,
      json['youtube'] as String?,
      json['instagram'] as String?,
      json['short_intro'] as String?,
      json['industry'] as List<dynamic>?,
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'entity_type': instance.entityType,
      'company_tag': instance.companyTag,
      'is_collect': instance.isCollect,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'facebook': instance.facebook,
      'youtube': instance.youtube,
      'instagram': instance.instagram,
      'short_intro': instance.shortIntro,
      'industry': instance.industry,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) => Summary(
      json['overview'] == null
          ? null
          : Overview.fromJson(json['overview'] as Map<String, dynamic>),
      json['contact_info'] == null
          ? null
          : ContactInfo.fromJson(json['contact_info'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : CompanyList.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'overview': instance.overview,
      'contact_info': instance.contactInfo,
      'company': instance.companyList,
    };

CompanyList _$CompanyListFromJson(Map<String, dynamic> json) => CompanyList(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyListToJson(CompanyList instance) =>
    <String, dynamic>{
      'total': instance.total,
      'data': instance.companyList,
    };

Overview _$OverviewFromJson(Map<String, dynamic> json) => Overview(
      json['about'] as String?,
      json['website'] as String?,
      json['industry'] as String?,
      json['employee_size'] as String?,
      json['ipo'] == null
          ? null
          : Ipo.fromJson(json['ipo'] as Map<String, dynamic>),
      (json['founders'] as List<dynamic>?)
          ?.map((dynamic e) => Founders.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['founded_date'] as String?,
      json['last_funding_type'] as String?,
      json['headquarters_location'] as String?,
      (json['tags'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      (json['benefit'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OverviewToJson(Overview instance) => <String, dynamic>{
      'about': instance.about,
      'website': instance.website,
      'industry': instance.industry,
      'employee_size': instance.employeeSize,
      'ipo': instance.ipo,
      'founders': instance.founders,
      'founded_date': instance.foundedDate,
      'last_funding_type': instance.lastFundingType,
      'headquarters_location': instance.headquartersLocation,
      'tags': instance.tags,
      'benefit': instance.benefit,
    };

Ipo _$IpoFromJson(Map<String, dynamic> json) => Ipo(
      json['ipo_status'] as String?,
      json['stock_symbol'] == null
          ? null
          : StockSymbol.fromJson(json['stock_symbol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IpoToJson(Ipo instance) => <String, dynamic>{
      'ipo_status': instance.ipoStatus,
      'stock_symbol': instance.stockSymbol,
    };

StockSymbol _$StockSymbolFromJson(Map<String, dynamic> json) => StockSymbol(
      json['label'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$StockSymbolToJson(StockSymbol instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

Founders _$FoundersFromJson(Map<String, dynamic> json) => Founders(
      json['id'] as String?,
      json['name'] as String?,
      json['position'] as String?,
    );

Map<String, dynamic> _$FoundersToJson(Founders instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
    };

ContactInfo _$ContactInfoFromJson(Map<String, dynamic> json) => ContactInfo(
      json['phone_number'] as String?,
      json['email'] as String?,
      json['address'] as String?,
    );

Map<String, dynamic> _$ContactInfoToJson(ContactInfo instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      json['id'] as String?,
      json['legal_name'] as String?,
      json['identification_number'] as String?,
      json['incorporation_date'] as String?,
      json['operating_status'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'legal_name': instance.legalName,
      'identification_number': instance.identificationNumber,
      'incorporation_date': instance.incorporationDate,
      'operating_status': instance.operatingStatus,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      json['org_chart'] == null
          ? null
          : OrgChart.fromJson(json['org_chart'] as Map<String, dynamic>),
      json['employees'] == null
          ? null
          : Employees.fromJson(json['employees'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'org_chart': instance.orgChart,
      'employees': instance.employees,
    };

OrgChart _$OrgChartFromJson(Map<String, dynamic> json) => OrgChart(
      json['data'] == null
          ? null
          : OrgChartModel.fromJson(json['data'] as Map<String, dynamic>),
      json['issubvip'] as int?,
    );

Map<String, dynamic> _$OrgChartToJson(OrgChart instance) => <String, dynamic>{
      'data': instance.orgChartModel,
      'issubvip': instance.isSubvip,
    };

OrgChartModel _$OrgChartModelFromJson(Map<String, dynamic> json) =>
    OrgChartModel(
      (json['layer'] as List<dynamic>?)
          ?.map((dynamic e) => Layer.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['second_floor'] as List<dynamic>?)
          ?.map((dynamic e) => SecondFloor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrgChartModelToJson(OrgChartModel instance) =>
    <String, dynamic>{
      'layer': instance.layer,
      'second_floor': instance.secondFloor,
    };

Layer _$LayerFromJson(Map<String, dynamic> json) => Layer(
      json['id'] as String?,
      json['name'] as String?,
      json['avatar'] as String?,
      json['email_count'] as int?,
      json['mobile_count'] as int?,
      json['positions'] as String?,
    );

Map<String, dynamic> _$LayerToJson(Layer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email_count': instance.emailCount,
      'mobile_count': instance.mobileCount,
      'positions': instance.positions,
    };

SecondFloor _$SecondFloorFromJson(Map<String, dynamic> json) => SecondFloor(
      json['id'] as String?,
      json['name'] as String?,
      json['avatar'] as String?,
      json['email_count'] as int?,
      json['mobile_count'] as int?,
      json['positions'] as String?,
    );

Map<String, dynamic> _$SecondFloorToJson(SecondFloor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email_count': instance.emailCount,
      'mobile_count': instance.mobileCount,
      'positions': instance.positions,
    };

Employees _$EmployeesFromJson(Map<String, dynamic> json) => Employees(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map(
              (dynamic e) => EmployeesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeesToJson(Employees instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.employeesList,
    };

EmployeesModel _$EmployeesModelFromJson(Map<String, dynamic> json) =>
    EmployeesModel(
      json['id'] as String?,
      json['name'] as String?,
      json['avatar'] as String?,
      json['mobile'] as String?,
      json['email'] as String?,
      json['position'] as String?,
      json['is_collect'] as bool?,
      json['is_unlock'] as bool?,
    );

Map<String, dynamic> _$EmployeesModelToJson(EmployeesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'mobile': instance.mobile,
      'email': instance.email,
      'position': instance.position,
      'is_collect': instance.isCollect,
      'is_unlock': instance.isUnlock,
    };

Financials _$FinancialsFromJson(Map<String, dynamic> json) => Financials(
      json['total_funding_amount'] as String?,
      json['number_of_funding_rounds'] as String?,
      json['number_of_lead_investors'] as String?,
      json['number_of_investors'] as String?,
      json['number_of_investments'] as String?,
      json['number_of_lead_investments'] as String?,
    );

Map<String, dynamic> _$FinancialsToJson(Financials instance) =>
    <String, dynamic>{
      'total_funding_amount': instance.totalFundingAmount,
      'number_of_funding_rounds': instance.numberOfFundingRounds,
      'number_of_lead_investors': instance.numberOfLeadInvestors,
      'number_of_investors': instance.numberOfInvestors,
      'number_of_investments': instance.numberOfInvestments,
      'number_of_lead_investments': instance.numberOfLeadInvestments,
    };

Business _$BusinessFromJson(Map<String, dynamic> json) => Business(
      json['products'] == null
          ? null
          : Products.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'products': instance.products,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.productList,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String?,
      json['name'] as String?,
      json['logo'] as String?,
      json['desc'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'desc': instance.desc,
    };

News _$NewsFromJson(Map<String, dynamic> json) => News(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.newsList,
    };

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      json['id'] as String?,
      json['title'] as String?,
      json['source'] as String?,
      json['publish_time'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'publish_time': instance.publishTime,
      'link': instance.link,
    };

Events _$EventsFromJson(Map<String, dynamic> json) => Events(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.eventList,
    };

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      json['id'] as String?,
      json['event_img'] as String?,
      json['event_name'] as String?,
      json['appearance_type'] as String?,
      json['event_starts_on'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_img': instance.eventImg,
      'event_name': instance.eventName,
      'appearance_type': instance.appearanceType,
      'event_starts_on': instance.eventStartsOn,
    };

Photos _$PhotosFromJson(Map<String, dynamic> json) => Photos(
      json['total'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((dynamic e) => PhotosModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'total': instance.total,
      'data': instance.photoList,
    };

PhotosModel _$PhotosModelFromJson(Map<String, dynamic> json) => PhotosModel(
      json['id'] as String?,
      json['logo'] as String?,
      json['big_photo_url'] as String?,
    );

Map<String, dynamic> _$PhotosModelToJson(PhotosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'big_photo_url': instance.bigPhotoUrl,
    };
