// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteBean _$AutocompleteBeanFromJson(Map<String, dynamic> json) {
  return AutocompleteBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            AutocompleteModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$AutocompleteBeanToJson(AutocompleteBean instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.list,
    };

AutocompleteModel _$AutocompleteModelFromJson(Map<String, dynamic> json) {
  return AutocompleteModel(
    json['country'] as String?,
    json['name'] as String?,
    json['logo'] as String?,
    json['id'] as String?,
    json['country_img'] == null
        ? null
        : CountryImg.fromJson(json['country_img'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AutocompleteModelToJson(AutocompleteModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'name': instance.name,
      'logo': instance.logo,
      'id': instance.id,
      'country_img': instance.countryImg,
    };
