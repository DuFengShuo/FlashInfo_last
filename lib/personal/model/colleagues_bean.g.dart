// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'colleagues_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColleaguesBean _$ColleaguesBeanFromJson(Map<String, dynamic> json) =>
    ColleaguesBean(
      (json['data'] as List<dynamic>)
          .map((dynamic e) => Colleagues.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as String,
    );

Map<String, dynamic> _$ColleaguesBeanToJson(ColleaguesBean instance) =>
    <String, dynamic>{
      'data': instance.dataList,
      'message': instance.message,
    };
