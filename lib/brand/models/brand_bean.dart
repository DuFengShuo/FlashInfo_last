import 'package:json_annotation/json_annotation.dart';

part 'brand_bean.g.dart';

@JsonSerializable()
class BrandBean {
  @JsonKey(name: 'info')
  late Info? info;

  @JsonKey(name: 'summary')
  late Summary? summary;

  @JsonKey(name: 'organization')
  late Organization? organization;

  @JsonKey(name: 'financials')
  late Financials financials;
  //
  @JsonKey(name: 'business')
  late Business? business;

  @JsonKey(name: 'news')
  late News? news;

  @JsonKey(name: 'events')
  late Events? events;

  //
  @JsonKey(name: 'photos')
  late Photos? photos;

  @JsonKey(name: 'message')
  final String? message;

  BrandBean(this.info, this.summary, this.organization, this.financials,
      this.business, this.news, this.events, this.photos, this.message);

  factory BrandBean.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BrandBeanToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'entity_type')
  final int? entityType;

  @JsonKey(name: 'company_tag')
  final String? companyTag;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'youtube')
  final String? youtube;

  @JsonKey(name: 'instagram')
  final String? instagram;

  @JsonKey(name: 'short_intro')
  final String? shortIntro;

  @JsonKey(name: 'industry')
  late List<dynamic>? industry;

  Info(
      this.id,
      this.logo,
      this.name,
      this.entityType,
      this.companyTag,
      this.isCollect,
      this.linkedin,
      this.twitter,
      this.facebook,
      this.youtube,
      this.instagram,
      this.shortIntro,
      this.industry);

  factory Info.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Summary {
  @JsonKey(name: 'overview')
  late Overview? overview;

  @JsonKey(name: 'contact_info')
  late ContactInfo? contactInfo;

  //
  @JsonKey(name: 'company')
  late CompanyList? companyList;

  // Summary(this.overview,this.contactInfo,this.company,);
  Summary(this.overview, this.contactInfo, this.companyList);

  factory Summary.fromJson(Map<String, dynamic> srcJson) =>
      _$SummaryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class CompanyList {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<Company>? companyList;

  CompanyList(
    this.total,
    this.companyList,
  );

  factory CompanyList.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyListToJson(this);
}

@JsonSerializable()
class Overview {
  @JsonKey(name: 'about')
  final String? about;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'industry')
  final String? industry;

  @JsonKey(name: 'employee_size')
  final String? employeeSize;

  @JsonKey(name: 'ipo')
  late Ipo? ipo;

  @JsonKey(name: 'founders')
  late List<Founders>? founders;

  @JsonKey(name: 'founded_date')
  final String? foundedDate;

  @JsonKey(name: 'last_funding_type')
  final String? lastFundingType;

  @JsonKey(name: 'headquarters_location')
  final String? headquartersLocation;

  @JsonKey(name: 'tags')
  late List<String>? tags;

  @JsonKey(name: 'benefit')
  late List<String>? benefit;

  Overview(
    this.about,
    this.website,
    this.industry,
    this.employeeSize,
    this.ipo,
    this.founders,
    this.foundedDate,
    this.lastFundingType,
    this.headquartersLocation,
    this.tags,
    this.benefit,
  );

  factory Overview.fromJson(Map<String, dynamic> srcJson) =>
      _$OverviewFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OverviewToJson(this);
}

@JsonSerializable()
class Ipo {
  @JsonKey(name: 'ipo_status')
  final String? ipoStatus;

  @JsonKey(name: 'stock_symbol')
  StockSymbol? stockSymbol;

  Ipo(
    this.ipoStatus,
    this.stockSymbol,
  );

  factory Ipo.fromJson(Map<String, dynamic> srcJson) => _$IpoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IpoToJson(this);
}

@JsonSerializable()
class StockSymbol {
  @JsonKey(name: 'label')
  final String? label;

  @JsonKey(name: 'value')
  final String? value;

  StockSymbol(
    this.label,
    this.value,
  );

  factory StockSymbol.fromJson(Map<String, dynamic> srcJson) =>
      _$StockSymbolFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StockSymbolToJson(this);
}

@JsonSerializable()
class Founders {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'position')
  final String? position;

  Founders(
    this.id,
    this.name,
    this.position,
  );

  factory Founders.fromJson(Map<String, dynamic> srcJson) =>
      _$FoundersFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FoundersToJson(this);
}

@JsonSerializable()
class ContactInfo {
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'address')
  final String? address;

  ContactInfo(
    this.phoneNumber,
    this.email,
    this.address,
  );

  factory ContactInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ContactInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContactInfoToJson(this);
}

