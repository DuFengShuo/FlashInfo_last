import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/profile/model/browsing_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class BrowsingIMvpView implements IMvpView {
  BaseListProvider<BrowsingModel> get browsingProvider;
}
