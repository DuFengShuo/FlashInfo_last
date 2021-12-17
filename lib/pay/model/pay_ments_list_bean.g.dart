// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_ments_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayMentsListBean _$PayMentsListBeanFromJson(Map<String, dynamic> json) {
  return PayMentsListBean(
    (json['data'] as List<dynamic>?)
        ?.map((dynamic e) =>
            PayMentsListModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['meta'] == null
        ? null
        : MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    json['message'] as String?,
  );
}

Map<String, dynamic> _$PayMentsListBeanToJson(PayMentsListBean instance) =>
    <String, dynamic>{
      'data': instance.list,
      'meta': instance.meta,
      'message': instance.message,
    };

PayMentsListModel _$PayMentsListModelFromJson(Map<String, dynamic> json) {
  return PayMentsListModel(
    json['id'] as String?,
    json['no'] as String?,
    json['order_status'] as int?,
    json['pay_method'] as String?,
    json['created_at'] as String?,
    json['sku_info'] == null
        ? null
        : SkuInfo.fromJson(json['sku_info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PayMentsListModelToJson(PayMentsListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'order_status': instance.orderStatus,
      'pay_method': instance.payMethod,
      'created_at': instance.createdAt,
      'sku_info': instance.skuInfo,
    };

SkuInfo _$SkuInfoFromJson(Map<String, dynamic> json) {
  return SkuInfo(
    json['sku_id'] as String?,
    json['name'] as String?,
    json['sku_type'] as int?,
    json['sku_subtype'] as int?,
    json['price'] as String?,
    json['expired_at'] as String?,
    json['pieces'] as int?,
  );
}

Map<String, dynamic> _$SkuInfoToJson(SkuInfo instance) => <String, dynamic>{
      'sku_id': instance.skuId,
      'name': instance.name,
      'sku_type': instance.skuType,
      'sku_subtype': instance.skuSubtype,
      'price': instance.price,
      'expired_at': instance.expiredAt,
      'pieces': instance.pieces,
    };
