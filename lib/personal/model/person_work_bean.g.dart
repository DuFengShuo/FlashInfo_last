// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_work_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonWorkBean _$PersonWorkBeanFromJson(Map<String, dynamic> json) {
  return PersonWorkBean(
    json['current_page'] as int,
    (json['data'] as List<dynamic>)
        .map((dynamic e) => WorkData.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['first_page_url'] as String,
    json['from'] as int,
    json['last_page'] as int,
    json['last_page_url'] as String,
    json['path'] as String,
    json['per_page'] as int,
    json['to'] as int,
    json['total'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$PersonWorkBeanToJson(PersonWorkBean instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'last_page': instance.lastPage,
      'last_page_url': instance.lastPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'to': instance.to,
      'total': instance.total,
      'message': instance.message,
    };

WorkData _$WorkDataFromJson(Map<String, dynamic> json) {
  return WorkData(
    json['id'] as String,
    json['company_id'] as String,
    json['company_name'] as String,
    json['company_logo'] as String,
    json['company_address'] as String,
    json['entity_type'] as int,
    (json['work'] as List<dynamic>)
        .map((dynamic e) => Work.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WorkDataToJson(WorkData instance) => <String, dynamic>{
      'id': instance.id,
      'company_id': instance.companyId,
      'company_name': instance.companyName,
      'company_logo': instance.companyLogo,
      'company_address': instance.companyAddress,
      'entity_type': instance.entityType,
      'work': instance.work,
    };

Work _$WorkFromJson(Map<String, dynamic> json) {
  return Work(
    json['position'] as String,
    json['desc'] as String,
    json['total_time'] as String,
    json['entry_time'] as String,
    json['leave_time'] as String,
  );
}

Map<String, dynamic> _$WorkToJson(Work instance) => <String, dynamic>{
      'position': instance.position,
      'desc': instance.desc,
      'total_time': instance.totalTime,
      'entry_time': instance.entryTime,
      'leave_time': instance.leaveTime,
    };
