import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/profile/model/export_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class ExportIMvpView implements IMvpView {
  BaseListProvider<ExportModel> get exportListProvider;
}
