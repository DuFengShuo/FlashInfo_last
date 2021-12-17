import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/dashboard/models/recommend_bean.dart';
import 'package:flashinfo/mvp/base_page_presenter.dart';
import 'package:flashinfo/mvp/meta_model.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/profile/page/export/export_page.dart';
import 'package:flashinfo/profile/profile_router.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/iview/search_iview.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/Layout/state_layout.dart';
import 'package:flustars/flustars.dart';
import 'dart:convert' as convert;

class SearchFilter {
  int? isWebsite;
  int? isContact;
  int? revenueMin;
  int? revenueMax;
  int? yearMin;
  int? yearMax;
  String? country;
  String? industry;
  SearchFilter({
    this.isWebsite = 0,
    this.isContact = 0,
    this.revenueMin = 0,
    this.revenueMax = 0,
    this.yearMin = 0,
    this.yearMax = 0,
    this.country = '',
    this.industry = '',
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['is_website'] = isWebsite;
    map['is_contact'] = isContact;
    map['revenue_min'] = revenueMin;
    map['revenue_max'] = revenueMax;
    map['year_min'] = yearMin;
    map['year_max'] = yearMax;
    map['country'] = country;
    map['industry'] = industry;
    return map;
  }
}

class SearchPresenter extends BasePagePresenter<SearchIMvpView> {
  int indexType = 0;
  int _searchPage = 1;
  String _urlType = HttpApi.search;
  String _modelType = 'full';
  StateType _stateType = StateType.company;
  SearchFilter searchCompanyFilter = SearchFilter();
  SearchFilter searchPersonnelFilter = SearchFilter();
  SearchFilter searchProductFilter = SearchFilter();
  @override
  void initState() {
    super.initState();
    setInitType();
  }

  //修改分组
  Future<void> sendAnalyticsEvent() async {
    await FireBaseAnalyticUtil.analytics
        .logEvent(
      name: 'export_search',
    )
        .then((value) {
      print('搜索导出');
    });
    // DataFinder.onEventV3("add_group", params: {
    //   "add_group": "value",
    // });
  }

  void setInitType() {
    switch (indexType) {
      case -1:
        _urlType = HttpApi.search;
        _modelType = 'company';
        _stateType = StateType.company;
        break;
      case 0:
        _urlType = HttpApi.searchCompany;
        _modelType = 'company';
        _stateType = StateType.company;
        break;
      case 1:
        _urlType = HttpApi.searchPeople;
        _modelType = 'people';
        _stateType = StateType.personnel;
        break;
      case 2:
        _urlType = HttpApi.searchProduct;
        _modelType = 'product';
        _stateType = StateType.product;
        break;
      default:
    }
    switch (indexType) {
      case 0:
        view.searcCompanyListProvider.setStateTypeNotNotify(_stateType);
        break;
      case 1:
        view.searcPeopleListProvider.setStateTypeNotNotify(_stateType);
        break;
      case 2:
        view.searcProductListProvider.setStateTypeNotNotify(_stateType);
        break;
      default:
    }
  }

  Future searchAutocomplete() {
    return requestNetwork<AutocompleteBean>(Method.get,
        url:
            HttpApi.search + '$_modelType/autocomplete/v2/${view.searchValue}/',
        isShow: false, onSuccess: (AutocompleteBean? bean) async {
      view.autoListProvider.clear();
      view.autoListProvider.setStateType(StateType.company);
      if (bean != null && bean.list != null && bean.list!.isNotEmpty) {
        if ((bean.list?.length ?? 0) > 0) {
          if (!view.autocompleteMenuController.isShow) {
            view.autocompleteMenuController.show(0);
          }
        } else {
          if (view.autocompleteMenuController.isShow) {
            view.autocompleteMenuController.hide();
          }
        }
        view.autoListProvider.addAll(bean.list!);
        view.autoListProvider.setHasMore(bean.list?.length == 20);
      } else {
        view.autoListProvider.setHasMore(false);
        if (view.autocompleteMenuController.isShow) {
          view.autocompleteMenuController.hide();
        }
      }
      if (view.searchValue.trim().isEmpty ||
          view.searchValue.trim().length < 3) {
        view.autoListProvider.clear();
        if (view.autocompleteMenuController.isShow) {
          view.autocompleteMenuController.hide();
        }
      }
      if (bean!.message!.isNotEmpty) {
        Toast.show(bean.message!);
      }
    }, onError: (_, __) {
      view.autoListProvider.setHasMore(false);
    });
  }

  Future<void> searchonRefresh({bool isShowDialog = false}) async {
    _searchPage = 1;
    if (view.searchValue.trim().isEmpty && view.otherString.isEmpty) {
      return;
    }
    switch (indexType) {
      case 0:
        view.searcCompanyListProvider.setStateType(StateType.listLayout);
        break;
      case 1:
        view.searcPeopleListProvider.setStateType(StateType.listLayout);
        break;
      case 2:
        view.searcProductListProvider.setStateType(StateType.listLayout);
        break;
      default:
    }
    await search(isShowDialog);
    if (indexType == 0) {
      await getBrandsList();
    }
  }

