import 'package:flashinfo/personal/model/peoples_new_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'colleagues_bean.g.dart';


@JsonSerializable()
class ColleaguesBean {

  @JsonKey(name: 'data')
  late List<Colleagues> dataList;

  @JsonKey(name: 'message')
  final String message;

  ColleaguesBean(this.dataList,this.message,);

  factory ColleaguesBean.fromJson(Map<String, dynamic> srcJson) => _$ColleaguesBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ColleaguesBeanToJson(this);

}



