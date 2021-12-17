// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaModel _$MetaModelFromJson(Map<String, dynamic> json) {
  return MetaModel(
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
     fundingRoundText: json['funding_round_text'] as String?,
    investmentsText: json['investments_text'] as String?,
    investorsText: json['investors_text'] as String?,
  );
}

Map<String, dynamic> _$MetaModelToJson(MetaModel instance) => <String, dynamic>{
      'pagination': instance.pagination,
      'funding_round_text': instance.fundingRoundText,
      'investments_text': instance.investmentsText,
      'investors_text': instance.investorsText
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return Pagination(
    total: json['total'] as int?,
    pagCount: json['count'] as int?,
    perPage: json['per_page'] as int?,
    currentPage: json['current_page'] as int?,
    totalPages: json['total_pages'] as int?,
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'count': instance.pagCount,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'links': instance.links,
    };

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    next: json['next'] as String?,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'next': instance.next,
    };