  Future<void> searchloadMore() async {
    _searchPage++;
    await search(false);
  }

  Future search(bool isShowDialog) async {
    Map<String, dynamic> params = <String, dynamic>{};
    switch (indexType) {
      case 0:
        params = changeParam(searchCompanyFilter);
        break;
      case 1:
        params = changeParam(searchPersonnelFilter);
        break;
      case 2:
        params = changeParam(searchProductFilter);
        break;
      default:
    }
    params['page'] = _searchPage.toString();
    params['keyword'] = view.otherString == 'all' && view.searchValue.isEmpty
        ? ' '
        : '${view.searchValue}';
    return requestNetwork<RecommendBean>(Method.post,
        url: _urlType,
        params: params,
        isShow: isShowDialog, onSuccess: (RecommendBean? bean) async {
      if (bean != null) {
        // if (bean.message != null && bean.message!.isNotEmpty) {
        //   view.showToast(bean.message!);
        // }
        switch (indexType) {
          case 0:
            searcCompanyList(bean.companyList, bean.meta);
            break;
          case 1:
            searcPeopleList(bean.personnelList, bean.meta);
            break;
          case 2:
            searcProductList(bean.productList, bean.meta);
            break;
          default:
        }
      }
    }, onError: (_, __) {});
  }

  void searcCompanyList(List<CompanyModel>? list, MetaModel? metaModel) {
    view.searcCompanyListProvider.setMetaModel(metaModel);

    if (list == null || list.isEmpty) {
      if (_searchPage == 1) {
        view.searcCompanyListProvider.clear();
      }
      view.searcCompanyListProvider.setStateTypeNotNotify(_stateType);
      view.searcCompanyListProvider.setHasMore(false);
    } else {
      view.searcCompanyListProvider.setHasMore(list.length == 20);
      _setLocalALl(view.searchValue);
      if (_searchPage == 1) {
        view.searcCompanyListProvider.clear();
        view.searcCompanyListProvider.addAll(list);
      } else {
        view.searcCompanyListProvider.addAll(list);
      }
    }
  }

  void searcPeopleList(List<PeoplesModel>? list, MetaModel? metaModel) {
    view.searcPeopleListProvider.setMetaModel(metaModel);
    if (list == null || list.isEmpty) {
      if (_searchPage == 1) {
        view.searcPeopleListProvider.clear();
      }
      view.searcPeopleListProvider.setStateTypeNotNotify(_stateType);
      view.searcPeopleListProvider.setHasMore(false);
    } else {
      view.searcPeopleListProvider.setHasMore(list.length == 20);
      _setLocalALl(view.searchValue);
      if (_searchPage == 1) {
        view.searcPeopleListProvider.clear();
        view.searcPeopleListProvider.addAll(list);
      } else {
        view.searcPeopleListProvider.addAll(list);
      }
    }
  }

  void searcProductList(List<ProductsModel>? list, MetaModel? metaModel) {
    view.searcProductListProvider.setMetaModel(metaModel);
    if (list == null || list.isEmpty) {
      if (_searchPage == 1) {
        view.searcProductListProvider.clear();
      }
      view.searcProductListProvider.setStateTypeNotNotify(_stateType);
      view.searcProductListProvider.setHasMore(false);
    } else {
      view.searcProductListProvider.setHasMore(list.length == 20);
      _setLocalALl(view.searchValue);
      if (_searchPage == 1) {
        view.searcProductListProvider.clear();
        view.searcProductListProvider.addAll(list);
      } else {
        view.searcProductListProvider.addAll(list);
      }
    }
  }

  ///清理当前页面数据
  void clearSearchCurrentPage() {
    switch (indexType) {
      case 0:
        view.searcCompanyListProvider.clear();
        break;
      case 1:
        view.searcPeopleListProvider.clear();
        break;
      case 2:
        view.searcProductListProvider.clear();
        break;
      default:
    }
  }

  Future _setLocalALl(String text) async {
    if (text.isEmpty) {
      return;
    }
    final List<String> ls = SpUtil.getStringList(Constant.localList)!.toList();

    if (ls.contains(text)) {
      ls.removeWhere((v) => v == text);
    }
    ls.insert(0, text);
    await SpUtil.putStringList(Constant.localList, ls);
  }

