import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'investors_bean.g.dart';

@JsonSerializable()
class InvestorsBean {
  @JsonKey(name: 'data')
  late List<InvestorsModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  InvestorsBean(
    this.list,
    this.meta,
    this.message,
  );

  factory InvestorsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestorsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestorsBeanToJson(this);
}

@JsonSerializable()
class InvestorsModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'funding_round_id')
  final String? fundingRoundId;

  @JsonKey(name: 'funding_round_logo')
  final String? fundingRoundLogo;

  @JsonKey(name: 'funding_round_name')
  final String? fundingRoundName;

  @JsonKey(name: 'invest_type')
  final int? investType;

  @JsonKey(name: 'invest_id')
  final String? investId;

  @JsonKey(name: 'invest_logo')
  final String? investLogo;

  @JsonKey(name: 'invest_name')
  final String? investName;

  @JsonKey(name: 'is_lead_investor')
  final int? isLeadInvestor;

  @JsonKey(name: 'partners_type')
  final int? partnersType;

  @JsonKey(name: 'partners_id')
  final String? partnersId;

  @JsonKey(name: 'partners_logo')
  final String? partnersLogo;

  @JsonKey(name: 'partners_name')
  final String? partnersName;

  InvestorsModel(
    this.id,
    this.fundingRoundId,
    this.fundingRoundLogo,
    this.fundingRoundName,
    this.investType,
    this.investId,
    this.investLogo,
    this.investName,
    this.isLeadInvestor,
    this.partnersType,
    this.partnersId,
    this.partnersLogo,
    this.partnersName,
  );

  factory InvestorsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$InvestorsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InvestorsModelToJson(this);
}
