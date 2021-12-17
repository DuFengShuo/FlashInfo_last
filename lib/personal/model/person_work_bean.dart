import 'package:json_annotation/json_annotation.dart';

part 'person_work_bean.g.dart';


@JsonSerializable()
class PersonWorkBean extends Object {

  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'data')
  late List<WorkData> data;

  @JsonKey(name: 'first_page_url')
  final String firstPageUrl;

  @JsonKey(name: 'from')
  final int from;

  @JsonKey(name: 'last_page')
  final int lastPage;

  @JsonKey(name: 'last_page_url')
  final String lastPageUrl;

  @JsonKey(name: 'path')
  final String path;

  @JsonKey(name: 'per_page')
  final int perPage;

  @JsonKey(name: 'to')
  final int to;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'message')
  final String message;

  PersonWorkBean(this.currentPage,this.data,this.firstPageUrl,this.from,this.lastPage,this.lastPageUrl,this.path,this.perPage,this.to,this.total,this.message,);

  factory PersonWorkBean.fromJson(Map<String, dynamic> srcJson) => _$PersonWorkBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonWorkBeanToJson(this);

}


@JsonSerializable()
class WorkData extends Object {

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'company_id')
  final String companyId;

  @JsonKey(name: 'company_name')
  final String companyName;

  @JsonKey(name: 'company_logo')
  final String companyLogo;

  @JsonKey(name: 'company_address')
  final String companyAddress;

  @JsonKey(name: 'entity_type')
  final int entityType;

  @JsonKey(name: 'work')
  late List<Work> work;

  WorkData(this.id,this.companyId,this.companyName,this.companyLogo,this.companyAddress,this.entityType, this.work,);

  factory WorkData.fromJson(Map<String, dynamic> srcJson) => _$WorkDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkDataToJson(this);

}


@JsonSerializable()
class Work extends Object {

  @JsonKey(name: 'position')
  final String position;

  @JsonKey(name: 'desc')
  final String desc;

  @JsonKey(name: 'total_time')
  final String totalTime;

  @JsonKey(name: 'entry_time')
  final String entryTime;

  @JsonKey(name: 'leave_time')
  final String leaveTime;

  Work(this.position,this.desc,this.totalTime,this.entryTime,this.leaveTime,);

  factory Work.fromJson(Map<String, dynamic> srcJson) => _$WorkFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorkToJson(this);

}


