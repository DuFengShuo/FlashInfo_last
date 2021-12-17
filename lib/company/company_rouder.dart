import 'package:flashinfo/brand/models/brand_bean.dart';
import 'package:flashinfo/company/models/company_details_bean.dart';
import 'package:flashinfo/company/page/branches/company_branches_list_page.dart';
import 'package:flashinfo/company/page/business/company_detail_buiness_list_page.dart';
import 'package:flashinfo/company/page/company_benifits_page.dart';
import 'package:flashinfo/company/page/finance/company_finance_detail.dart';
import 'package:flashinfo/company/page/officers/company_detail_officers_list_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flashinfo/routers/i_router.dart';
import 'models/company_bean.dart';
import 'page/company_album_page.dart';
import 'page/company_command_page.dart';
import 'page/company_details_page.dart';
import 'page/company_org_chart_page.dart';
import 'page/employee/company_employee_page.dart';
import 'page/company_news_page.dart';
import 'page/company_products_page.dart';
import 'page/reviews/company_rate_reviews_page.dart';
import 'page/reviews/company_reviews_details_page.dart';
import 'page/reviews/company_reviews_page.dart';

class CompanyRouder implements IRouterProvider {
  static String companyDetailsPage = '/companyDetails';
  static String companyEmployeePage = '/companyEmployee';
  static String companyProductsPage = '/companyProducts';
  static String companyAlbumPage = '/companyAlbum';
  static String companyNewsPage = '/companyNews';
  static String companyCommandPage = '/companyCommand';
  static String companyReviewsPage = '/companyReviews';
  static String companyReviewsDetailsPage = '/companyReviewsDetails';
  static String companyRateReviewsPage = '/companyRateReviews';
  static String companyOrgChartPage = '/companyOrgChart';
  static String companyFinanceDetail = '/companyFinanceDetail';
  static String companyWelfareDetail = '/companyWelfareDetail'; //公司福利
  static String companyBranchesList = '/companyBranchesList'; //公司branches
  static String companyBusinessList = '/companyBusinessList'; //公司business
  static String companyOfficersList = '/companyOfficersList'; //公司officers
  @override
  void initRouter(FluroRouter router) {
    router.define(companyDetailsPage,
        handler: Handler(handlerFunc: (context, params) {
      final String companyId = params['companyId']?.first ?? '';
      final String isToIndex = params['isToIndex']?.first ?? '';
      final args = context?.settings?.arguments == null
          ? null
          : context!.settings!.arguments! as CompanyModel;
      return CompanyDetailsPage(
        companyId: companyId,
        model: args,
        isToIndex: isToIndex,
      );
    }));

    router.define(companyEmployeePage,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      final String contact_limit = params['contact_limit']?.first ?? '0';
      return CompanyEmployeePage(
        companyId: companyId,
        contactLimit: int.parse(contact_limit),
      );
    }));

    router.define(companyProductsPage,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyProductsPage(companyId: companyId);
    }));

    router.define(companyBranchesList,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyDetailsBranchesListPage(companyId: companyId);
    }));
    router.define(companyBusinessList,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyBusinessListPage(
        companyId: companyId,
      );
    }));
    router.define(companyOfficersList,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyOfficersListPage(
        companyId: companyId,
      );
    }));

    router.define(companyAlbumPage, handler: Handler(handlerFunc: (_, params) {
      final String relatedId = params['relatedId']?.first ?? '';
      return CompanyAlbumPage(relatedId: relatedId);
    }));
    router.define(companyNewsPage, handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyNewsPage(companyId: companyId);
    }));
    router.define(companyCommandPage,
        handler: Handler(handlerFunc: (_, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyCommandPage(companyId: companyId);
    }));
    router.define(companyReviewsPage,
        handler: Handler(handlerFunc: (_, params) {
      final String relatedId = params['relatedId']?.first ?? '';
      final String pageType = params['pageType']?.first ?? '';
      return CompanyReviewsPage(relatedId: relatedId, pageType: pageType);
    }));
    router.define(companyReviewsDetailsPage,
        handler: Handler(handlerFunc: (context, params) {
      final String relatedId = params['relatedId']?.first ?? '';
      final String pageType = params['pageType']?.first ?? '';

      /// 类参数
      final args = context!.settings!.arguments! as ReviewsModel;
      return CompanyReviewsDetailsPage(
          model: args, relatedId: relatedId, pageType: pageType);
    }));

    router.define(companyRateReviewsPage,
        handler: Handler(handlerFunc: (_, params) {
      final String relatedId = params['relatedId']?.first ?? '';
      final String indexType = params['indexType']?.first ?? '0';
      return CompanyRateReviewsPage(
          relatedId: relatedId, indexType: int.parse(indexType));
    }));

    // router.define(companyOrgChartPage,
    //     handler: Handler(handlerFunc: (_, __) => const CompanyOrgChartPage()));
    router.define(companyOrgChartPage,
        handler: Handler(handlerFunc: (context, params) {
      final String companyId = params['companyId']?.first ?? '';
      return CompanyOrgChartPage(
        companyId: companyId,
      );
    }));
    // router.define(companyFinanceDetail,
    //     handler: Handler(
    //         handlerFunc: (_, __) => const CompanyFinanceDetailWidget()));

    router.define(companyFinanceDetail,
        handler: Handler(handlerFunc: (context, params) {
      final String index = params['index']?.first ?? '';
      final String? companyId = params['companyId']?.first ?? '0';
      // ignore: cast_nullable_to_non_nullable
      final Financials? financials = context!.settings?.arguments as Financials;

      return CompanyFinanceDetailWidget(
        index: int.parse(index),
        companyId: companyId,
        financials: financials,
      );
    }));

    router.define(companyWelfareDetail,
        handler: Handler(handlerFunc: (context, __) {
      final Overview overview =
          // ignore: cast_nullable_to_non_nullable
          context?.settings?.arguments as Overview;

      return CompanyWelfarePage(
        overview: overview,
      );
    }));
  }
//
}
