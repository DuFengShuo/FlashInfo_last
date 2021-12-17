import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/product/model/products_bean.dart';
import 'package:flashinfo/product/product_router.dart';
import 'package:flashinfo/product/widget/product_cell.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/geography_menu_widget.dart';
import 'package:flashinfo/search/widgets/industry_menu_widget.dart';
import 'package:flashinfo/search/widgets/more_menu_widget.dart';
import 'package:flashinfo/search/widgets/search_export_widget.dart';
import 'package:flashinfo/search/widgets/search_tab_widget.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';

const List<String> _topTabList = ['Region', 'Industry', 'More filters'];

class SearchProduct extends StatefulWidget {
  const SearchProduct(
      {Key? key, required this.searchPresenter, this.searchValue = ''})
      : super(key: key);
  final SearchPresenter searchPresenter;
  final String? searchValue;
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct>
    with AutomaticKeepAliveClientMixin {
  late GZXDropdownMenuController geographyMenuController; //国家下拉框
  late GZXDropdownMenuController industryMenuController; //行业下拉框
  late GZXDropdownMenuController moreMenuController; //条件下拉框
  int _tapTabIndex = -1;
  late SearchFilter searchFilter = SearchFilter();
  // late bool _isLogin = false;
  @override
  void initState() {
    super.initState();
    geographyMenuController = GZXDropdownMenuController();
    industryMenuController = GZXDropdownMenuController();
    moreMenuController = GZXDropdownMenuController();
    widget.searchPresenter.searchonRefresh();
  }

  @override
  void dispose() {
    geographyMenuController.dispose();
    industryMenuController.dispose();
    moreMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        Row(
          children: _tabListWidhet(),
        ),
        Expanded(
          child: Stack(
            children: [
              Consumer2<BaseListProvider<ProductsModel>, UserInfoProvider>(
                builder: (_, provider, userInfoProvider, __) {
                  return Column(
                    children: [
                      SearchExportWidget(
                        metaModel: provider.metaModel,
                      ),
                      Expanded(
                        child: DeerListView(
                          key: const Key('search_product'),
                          itemCount: provider.list.length,
                          stateType: provider.stateType,
                          onRefresh: widget.searchPresenter.searchonRefresh,
                          loadMore: widget.searchPresenter.searchloadMore,
                          hasMore: provider.hasMore,
                          fuzzyImg: 'product/product_fuzzy',
                          totalPages:
                              provider.metaModel?.pagination?.totalPages ?? 1,
                          isLogin: (userInfoProvider.userInfoModel == null &&
                                  (provider.metaModel?.pagination?.total ?? 0) >
                                      3) ||
                              (!userInfoProvider.isVip &&
                                  (provider.metaModel?.pagination?.total ?? 0) >
                                      10),
                          loginName: 'View all search results',
                          vipName: 'Upgrade  Plan for unlimited search results',
                          itemBuilder: (_, index) {
                            final ProductsModel model = provider.list[index];
                            return ProductCellWidget(
                              highlightText: widget.searchValue,
                              productModel: model,
                              collectSuccessful: (StatusModel statusModel) {
                                model.isCollect = !(model.isCollect ?? false);
                              },
                              onTap: () => NavigatorUtils.pushResult(context,
                                  '${ProductRouter.productDetailsPage}?productId=${model.id}',
                                  (value) {
                                if (userInfoProvider.userInfoModel != null &&
                                    provider.list.length < 4) {
                                  widget.searchPresenter.searchonRefresh();
                                }
                              }, arguments: model),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              GeographyMenuWidget(
                  //国家下拉框
                  dropdownMenuController: geographyMenuController,
                  searchFilter: searchFilter,
                  dropdownMenuChanged: (bool isShow, int? index) {
                    setState(() {
                      _tapTabIndex = isShow ? 0 : -1;
                    });
                  },
                  onConfirmTap: updateData),
              IndustryMenuWidget(
                  dropdownMenuController: industryMenuController,
                  searchFilter: searchFilter,
                  dropdownMenuChanged: (bool isShow, int? index) {
                    setState(() {
                      _tapTabIndex = isShow ? 1 : -1;
                    });
                  },
                  onConfirmTap: updateData),
              MoreMenuWidget(
                  dropdownMenuController: moreMenuController,
                  searchFilter: searchFilter,
                  dropdownMenuChange: (bool isShow, int? index) {
                    setState(() {
                      _tapTabIndex = isShow ? 2 : -1;
                    });
                  },
                  onConfirmTap: updateData)
            ],
          ),
        ),
      ],
    );
  }

  Future updateData(SearchFilter? model) async {
    searchFilter = model!;
    widget.searchPresenter.searchProductFilter = model;
    await widget.searchPresenter.searchonRefresh(isShowDialog: true);
  }

  List<Widget> _tabListWidhet() => List.generate(
        _topTabList.length,
        (index) {
          final String context = _topTabList[index];
          bool selecdTabIndex = false;
          switch (index) {
            case 0:
              selecdTabIndex = searchFilter.country!.isEmpty ? false : true;
              break;
            case 1:
              selecdTabIndex = searchFilter.industry!.isEmpty ? false : true;
              break;
            case 2:
              selecdTabIndex = (searchFilter.revenueMin == 0 &&
                      searchFilter.revenueMax == 0 &&
                      searchFilter.yearMin == 0 &&
                      searchFilter.yearMax == 0 &&
                      searchFilter.isWebsite == 0 &&
                      searchFilter.isContact == 0)
                  ? false
                  : true;
              break;
            default:
          }
          return SearchTabWidget(
            tabName: context,
            selecd: selecdTabIndex ? true : false,
            seleIcon: _tapTabIndex == index ? true : false,
            tabLenght: _topTabList.length,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                _tapTabIndex = _tapTabIndex == index ? -1 : index;
              });
              dropdownMenuShow(index);
            },
          );
        },
      );

  void dropdownMenuShow(int menuType) {
    switch (menuType) {
      case 0:
        if (geographyMenuController.isShow) {
          geographyMenuController.hide();
        } else {
          geographyMenuController.show(0);
        }
        if (industryMenuController.isShow) {
          industryMenuController.hide();
        }
        if (moreMenuController.isShow) {
          moreMenuController.hide();
        }
        break;
      case 1:
        if (industryMenuController.isShow) {
          industryMenuController.hide();
        } else {
          industryMenuController.show(0);
        }
        if (geographyMenuController.isShow) {
          geographyMenuController.hide();
        }

        if (moreMenuController.isShow) {
          moreMenuController.hide();
        }
        break;
      case 2:
        if (moreMenuController.isShow) {
          moreMenuController.hide();
        } else {
          moreMenuController.show(0);
        }
        if (geographyMenuController.isShow) {
          geographyMenuController.hide();
        }
        if (industryMenuController.isShow) {
          industryMenuController.hide();
        }
        break;
      default:
    }
  }

  @override
  bool get wantKeepAlive => true;
}
