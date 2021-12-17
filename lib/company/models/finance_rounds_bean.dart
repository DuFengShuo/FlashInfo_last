import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finance_rounds_bean.g.dart';

@JsonSerializable()
class FinanceRoundsBean {
  @JsonKey(name: 'data')
  late List<FinanceRoundsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  FinanceRoundsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory FinanceRoundsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$FinanceRoundsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FinanceRoundsBeanToJson(this);
}

@JsonSerializable()
class FinanceRoundsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'company_id')
  final String? companyId;

  @JsonKey(name: 'announced_date')
  final String? announcedDate;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'number_of_investors')
  final String? numberOfInvestors;

  @JsonKey(name: 'money_raised')
  final String? moneyRaised;

  @JsonKey(name: 'lead_investors_type')
  final String? leadInvestorsType;

  @JsonKey(name: 'lead_investors_name')
  final String? leadInvestorsName;

  @JsonKey(name: 'lead_investors_related_id')
  final String? leadInvestorsRelatedId;

  FinanceRoundsModel(
    this.id,
    this.companyId,
    this.announcedDate,
    this.logo,
    this.name,
    this.numberOfInvestors,
    this.moneyRaised,
    this.leadInvestorsType,
    this.leadInvestorsName,
    this.leadInvestorsRelatedId,
  );

  factory FinanceRoundsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$FinanceRoundsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FinanceRoundsModelToJson(this);
}
