import 'dart:convert';
import 'package:azlistview/azlistview.dart';

class ContactInfo extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;
  String? code;
  String? icon;
  ContactInfo(
      {required this.name,
      this.tagIndex,
      this.namePinyin,
      this.code,
      this.icon});

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