  Map<String, dynamic> changeParam(SearchFilter model) {
    final Map<String, dynamic> pm = <String, dynamic>{};
    if (model.country!.isNotEmpty) {
      pm['country'] = model.country;
    }
    if (model.industry!.isNotEmpty) {
      pm['industry'] = model.industry;
    }

    if (model.revenueMin == 0 && model.revenueMax == 0) {
    } else {
      pm['revenue_min'] = model.revenueMin;
      pm['revenue_max'] = model.revenueMax;
    }
    if (model.yearMin == 0 && model.yearMax == 0) {
    } else {
      pm['register_year_start'] = model.yearMin;
      pm['register_year_end'] = model.yearMax;
    }
    if (model.isWebsite != 0) {
      pm['is_website'] = model.isWebsite == 1 ? 1 : 0;
    }
    if (model.isContact != 0) {
      pm['is_contact'] = model.isContact == 1 ? 1 : 0;
    }

    return pm;
  }

  void exportParam(SearchFilter model, MetaModel? metaModel) {
    final Map<String, dynamic> conditionList = <String, dynamic>{};
    if (view.searchValue.isNotEmpty) {
      conditionList['KeywordAll'] = view.searchValue;
    }
    if (model.country!.isNotEmpty) {
      conditionList['GeographyAll'] = model.country;
    }
    if (model.industry!.isNotEmpty) {
      conditionList['IndustryAll'] = model.industry!.replaceAll(',', '、');
    }
    if (model.revenueMax == 0 && model.revenueMin == 0) {
    } else {
      final String yearStart = model.revenueMin == 0
          ? '<='
          : (model.revenueMax == 0
              ? '>=' + model.revenueMin.toString()
              : model.revenueMin.toString());
      final String year =
          (model.revenueMin != 0 && model.revenueMax != 0) ? '-' : '';
      final String yearEnd =
          model.revenueMax == 0 ? '' : model.revenueMax.toString();
      conditionList['Fund Amount(millions)'] = yearStart + year + yearEnd;
    }
    if (model.yearMax == 0 && model.yearMin == 0) {
    } else {
      final String yearMin = model.yearMin == 0
          ? '<='
          : (model.yearMax == 0
              ? '>=' + model.yearMin.toString()
              : model.yearMin.toString());
      final String year = (model.yearMin != 0 && model.yearMax != 0) ? '-' : '';
      final String yearEnd = model.yearMax == 0 ? '' : model.yearMax.toString();
      conditionList['Founder year'] = yearMin + year + yearEnd;
    }
    if (model.isWebsite != 0) {
      final String website = model.isWebsite == 1 ? 'with' : 'without';
      conditionList['Website'] = website;
    }
    if (model.isContact != 0) {
      final String number = model.isContact == 1 ? 'with' : 'without';
      conditionList['Contact Number'] = number;
    }
    final ExportStoreParams exportStoreParams = ExportStoreParams();
    exportStoreParams.exportCount = metaModel?.pagination?.total ?? 0;
    exportStoreParams.source = 'search';
    exportStoreParams.url = Constant.baseUrl + _urlType + view.searchValue;
    exportStoreParams.requestMethod = 'get';
    exportStoreParams.modelType = ExportStoreType.values[indexType]
        .toString()
        .replaceAll('ExportStoreType.', '');
    exportStoreParams.isSendMail = 1;
    if (changeParam(model).isNotEmpty) {
      exportStoreParams.searchCondition =
          convert.json.encode(changeParam(model));
    }
    if (conditionList.isNotEmpty) {
      exportStoreParams.viewCondition = convert.jsonEncode(conditionList);
    }
    NavigatorUtils.pushResult(view.getContext(), ProfileRouter.exportPage,
        (value) {
      print(value);
    }, arguments: exportStoreParams);
    // print(model.toJson());
  }

  ///获取品牌列表
  Future getBrandsList() async {
    final Map<String, dynamic> params = <String, dynamic>{};
    params['page'] = 1;
    params['keyword'] = view.otherString == 'all' && view.searchValue.isEmpty
        ? ''
        : '${view.searchValue}';
    return requestNetwork<BrandListBean>(Method.post,
        url: HttpApi.searchBrands,
        params: params,
        isShow: false, onSuccess: (BrandListBean? bean) async {
      view.searcBrandListProvider.clear();
      view.searcBrandListProvider.setMetaModel(bean?.meta);
      if (bean != null && bean.company != null) {
        view.searcBrandListProvider.addAll(bean.company!);
      }
    }, onError: (_, __) {});
  }
}

class SearchCachePresenter extends BasePagePresenter<SearchCacheIMvpView> {
  Future searchAutocomplete({Function(bool)? loginSuccess}) {
    return requestNetwork<AutocompleteBean>(Method.get,
        url: HttpApi.search + 'company/autocomplete/v2/${view.searchValue}/',
        isShow: false, onSuccess: (AutocompleteBean? bean) async {
      view.autoListProvider.clear();
      view.autoListProvider.setStateType(StateType.company);

      if (bean != null && bean.list != null && bean.list!.isNotEmpty) {
        view.autoListProvider.clear();
        view.autoListProvider.addAll(bean.list!);
        loginSuccess!(true);
      } else {
        loginSuccess!(false);
      }
    }, onError: (_, __) {
      view.autoListProvider.setHasMore(false);
    });
  }
}
