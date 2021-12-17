// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_pay_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoPayBean _$GoPayBeanFromJson(Map<String, dynamic> json) {
  return GoPayBean(
    json['message'] as String?,
    json['data'] == null
        ? null
        : GoPayModel.fromJson(json['data'] as Map<String, dynamic>),
    json['pay_status'] as int?,
  );
}

Map<String, dynamic> _$GoPayBeanToJson(GoPayBean instance) => <String, dynamic>{
      'message': instance.message,
      'data': instance.goPayModel,
      'pay_status': instance.payStatus,
    };

GoPayModel _$GoPayModelFromJson(Map<String, dynamic> json) {
  return GoPayModel(
    json['order_on'] as String?,
    json['url'] as String?,
    json['status'] as bool?,
  );
}

Map<String, dynamic> _$GoPayModelToJson(GoPayModel instance) =>
    <String, dynamic>{
      'order_on': instance.orderOn,
      'url': instance.url,
      'status': instance.status,
    };

GoProductsModel _$GoProductsModelFromJson(Map<String, dynamic> json) {
  return GoProductsModel(
    json['message'] as String?,
    (json['data'] as Map<String, dynamic>?)?.map(
      (k, dynamic e) => MapEntry(k, e as String),
    ),
  );
}

Map<String, dynamic> _$GoProductsModelToJson(GoProductsModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.goPayModel,
    };
