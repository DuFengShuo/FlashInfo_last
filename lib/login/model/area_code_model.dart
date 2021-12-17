import 'package:json_annotation/json_annotation.dart';

part 'area_code_model.g.dart';

@JsonSerializable()
class AreaCodeModel {
  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_zh')
  final String? nameZh;

  @JsonKey(name: 'code')
  final String? code;

  @JsonKey(name: 'locale')
  final String? locale;

  @JsonKey(name: 'preg')
  final String? preg;

  @JsonKey(name: 'icon')
  final String? icon;

  AreaCodeModel(
    this.nameEn,
    this.nameZh,
    this.code,
    this.locale,
    this.preg,
    this.icon,
  );

  factory AreaCodeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AreaCodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AreaCodeModelToJson(this);
}
