import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class DashboardIMvpView implements IMvpView {
  BaseListProvider<BrandNewModel> get newsListProvider;
}

abstract class NewsIMvpView implements IMvpView {}
