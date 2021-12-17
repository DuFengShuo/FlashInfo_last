import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_detail_model.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_details_bean.g.dart';

@JsonSerializable()
class ProductsDetailsBean {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'logo')
  final String? logo;

  @JsonKey(name: 'desc')
  final String? desc;

  @JsonKey(name: 'website')
  final String? website;

  @JsonKey(name: 'background_logo')
  final String? backgroundLogo;

  @JsonKey(name: 'is_collect')
  bool? isCollect;
  @JsonKey(name: 'is_unlock')
  bool? isUnlock;
  @JsonKey(name: 'browsing_count')
  final int? browsingCount;

  @JsonKey(name: 'category')
  late List<Category>? category;

  @JsonKey(name: 'albums')
  final Albums? albums;

  @JsonKey(name: 'company')
  late CompanyModel? company;

  @JsonKey(name: 'comments')
  late Reviews? comments;

  @JsonKey(name: 'message')
  final String? message;

  ProductsDetailsBean(
    this.id,
    this.name,
    this.logo,
    this.desc,
    this.website,
    this.isUnlock,
    this.backgroundLogo,
    this.isCollect,
    this.browsingCount,
    this.category,
    this.albums,
    this.company,
    this.comments,
    this.message,
  );

  factory ProductsDetailsBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductsDetailsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductsDetailsBeanToJson(this);
}

@JsonSerializable()
class Albums {
  @JsonKey(name: 'data')
  final List<AlbumsModel>? list;

  @JsonKey(name: 'total')
  final int? total;

  Albums(
    this.list,
    this.total,
  );

  factory Albums.fromJson(Map<String, dynamic> srcJson) =>
      _$AlbumsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}
