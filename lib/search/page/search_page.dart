import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/mvp/base_page.dart';
import 'package:flashinfo/mvp/power_presenter.dart';
import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/search/iview/search_iview.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/autocomplete_menu_widget.dart';
import 'package:flashinfo/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

import 'search_company.dart';
import 'search_people.dart';
import 'search_product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {Key? key, this.searchValue, this.indexType, this.otherString})
      : super(key: key);
  final String? searchValue;
  final int? indexType;
  final String? otherString;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with
        SingleTickerProviderStateMixin,
        BasePageMixin<SearchPage, PowerPresenter>
    implements SearchIMvpView {
  late TabController _tabController;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  late GZXDropdownMenuController autocompleteMenuController =
      GZXDropdownMenuController(); //自动补全线上列表
  @override
  int indexType = 0;
  @override
  String searchValue = ''; //搜索框文本
  @override
  String otherString = ''; //其他文本

  ///记下上一个搜索关键词
  final List<String> _cacheTextList = ['', '', ''];
  final List<String> _hintTextList = ['companies', 'contact', 'products'];
  @override
  BaseListProvider<AutocompleteModel> autoListProvider =
      BaseListProvider<AutocompleteModel>();

  ///自动补全
  @override
  BaseListProvider<CompanyModel> searcCompanyListProvider =
      BaseListProvider<CompanyModel>(); //搜索公司结果数据
  @override
  BaseListProvider<PeoplesModel> searcPeopleListProvider =
      BaseListProvider<PeoplesModel>(); //搜索人员结果数据
  @override
  BaseListProvider<ProductsModel> searcProductListProvider =
      BaseListProvider<ProductsModel>(); //搜索产品结果数据
  @override
  BaseListProvider<BrandItemModel> searcBrandListProvider =
      BaseListProvider<BrandItemModel>(); //搜索品牌结果数据
  late final PublishSubject<String> _searchBarsubject =
      PublishSubject<String>();

  @override
  void dispose() {
    super.dispose();
    _searchBarsubject.close();
  }

  @override
  void initState() {
    searchValue = widget.searchValue ?? '';
    indexType = widget.indexType ?? 0;
    otherString = widget.otherString ?? '';
    _cacheTextList[widget.indexType ?? 0] = searchValue;
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _searchPresenter.indexType = widget.indexType ?? 0;
      _tabController.animateTo(widget.indexType ?? 0);
      _pageController.jumpToPage(widget.indexType ?? 0);
      if (searchValue.isNotEmpty || otherString.isNotEmpty) {
        await _searchPresenter.searchonRefresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseListProvider<AutocompleteModel>>(
            create: (_) => autoListProvider),
        ChangeNotifierProvider<BaseListProvider<CompanyModel>>(
            create: (_) => searcCompanyListProvider),
        ChangeNotifierProvider<BaseListProvider<PeoplesModel>>(
            create: (_) => searcPeopleListProvider),
        ChangeNotifierProvider<BaseListProvider<ProductsModel>>(
            create: (_) => searcProductListProvider),
        ChangeNotifierProvider<BaseListProvider<BrandItemModel>>(
            create: (_) => searcBrandListProvider),
      ],
      child: Scaffold(
        backgroundColor: Colours.bg_color,
        appBar: SearchBar(
            onChanged: _searchAutocomplete,
            searchValue: searchValue,
            hintText: 'Search for ${_hintTextList[indexType]}',
            onPressed: _autocompleteItem,
            searchBarsubject: _searchBarsubject),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colours.material_bg,
                  height: 35.h,
                  child: TabBar(
                    onTap: (index) {
                      if (!mounted) {
                        return;
                      }
                      _pageController.jumpToPage(index);
                    },
                    controller: _tabController,
                    labelStyle: TextStyles.textBold13,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colours.text,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorWeight: 2.w,
                    tabs: const <Widget>[
                      Tab(text: 'Companies'),
                      Tab(text: 'People'),
                      Tab(text: 'Products'),
                    ],
                  ),
                ),
                Gaps.line,
                Expanded(
                  child: PageView.builder(
                      key: const Key('pageView'),
                      itemCount: 3,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, int index) {
                        if (index == 0) {
                          return SearchCompany(
                              searchValue: searchValue,
                              searchPresenter: _searchPresenter);
                        } else if (index == 1) {
                          return SearchPeople(
                              searchValue: searchValue,
                              searchPresenter: _searchPresenter);
                        } else {
                          return SearchProduct(
                              searchValue: searchValue,
                              searchPresenter: _searchPresenter);
                        }
                      }),
                )
              ],
            ),
            //自动补全下拉框
            Consumer<BaseListProvider<AutocompleteModel>>(
                builder: (_, provider, __) {
              return AutocompleteMenuWidget(
                autocompleteList: provider.list,
                dropdownMenuController: autocompleteMenuController,
                onTap: _autocompleteItem,
              );
            }),
          ],
        ),
      ),
    );
  }

  Future _searchAutocomplete(String text) async {
    setState(() {
      searchValue = text;
    });
    if (text.trim().isEmpty || text.trim().length < 3) {
      if (autoListProvider.list.isNotEmpty) {
        autoListProvider.clear();
      }
      if (autocompleteMenuController.isShow) {
        autocompleteMenuController.hide();
      }
      return;
    }
    _cacheTextList[indexType] = text;
    if (searchValue.isNotEmpty) {
      await _searchPresenter.searchAutocomplete();
    }
  }

  Future _autocompleteItem(String text) async {
    setState(() {
      searchValue = text;
    });
    _searchBarsubject.add(text);
    if (autocompleteMenuController.isShow) {
      autocompleteMenuController.hide();
    }
    if (autoListProvider.list.isNotEmpty) {
      autoListProvider.clear();
    }

    _cacheTextList[indexType] = text;
    _searchPresenter.clearSearchCurrentPage();
    if (searchValue.isNotEmpty) {
      await _searchPresenter.searchonRefresh();
    }
  }

  Future<void> _onPageChange(int index) async {
    setState(() {
      indexType = index;
    });
    _searchPresenter.indexType = index;
    _searchPresenter.setInitType();
    _tabController.animateTo(index);
    if (searchValue.isEmpty && otherString.isNotEmpty) {
      switch (index) {
        case 0:
          if (searcCompanyListProvider.list.isEmpty) {
            await _searchPresenter.searchonRefresh();
          }
          break;
        case 1:
          if (searcPeopleListProvider.list.isEmpty) {
            await _searchPresenter.searchonRefresh();
          }
          break;
        case 2:
          if (searcProductListProvider.list.isEmpty) {
            await _searchPresenter.searchonRefresh();
          }
          break;
        default:
      }
    }

    final UserInfoProvider userInfoProvider = context.read<UserInfoProvider>();
    final UserInfoModel? userInfoModel = userInfoProvider.userInfoModel;

    switch (index) {
      case 0:
        if ((userInfoModel != null &&
                (searcCompanyListProvider.metaModel?.pagination?.total ?? 0) >
                    3 &&
                searcCompanyListProvider.list.length <= 4) ||
            userInfoProvider.isVip &&
                (searcCompanyListProvider.metaModel?.pagination?.total ?? 0) >
                    10 &&
                searcCompanyListProvider.list.length <= 10) {
          await _searchPresenter.searchonRefresh();
        }
        break;
      case 1:
        if ((userInfoModel != null &&
                (searcPeopleListProvider.metaModel?.pagination?.total ?? 0) >
                    3 &&
                searcPeopleListProvider.list.length <= 4) ||
            userInfoProvider.isVip &&
                (searcPeopleListProvider.metaModel?.pagination?.total ?? 0) >
                    10 &&
                searcPeopleListProvider.list.length <= 10) {
          await _searchPresenter.searchonRefresh();
        }

        break;
      case 2:
        if ((userInfoModel != null &&
                (searcProductListProvider.metaModel?.pagination?.total ?? 0) >
                    3 &&
                searcProductListProvider.list.length <= 4) ||
            userInfoProvider.isVip &&
                (searcProductListProvider.metaModel?.pagination?.total ?? 0) >
                    10 &&
                searcProductListProvider.list.length <= 10) {
          await _searchPresenter.searchonRefresh();
        }

        break;
      default:
    }

    if (_cacheTextList[indexType] != searchValue) {
      _searchPresenter.clearSearchCurrentPage();
      await _searchPresenter.searchonRefresh();
      _cacheTextList[indexType] = searchValue;
    }
  }

  late SearchPresenter _searchPresenter;
  @override
  PowerPresenter createPresenter() {
    final PowerPresenter powerPresenter = PowerPresenter<dynamic>(this);
    _searchPresenter = SearchPresenter();
    _searchPresenter.indexType = indexType;
    powerPresenter.requestPresenter([_searchPresenter]);
    return powerPresenter;
  }
}
