import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'status')
  final int? status; //0成功 1失败

  @JsonKey(name: 'favorite_count')
  final int? favoriteCount; //关注的个数

  @JsonKey(name: 'collectResult')
  late Map<String, String>? collectResult;

  StatusModel({
    this.message,
    this.status,
    this.favoriteCount,
    this.collectResult,
  });

  factory StatusModel.fromJson(Map<String, dynamic> srcJson) =>
      _$StatusModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
