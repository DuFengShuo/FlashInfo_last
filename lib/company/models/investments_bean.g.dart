// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investments_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentsBean _$InvestmentsBeanFromJson(Map<String, dynamic> json) {
  return InvestmentsBean(
    (json['data'] as List<dynamic>?)
        ?.map(
            (dynamic e) => InvestmentsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$InvestmentsBeanToJson(InvestmentsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

InvestmentsModel _$InvestmentsModelFromJson(Map<String, dynamic> json) {
  return InvestmentsModel(
    json['id'] as String?,
    json['announced_date'] as String?,
    json['organization_id'] as String?,
    json['organization_name'] as String?,
    json['organization_logo'] as String?,
    json['is_lead_investor'] as int?,
    json['funding_round_id'] as String?,
    json['funding_round_name'] as String?,
    json['funding_round_logo'] as String?,
    json['money_raised'] as String?,
  );
}

Map<String, dynamic> _$InvestmentsModelToJson(InvestmentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'announced_date': instance.announcedDate,
      'organization_id': instance.organizationId,
      'organization_name': instance.organizationName,
      'organization_logo': instance.organizationLogo,
      'is_lead_investor': instance.isLeadInvestor,
      'funding_round_id': instance.fundingRoundId,
      'funding_round_name': instance.fundingRoundName,
      'funding_round_logo': instance.fundingRoundLogo,
      'money_raised': instance.moneyRaised,
    };