@JsonSerializable()
class Company {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'legal_name')
  final String? legalName;

  @JsonKey(name: 'identification_number')
  final String? identificationNumber;

  @JsonKey(name: 'incorporation_date')
  final String? incorporationDate;

  @JsonKey(name: 'operating_status')
  final String? operatingStatus;

  Company(
    this.id,
    this.legalName,
    this.identificationNumber,
    this.incorporationDate,
    this.operatingStatus,
  );

  factory Company.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class Organization {
  @JsonKey(name: 'org_chart')
  late OrgChart? orgChart;

  @JsonKey(name: 'employees')
  late Employees? employees;

  Organization(
    this.orgChart,
    this.employees,
  );

  factory Organization.fromJson(Map<String, dynamic> srcJson) =>
      _$OrganizationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class OrgChart {
  @JsonKey(name: 'data')
  late OrgChartModel? orgChartModel;

  @JsonKey(name: 'issubvip')
  final int? isSubvip;

  OrgChart(
    this.orgChartModel,
    this.isSubvip,
  );

  factory OrgChart.fromJson(Map<String, dynamic> srcJson) =>
      _$OrgChartFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrgChartToJson(this);
}

@JsonSerializable()
class OrgChartModel {
  @JsonKey(name: 'layer')
  late List<Layer>? layer;

  @JsonKey(name: 'second_floor')
  late List<SecondFloor>? secondFloor;

  OrgChartModel(
    this.layer,
    this.secondFloor,
  );

  factory OrgChartModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrgChartModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrgChartModelToJson(this);
}

@JsonSerializable()
class Layer {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'email_count')
  final int? emailCount;

  @JsonKey(name: 'mobile_count')
  final int? mobileCount;

  @JsonKey(name: 'positions')
  final String? positions;

  Layer(
    this.id,
    this.name,
    this.avatar,
    this.emailCount,
    this.mobileCount,
    this.positions,
  );

  factory Layer.fromJson(Map<String, dynamic> srcJson) =>
      _$LayerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LayerToJson(this);
}

@JsonSerializable()
class SecondFloor {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'email_count')
  final int? emailCount;

  @JsonKey(name: 'mobile_count')
  final int? mobileCount;

  @JsonKey(name: 'positions')
  final String? positions;

  SecondFloor(
    this.id,
    this.name,
    this.avatar,
    this.emailCount,
    this.mobileCount,
    this.positions,
  );

  factory SecondFloor.fromJson(Map<String, dynamic> srcJson) =>
      _$SecondFloorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SecondFloorToJson(this);
}

@JsonSerializable()
class Employees {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<EmployeesModel>? employeesList;

  Employees(
    this.total,
    this.employeesList,
  );

  factory Employees.fromJson(Map<String, dynamic> srcJson) =>
      _$EmployeesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmployeesToJson(this);
}

@JsonSerializable()
class EmployeesModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'is_collect')
  final bool? isCollect;

  @JsonKey(name: 'is_unlock')
  bool? isUnlock;

  EmployeesModel(
    this.id,
    this.name,
    this.avatar,
    this.mobile,
    this.email,
    this.position,
    this.isCollect,
    this.isUnlock,
  );

  factory EmployeesModel.fromJson(Map<String, dynamic> srcJson) =>
      _$EmployeesModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmployeesModelToJson(this);
}

@JsonSerializable()
class Financials {
  @JsonKey(name: 'total_funding_amount')
  final String? totalFundingAmount;

  @JsonKey(name: 'number_of_funding_rounds')
  final String? numberOfFundingRounds;

  @JsonKey(name: 'number_of_lead_investors')
  final String? numberOfLeadInvestors;

  @JsonKey(name: 'number_of_investors')
  final String? numberOfInvestors;

  @JsonKey(name: 'number_of_investments')
  final String? numberOfInvestments;

  @JsonKey(name: 'number_of_lead_investments')
  final String? numberOfLeadInvestments;

  Financials(
    this.totalFundingAmount,
    this.numberOfFundingRounds,
    this.numberOfLeadInvestors,
    this.numberOfInvestors,
    this.numberOfInvestments,
    this.numberOfLeadInvestments,
  );

  factory Financials.fromJson(Map<String, dynamic> srcJson) =>
      _$FinancialsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FinancialsToJson(this);
}

@JsonSerializable()
class Business {
  @JsonKey(name: 'products')
  late Products? products;

  Business(
    this.products,
  );

  factory Business.fromJson(Map<String, dynamic> srcJson) =>
      _$BusinessFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BusinessToJson(this);
}

@JsonSerializable()
class Products {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<ProductModel>? productList;

  Products(
    this.total,
    this.productList,
  );

  factory Products.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}

@JsonSerializable()
class ProductModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'desc')
  final String? desc;

  ProductModel(
    this.id,
    this.name,
    this.logo,
    this.desc,
  );

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class News {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<NewsModel>? newsList;

  News(
    this.total,
    this.newsList,
  );

  factory News.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class NewsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'publish_time')
  final String? publishTime;

  @JsonKey(name: 'link')
  final String? link;

  NewsModel(
    this.id,
    this.title,
    this.source,
    this.publishTime,
    this.link,
  );

  factory NewsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class Events {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<EventModel>? eventList;

  Events(
    this.total,
    this.eventList,
  );

  factory Events.fromJson(Map<String, dynamic> srcJson) =>
      _$EventsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventsToJson(this);
}

@JsonSerializable()
class EventModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'event_img')
  final String? eventImg;

  @JsonKey(name: 'event_name')
  final String? eventName;

  @JsonKey(name: 'appearance_type')
  final String? appearanceType;

  @JsonKey(name: 'event_starts_on')
  final String? eventStartsOn;

  EventModel(
    this.id,
    this.eventImg,
    this.eventName,
    this.appearanceType,
    this.eventStartsOn,
  );

  factory EventModel.fromJson(Map<String, dynamic> srcJson) =>
      _$EventModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}

@JsonSerializable()
class Photos {
  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'data')
  late List<PhotosModel>? photoList;

  Photos(
    this.total,
    this.photoList,
  );

  factory Photos.fromJson(Map<String, dynamic> srcJson) =>
      _$PhotosFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}

@JsonSerializable()
class PhotosModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'big_photo_url')
  final String? bigPhotoUrl;

  PhotosModel(
    this.id,
    this.logo,
    this.bigPhotoUrl,
  );

  factory PhotosModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PhotosModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PhotosModelToJson(this);
}
