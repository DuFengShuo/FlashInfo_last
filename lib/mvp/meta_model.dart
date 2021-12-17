import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable()
class MetaModel {
  @JsonKey(name: 'pagination')
  final Pagination? pagination;
  @JsonKey(name: 'funding_round_text')
  final String? fundingRoundText;
  @JsonKey(name: 'investors_text')
  final String? investorsText;
  @JsonKey(name: 'investments_text')
  final String? investmentsText;
  MetaModel({
    this.pagination,
    this.fundingRoundText,
    this.investorsText,
    this.investmentsText
  });

  factory MetaModel.fromJson(Map<String, dynamic> srcJson) =>
      _$MetaModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'count')
  final int? pagCount;

  @JsonKey(name: 'per_page')
  final int? perPage;

  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: 'total_pages')
  final int? totalPages;

  @JsonKey(name: 'links')
  final Links? links;

  Pagination({
    this.total,
    this.pagCount,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> srcJson) =>
      _$PaginationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class Links {
  @JsonKey(name: 'next')
  final String? next;

  Links({
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> srcJson) =>
      _$LinksFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
