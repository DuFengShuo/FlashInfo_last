// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_rounds_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceRoundsBean _$FinanceRoundsBeanFromJson(Map<String, dynamic> json) {
  return FinanceRoundsBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            FinanceRoundsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$FinanceRoundsBeanToJson(FinanceRoundsBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

FinanceRoundsModel _$FinanceRoundsModelFromJson(Map<String, dynamic> json) {
  return FinanceRoundsModel(
    json['id'] as String?,
    json['company_id'] as String?,
    json['announced_date'] as String?,
    json['logo'] as String?,
    json['name'] as String?,
    json['number_of_investors'] as String?,
    json['money_raised'] as String?,
    json['lead_investors_type'] as String?,
    json['lead_investors_name'] as String?,
    json['lead_investors_related_id'] as String?,
  );
}

Map<String, dynamic> _$FinanceRoundsModelToJson(FinanceRoundsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'announced_date': instance.announcedDate,
      'logo': instance.logo,
      'name': instance.name,
      'number_of_investors': instance.numberOfInvestors,
      'money_raised': instance.moneyRaised,
      'lead_investors_type': instance.leadInvestorsType,
      'lead_investors_name': instance.leadInvestorsName,
      'lead_investors_related_id': instance.leadInvestorsRelatedId,
    };
