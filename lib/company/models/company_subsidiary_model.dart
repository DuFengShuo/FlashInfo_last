import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/investments_bean.dart';
import 'package:flashinfo/company/models/investors_bean.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'finance_rounds_bean.dart';

part 'company_subsidiary_model.g.dart';

@JsonSerializable()
class CompanySubsidiaryModel {
  @JsonKey(name: 'branch')
  late Branch? branch;

  @JsonKey(name: 'albums')
  late Albums? albums;

  @JsonKey(name: 'similar_companies')
  late SimilarCompanies? similarCompanies;

  @JsonKey(name: 'news')
  late News? news;

  @JsonKey(name: 'funding_rounds')
  late FundingRounds? fundingRounds;

  @JsonKey(name: 'investors')
  late Investors? investors;

  @JsonKey(name: 'investments')
  late Investments? investments;

  @JsonKey(name: 'message')
  final String? message;

  CompanySubsidiaryModel(
    this.branch,
    this.albums,
    this.similarCompanies,
    this.news,
    this.fundingRounds,
    this.investors,
    this.investments,
    this.message,
  );

  factory CompanySubsidiaryModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CompanySubsidiaryModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CompanySubsidiaryModelToJson(this);
}

@JsonSerializable()
class Branch {
  @JsonKey(name: 'data')
  late List<CompanyModel>? list;

  @JsonKey(name: 'total')
  final int? total;

  Branch(
    this.list,
    this.total,
  );

  factory Branch.fromJson(Map<String, dynamic> srcJson) =>
      _$BranchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}

@JsonSerializable()
class Albums {
  @JsonKey(name: 'data')
  late List<AlbumsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'total')
  final int? total;

  Albums(
    this.list,
    this.meta,
    this.message,
    this.total,
  );

  factory Albums.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}

@JsonSerializable()
class AlbumsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  AlbumsModel(
    this.id,
    this.name,
    this.logo,
  );

  factory AlbumsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumsModelToJson(this);
}

@JsonSerializable()
class SimilarCompanies {
  @JsonKey(name: 'data')
  late List<SimilarCompaniesModel>? list;

  @JsonKey(name: 'total')
  final int? total;

  SimilarCompanies(
    this.list,
    this.total,
  );

  factory SimilarCompanies.fromJson(Map<String, dynamic> srcJson) =>
      _$SimilarCompaniesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SimilarCompaniesToJson(this);
}

@JsonSerializable()
class SimilarCompaniesModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'industry')
  late List<Industry>? industry;

  @JsonKey(name: 'similar_reasons')
  final String? similarReasons;

  SimilarCompaniesModel(
    this.id,
    this.logo,
    this.name,
    this.industry,
    this.similarReasons,
  );

  factory SimilarCompaniesModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SimilarCompaniesModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SimilarCompaniesModelToJson(this);
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
class News {
  @JsonKey(name: 'data')
  late List<NewsModel>? list;
  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'total')
  final int? total;

  News(
    this.list,
    this.meta,
    this.total,
    this.message,
  );

  factory News.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class NewsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'desc')
  final String? desc;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'publish_time')
  final String? publishTime;

  NewsModel(
    this.id,
    this.logo,
    this.title,
    this.desc,
    this.source,
    this.link,
    this.publishTime,
  );

  factory NewsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$NewsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}

@JsonSerializable()
class FundingRounds {
  @JsonKey(name: 'data')
  late List<FinanceRoundsModel>? list;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'meta')
  final MetaModel? meta;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'number_of_funding_rounds')
  final String? numberOfFundingRounds;

  @JsonKey(name: 'total_funding_amount')
  final String? totalFundingAmount;

  FundingRounds(
    this.list,
    this.total,
    this.meta,
    this.message,
    this.numberOfFundingRounds,
    this.totalFundingAmount,
  );

  factory FundingRounds.fromJson(Map<String, dynamic> srcJson) =>
      _$FundingRoundsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FundingRoundsToJson(this);
}

@JsonSerializable()
class Investors {
  @JsonKey(name: 'data')
  late List<InvestorsModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'number_of_lead_investors')
  final String? numberOfLeadInvestors;

  @JsonKey(name: 'number_of_investors')
  final String? numberOfInvestors;

  Investors(
    this.list,
    this.meta,
    this.message,
    this.numberOfLeadInvestors,
    this.numberOfInvestors,
  );

  factory Investors.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestorsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestorsToJson(this);
}

@JsonSerializable()
class Investments {
  @JsonKey(name: 'data')
  late List<InvestmentsModel>? list;
  @JsonKey(name: 'meta')
  final MetaModel? meta;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'number_of_investments')
  final String? numberOfInvestments;

  @JsonKey(name: 'number_of_lead_investments')
  final String? numberOfLeadInvestments;

  Investments(
    this.list,
    this.meta,
    this.message,
    this.numberOfInvestments,
    this.numberOfLeadInvestments,
  );

  factory Investments.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestmentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestmentsToJson(this);
}
