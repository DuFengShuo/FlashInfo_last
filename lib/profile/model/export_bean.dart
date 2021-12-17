import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_bean.g.dart';

@JsonSerializable()
class ExportBean {
  @JsonKey(name: 'data')
  final List<ExportModel>? list;

  @JsonKey(name: 'meta')
  final MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  ExportBean(
    this.list,
    this.meta,
    this.message,
  );

  factory ExportBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ExportBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExportBeanToJson(this);
}

@JsonSerializable()
class ExportModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'export_quantity')
  final int? exportQuantity;

  @JsonKey(name: 'format')
  final String? format;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'send_status')
  final int? sendStatus;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'model_type')
  final int? modelType;

  @JsonKey(name: 'download_path')
  final String? downloadPath;

  @JsonKey(name: 'condition')
  final Map<String, dynamic>? condition;

  @JsonKey(name: 'vip_data')
  late VipData? vipData;
  @JsonKey(name: 'message')
  final String? message;
  ExportModel(
    this.id,
    this.exportQuantity,
    this.format,
    this.email,
    this.sendStatus,
    this.source,
    this.createdAt,
    this.modelType,
    this.downloadPath,
    this.condition,
    this.message,
    this.vipData,
  );

  factory ExportModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ExportModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExportModelToJson(this);
}

// @JsonSerializable()
// class Condition {
//   @JsonKey(name: 'type')
//   final String? type;

//   @JsonKey(name: 'modelType')
//   final String? modelType;

//   @JsonKey(name: 'groupName')
//   final String? groupName;

//   Condition(
//     this.type,
//     this.modelType,
//     this.groupName,
//   );

//   factory Condition.fromJson(Map<String, dynamic> srcJson) =>
//       _$ConditionFromJson(srcJson);

//   Map<String, dynamic> toJson() => _$ConditionToJson(this);
// }
