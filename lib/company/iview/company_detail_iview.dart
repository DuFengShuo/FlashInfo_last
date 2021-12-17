import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/models/albums_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/models/finance_rounds_bean.dart';
import 'package:flashinfo/company/models/investments_bean.dart';
import 'package:flashinfo/company/models/investors_bean.dart';
import 'package:flashinfo/company/provider/company_provider.dart';
import 'package:flashinfo/company/widget/details/gallery_example_item.dart';
import 'package:flashinfo/dashboard/models/news_bean.dart';
import 'package:flashinfo/mvp/mvps.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';

abstract class CompanyDetialIMvpView implements IMvpView {
  CompanyProvider get companyProvider;

  BaseListProvider<CompanyModel> get companyListProvider;
  BaseListProvider<PeoplesModel> get peopleContactProvider;
}

abstract class BrandEmployeeIMvpView implements IMvpView {
  BaseListProvider<EmployeesModel> get brandPeopleProvider;
}

abstract class CompanyEmployeeIMvpView implements IMvpView {
  BaseListProvider<PeoplesModel> get employeePeopleProvider;
}

abstract class CompanyProductsIMvpView implements IMvpView {
  BaseListProvider<ProductsModel> get companyProductsProvider;
}

abstract class CompanyAlbumsIMvpView implements IMvpView {
  BaseListProvider<AlbumsModel> get companyAlbumsProvider;
  List<GalleryExampleItem> get galleryItems;
}

abstract class CompanyNewsIMvpView implements IMvpView {
  BaseListProvider<BrandNewModel> get companyNewsProvider;
}

abstract class CompanyCommandIMvpView implements IMvpView {
  BaseListProvider<CompanyModel> get companyCommandProvider;
}

abstract class CompanyReviewsIMvpView implements IMvpView {
  BaseListProvider<ReviewsModel> get companyReviewsProvider;
}

abstract class CompanyFinanceRoundsIMvpView implements IMvpView {
  BaseListProvider<FinanceRoundsModel> get companyFinanceRoundsProvider;
}

abstract class CompanyInvestmentsIMvpView implements IMvpView {
  BaseListProvider<InvestmentsModel> get companyInvestmentsProvider;
}

abstract class CompanyInvestorsIMvpView implements IMvpView {
  BaseListProvider<InvestorsModel> get companyInvestorsProvider;
}

abstract class PeopleUnlockIMvpView implements IMvpView {}

abstract class StafflevelIMvpView implements IMvpView {}

abstract class CompanyBranchesIMvpView implements IMvpView {
  BaseListProvider<BranchesModel> get companyBranchesListProvider;
}

abstract class CompanyBusinessIMvpView implements IMvpView {
  BaseListProvider<BusinessModel> get companyBusinessListProvider;
}

abstract class CompanyOfficerIMvpView implements IMvpView {
  BaseListProvider<OfficersModel> get companyOfficerListProvider;
}
