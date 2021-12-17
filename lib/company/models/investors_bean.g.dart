// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investors_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestorsBean _$InvestorsBeanFromJson(Map<String, dynamic> json) {
  return InvestorsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) => InvestorsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$InvestorsBeanToJson(InvestorsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

InvestorsModel _$InvestorsModelFromJson(Map<String, dynamic> json) {
  return InvestorsModel(
    json['id'] as String?,
    json['funding_round_id'] as String?,
    json['funding_round_logo'] as String?,
    json['funding_round_name'] as String?,
    json['invest_type'] as int?,
    json['invest_id'] as String?,
    json['invest_logo'] as String?,
    json['invest_name'] as String?,
    json['is_lead_investor'] as int?,
    json['partners_type'] as int?,
    json['partners_id'] as String?,
    json['partners_logo'] as String?,
    json['partners_name'] as String?,
  );
}

Map<String, dynamic> _$InvestorsModelToJson(InvestorsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'funding_round_id': instance.fundingRoundId,
      'funding_round_logo': instance.fundingRoundLogo,
      'funding_round_name': instance.fundingRoundName,
      'invest_type': instance.investType,
      'invest_id': instance.investId,
      'invest_logo': instance.investLogo,
      'invest_name': instance.investName,
      'is_lead_investor': instance.isLeadInvestor,
      'partners_type': instance.partnersType,
      'partners_id': instance.partnersId,
      'partners_logo': instance.partnersLogo,
      'partners_name': instance.partnersName,
    };
