import 'package:flashinfo/favourites/model/collects_list_beam.dart';
import 'package:flashinfo/favourites/model/tags_bean.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class TagsIMvpView implements IMvpView {
  BaseListProvider<TagsModel> get tagsListProvider;
}

abstract class CollectsIMvpView implements IMvpView {}

abstract class CollectsListIMvpView implements IMvpView {
  BaseListProvider<CompanyTagModel> get collectsListProvider;

  BaseListProvider<CompanyTagModel> get companyTagListProvider;
  BaseListProvider<PersonnelTagModel> get peopleTagListProvider;
  BaseListProvider<ProductTagModel> get productTagListProvider;
  BaseListProvider<BrandTagModel> get brandTagListProvider;
}
