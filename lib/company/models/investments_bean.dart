import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'investments_bean.g.dart';

@JsonSerializable()
class InvestmentsBean {
  @JsonKey(name: 'data')
  late List<InvestmentsModel>? list;
  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  InvestmentsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory InvestmentsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestmentsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestmentsBeanToJson(this);
}

@JsonSerializable()
class InvestmentsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'announced_date')
  final String? announcedDate;

  @JsonKey(name: 'organization_id')
  final String? organizationId;

  @JsonKey(name: 'organization_name')
  final String? organizationName;

  @JsonKey(name: 'organization_logo')
  final String? organizationLogo;

  @JsonKey(name: 'is_lead_investor')
  final int? isLeadInvestor;

  @JsonKey(name: 'funding_round_id')
  final String? fundingRoundId;

  @JsonKey(name: 'funding_round_name')
  final String? fundingRoundName;

  @JsonKey(name: 'funding_round_logo')
  final String? fundingRoundLogo;

  @JsonKey(name: 'money_raised')
  final String? moneyRaised;

  InvestmentsModel(
    this.id,
    this.announcedDate,
    this.organizationId,
    this.organizationName,
    this.organizationLogo,
    this.isLeadInvestor,
    this.fundingRoundId,
    this.fundingRoundName,
    this.fundingRoundLogo,
    this.moneyRaised,
  );

  factory InvestmentsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestmentsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestmentsModelToJson(this);
}
