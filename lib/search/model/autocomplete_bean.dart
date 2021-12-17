import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_bean.g.dart';

@JsonSerializable()
class AutocompleteBean {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  late List<AutocompleteModel>? list;

  AutocompleteBean(
    this.list,
    this.message,
  );

  factory AutocompleteBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AutocompleteBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AutocompleteBeanToJson(this);
}

@JsonSerializable()
class AutocompleteModel {
  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'country_img')
  late CountryImg? countryImg;
  AutocompleteModel(
    this.country,
    this.name,
    this.logo,
    this.id,
    this.countryImg,
  );

  factory AutocompleteModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AutocompleteModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AutocompleteModelToJson(this);
}
