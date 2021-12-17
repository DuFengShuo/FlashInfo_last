import 'package:flashinfo/mvp/meta_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_ments_list_bean.g.dart';

@JsonSerializable()
class PayMentsListBean {
  @JsonKey(name: 'data')
  late List<PayMentsListModel>? list;

  @JsonKey(name: 'meta')
  late MetaModel? meta;

  @JsonKey(name: 'message')
  final String? message;

  PayMentsListBean(
    this.list,
    this.meta,
    this.message,
  );

  factory PayMentsListBean.fromJson(Map<String, dynamic> srcJson) =>
      _$PayMentsListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayMentsListBeanToJson(this);
}

@JsonSerializable()
class PayMentsListModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'no')
  final String? no;

  @JsonKey(name: 'order_status')
  final int? orderStatus;

  @JsonKey(name: 'pay_method')
  final String? payMethod;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'sku_info')
  late SkuInfo? skuInfo;

  PayMentsListModel(
    this.id,
    this.no,
    this.orderStatus,
    this.payMethod,
    this.createdAt,
    this.skuInfo,
  );

  factory PayMentsListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PayMentsListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayMentsListModelToJson(this);
}

@JsonSerializable()
class SkuInfo {
  @JsonKey(name: 'sku_id')
  final String? skuId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'sku_type')
  final int? skuType;

  @JsonKey(name: 'sku_subtype')
  final int? skuSubtype;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'expired_at')
  final String? expiredAt;

  @JsonKey(name: 'pieces')
  final int? pieces;

  SkuInfo(
    this.skuId,
    this.name,
    this.skuType,
    this.skuSubtype,
    this.price,
    this.expiredAt,
    this.pieces,
  );

  factory SkuInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$SkuInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SkuInfoToJson(this);
}
