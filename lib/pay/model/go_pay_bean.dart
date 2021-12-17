import 'package:json_annotation/json_annotation.dart';

part 'go_pay_bean.g.dart';

@JsonSerializable()
class GoPayBean {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  late GoPayModel? goPayModel;

  @JsonKey(name: 'pay_status')
  final int? payStatus;

  GoPayBean(
    this.message,
    this.goPayModel,
    this.payStatus,
  );

  factory GoPayBean.fromJson(Map<String, dynamic> srcJson) =>
      _$GoPayBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoPayBeanToJson(this);
}

@JsonSerializable()
class GoPayModel {
  @JsonKey(name: 'order_on')
  final String? orderOn;

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'status')
  final bool? status;

  GoPayModel(
    this.orderOn,
    this.url,
    this.status,
  );

  factory GoPayModel.fromJson(Map<String, dynamic> srcJson) =>
      _$GoPayModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoPayModelToJson(this);
}

@JsonSerializable()
class GoProductsModel {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  late Map<String, String>? goPayModel;

  GoProductsModel(
    this.message,
    this.goPayModel,
  );

  factory GoProductsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$GoProductsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GoProductsModelToJson(this);
}
