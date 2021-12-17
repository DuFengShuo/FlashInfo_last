import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status_code')
  final int? statusCode;

  BaseModel({
    this.message,
    this.statusCode,
  });

  factory BaseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BaseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
