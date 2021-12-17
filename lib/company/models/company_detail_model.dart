import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_detail_model.g.dart';

@JsonSerializable()
class CompanyDetailModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'intro')
  final String? intro;

  @JsonKey(name: 'revenue')
  final String? revenue;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'industry')
  late List<Industry>? industry;

  @JsonKey(name: 'people_number')
  final String? peopleNumber;

  @JsonKey(name: 'browsing_count')
  final int? browsingCount;

  @JsonKey(name: 'leader')
  late Leader? leader;

  @JsonKey(name: 'background_logo')
  final String? backgroundLogo;

  @JsonKey(name: 'is_collect')
  bool? isCollect;

  @JsonKey(name: 'products_sum')
  final int? productsSum;

  @JsonKey(name: 'personnel_sum')
  final int? personnelSum;

  @JsonKey(name: 'twitter')
  final String? twitter;

  @JsonKey(name: 'linkedin')
  final String? linkedin;

  @JsonKey(name: 'facebook')
  final String? facebook;

  @JsonKey(name: 'register_number')
  final String? registerNumber;

  @JsonKey(name: 'unique_id')
  final String? uniqueId;

  @JsonKey(name: 'finance')
  late Map<String, String>? finance;

  @JsonKey(name: 'comments')
  late Comments? comments;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'details')
  late List<Details>? details;

  @JsonKey(name: 'personnel')
  late Personnel? personnel;

  @JsonKey(name: 'product')
  late Product? product;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'country_img')
  final CountryImg? countryImg;

  @JsonKey(name: 'welfare')
  late List<String>? welfare;

  @JsonKey(name: 'staff_level')
  late StaffLevel? staffLevel;
  CompanyDetailModel(
    this.id,
    this.name,
    this.logo,
    this.location,
    this.intro,
    this.revenue,
    this.website,
    this.industry,
    this.peopleNumber,
    this.browsingCount,
    this.leader,
    this.backgroundLogo,
    this.isCollect,
    this.productsSum,
    this.personnelSum,
    this.twitter,
    this.linkedin,
    this.facebook,
    this.registerNumber,
    this.uniqueId,
    this.finance,
    this.comments,
    this.mobile,
    this.email,
    this.details,
    this.personnel,
    this.product,
    this.message,
    this.countryImg,
    this.welfare,
    this.staffLevel,
  );

  factory CompanyDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanyDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanyDetailModelToJson(this);
}

@JsonSerializable()
class Industry {
  @JsonKey(name: 'name')
  final String? name;

  Industry(
    this.name,
  );

  factory Industry.fromJson(Map<String, dynamic> srcJson) =>
      _$IndustryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}

@JsonSerializable()
class Leader {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'position')
  final String? position;

  Leader(
    this.id,
    this.name,
    this.avatar,
    this.position,
  );

  factory Leader.fromJson(Map<String, dynamic> srcJson) =>
      _$LeaderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LeaderToJson(this);
}

@JsonSerializable()
class Finance {
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

  Finance(
    this.totalFundingAmount,
    this.numberOfFundingRounds,
    this.numberOfLeadInvestors,
    this.numberOfInvestors,
    this.numberOfInvestments,
    this.numberOfLeadInvestments,
  );

  factory Finance.fromJson(Map<String, dynamic> srcJson) =>
      _$FinanceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FinanceToJson(this);
}

@JsonSerializable()
class Comments {
  @JsonKey(name: 'data')
  late List<CommentModel>? cmmentModel;
  @JsonKey(name: 'meta')
  late MetaModel? meta;
  @JsonKey(name: 'total')
  final int? total;

  Comments(
    this.cmmentModel,
    this.total,
  );

  factory Comments.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}

@JsonSerializable()
class CommentModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'comments')
  final String? comments;

  @JsonKey(name: 'position')
  final String? position;

  @JsonKey(name: 'creation_time')
  final String? creationTime;

  @JsonKey(name: 'user')
  late UserInfoModel? user;

  CommentModel(
    this.id,
    this.type,
    this.title,
    this.comments,
    this.position,
    this.creationTime,
    this.user,
  );

  factory CommentModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

@JsonSerializable()
class Details {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'img_type')
  final String? imgType;

  @JsonKey(name: 'img_name')
  final String? imgName;

  @JsonKey(name: 'sign')
  final String? sign;

  @JsonKey(name: 'show_type')
  final int? showType;

  @JsonKey(name: 'value')
  final String? value;

  Details(
    this.title,
    this.imgType,
    this.imgName,
    this.sign,
    this.showType,
    this.value,
  );

  factory Details.fromJson(Map<String, dynamic> srcJson) =>
      _$DetailsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Personnel {
  @JsonKey(name: 'data')
  late List<PeoplesModel>? personnelModel;

  Personnel(
    this.personnelModel,
  );

  factory Personnel.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonnelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonnelToJson(this);
}

@JsonSerializable()
class CountryImg {
  @JsonKey(name: 'img_type')
  final String? imgType;

  @JsonKey(name: 'img_name')
  final String? imgName;

  CountryImg(
    this.imgType,
    this.imgName,
  );

  factory CountryImg.fromJson(Map<String, dynamic> srcJson) =>
      _$CountryImgFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CountryImgToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: 'data')
  late List<ProductModel>? productModel;

  Product(
    this.productModel,
  );

  factory Product.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
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

  @JsonKey(name: 'product_update_time')
  final int? productUpdateTime;

  @JsonKey(name: 'is_collect')
  final bool? isCollect;

  @JsonKey(name: 'category')
  late List<Category>? category;

  @JsonKey(name: 'website')
  final String? website;

  ProductModel(
    this.id,
    this.name,
    this.logo,
    this.desc,
    this.productUpdateTime,
    this.isCollect,
    this.category,
    this.website,
  );

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  Category(
    this.id,
    this.name,
  );

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class StaffLevel {
  @JsonKey(name: 'data')
  late StaffLevelModel? staffLevelModel;

  @JsonKey(name: 'issubvip')
  final int? issubvip;

  StaffLevel(
    this.staffLevelModel,
    this.issubvip,
  );

  factory StaffLevel.fromJson(Map<String, dynamic> srcJson) =>
      _$StaffLevelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StaffLevelToJson(this);
}

@JsonSerializable()
class StaffLevelModel {
  @JsonKey(name: 'layer')
  late List<LayerModel>? layer;

  @JsonKey(name: 'second_floor')
  late List<LayerModel>? secondFloor;

  StaffLevelModel(
    this.layer,
    this.secondFloor,
  );

  factory StaffLevelModel.fromJson(Map<String, dynamic> srcJson) =>
      _$StaffLevelModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StaffLevelModelToJson(this);
}

@JsonSerializable()
class LayerModel {
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

  LayerModel(
    this.id,
    this.name,
    this.avatar,
    this.emailCount,
    this.mobileCount,
    this.positions,
  );

  factory LayerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LayerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LayerModelToJson(this);
}
