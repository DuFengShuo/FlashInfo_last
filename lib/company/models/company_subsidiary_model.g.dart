// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_subsidiary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanySubsidiaryModel _$CompanySubsidiaryModelFromJson(
    Map<String, dynamic> json) {
  return CompanySubsidiaryModel(
    json['branch'] == null
        ? null
        : Branch.fromJson(json['branch'] as Map<String, dynamic>),
    json['albums'] == null
        ? null
        : Albums.fromJson(json['albums'] as Map<String, dynamic>),
    json['similar_companies'] == null
        ? null
        : SimilarCompanies.fromJson(
            json['similar_companies'] as Map<String, dynamic>),
    json['news'] == null
        ? null
        : News.fromJson(json['news'] as Map<String, dynamic>),
    json['funding_rounds'] == null
        ? null
        : FundingRounds.fromJson(
            json['funding_rounds'] as Map<String, dynamic>),
    json['investors'] == null
        ? null
        : Investors.fromJson(json['investors'] as Map<String, dynamic>),
    json['investments'] == null
        ? null
        : Investments.fromJson(json['investments'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$CompanySubsidiaryModelToJson(
        CompanySubsidiaryModel instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'albums': instance.albums,
      'similar_companies': instance.similarCompanies,
      'news': instance.news,
      'funding_rounds': instance.fundingRounds,
      'investors': instance.investors,
      'investments': instance.investments,
      'message': instance.message,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return Branch(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => CompanyModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
  );
}

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'data': instance.list,
      'total': instance.total,
    };

Albums _$AlbumsFromJson(Map<String, dynamic> json) {
  return Albums(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => AlbumsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
    json['total'] as int?,
  );
}

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
      'total': instance.total,
    };

AlbumsModel _$AlbumsModelFromJson(Map<String, dynamic> json) {
  return AlbumsModel(
    json['id'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
  );
}

Map<String, dynamic> _$AlbumsModelToJson(AlbumsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

SimilarCompanies _$SimilarCompaniesFromJson(Map<String, dynamic> json) {
  return SimilarCompanies(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            SimilarCompaniesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
  );
}

Map<String, dynamic> _$SimilarCompaniesToJson(SimilarCompanies instance) =>
    <String, dynamic>{
      'data': instance.list,
      'total': instance.total,
    };

SimilarCompaniesModel _$SimilarCompaniesModelFromJson(
    Map<String, dynamic> json) {
  return SimilarCompaniesModel(
    json['id'] as String?,
    json['logo'] as String?,
    json['name'] as String?,
    (json['industry'] as List<dynamic>?)
        ?.map((dynamic e) => Industry.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['similar_reasons'] as String?,
  );
}

Map<String, dynamic> _$SimilarCompaniesModelToJson(
        SimilarCompaniesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'name': instance.name,
      'industry': instance.industry,
      'similar_reasons': instance.similarReasons,
    };

Industry _$IndustryFromJson(Map<String, dynamic> json) {
  return Industry(
    json['name'] as String?,
  );
}

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'name': instance.name,
    };

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => NewsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['total'] as int?,
    json['message'] as String?,
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
      'total': instance.total,
    };

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
    json['id'] as String?,
    json['logo'] as String?,
    json['title'] as String?,
    json['desc'] as String?,
    json['source'] as String?,
    json['link'] as String?,
    json['publish_time'] as String?,
  );
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'logo': instance.logo,
      'title': instance.title,
      'desc': instance.desc,
      'source': instance.source,
      'link': instance.link,
      'publish_time': instance.publishTime,
    };

FundingRounds _$FundingRoundsFromJson(Map<String, dynamic> json) {
  return FundingRounds(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            FinanceRoundsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['total'] as int?,
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
    json['number_of_funding_rounds'] as String?,
    json['total_funding_amount'] as String?,
  );
}

Map<String, dynamic> _$FundingRoundsToJson(FundingRounds instance) =>
    <String, dynamic>{
      'data': instance.list,
      'total': instance.total,
      'meta': instance.meta,
      'message': instance.message,
      'number_of_funding_rounds': instance.numberOfFundingRounds,
      'total_funding_amount': instance.totalFundingAmount,
    };

Investors _$InvestorsFromJson(Map<String, dynamic> json) {
  return Investors(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => InvestorsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
    json['number_of_lead_investors'] as String?,
    json['number_of_investors'] as String?,
  );
}

Map<String, dynamic> _$InvestorsToJson(Investors instance) => <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
      'number_of_lead_investors': instance.numberOfLeadInvestors,
      'number_of_investors': instance.numberOfInvestors,
    };

Investments _$InvestmentsFromJson(Map<String, dynamic> json) {
  return Investments(
    (json['data'] as List<dynamic>?)

        ?.map(
            (dynamic e) => InvestmentsModel.fromJson(e as Map<String, dynamic>))

        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
    json['number_of_investments'] as String?,
    json['number_of_lead_investments'] as String?,
  );
}

Map<String, dynamic> _$InvestmentsToJson(Investments instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
      'number_of_investments': instance.numberOfInvestments,
      'number_of_lead_investments': instance.numberOfLeadInvestments,
    };
