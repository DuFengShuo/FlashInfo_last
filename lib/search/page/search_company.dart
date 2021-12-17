import 'package:flashinfo/brand/brand_rouder.dart';
import 'package:flashinfo/brand/models/brand_list_bean.dart';
import 'package:flashinfo/brand/page/brand_search_list_page.dart';
import 'package:flashinfo/company/company_rouder.dart';
import 'package:flashinfo/company/models/company_bean.dart';
import 'package:flashinfo/company/widget/company_cell_widget.dart';
import 'package:flashinfo/mvp/status_model.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/geography_menu_widget.dart';
import 'package:flashinfo/search/widgets/industry_menu_widget.dart';
import 'package:flashinfo/search/widgets/more_menu_widget.dart';
import 'package:flashinfo/search/widgets/search_export_widget.dart';
import 'package:flashinfo/search/widgets/search_tab_widget.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const List<String> _topTabList = ['Region', 'Industry', 'More filters'];

class SearchCompany extends StatefulWidget {
  const SearchCompany(
      {Key? key, required this.searchPresenter, this.searchValue = ''})
      : super(key: key);
  final SearchPresenter searchPresenter;
  final String? searchValue;
  @override
  _SearchCompanyState createState() => _SearchCompanyState();
}

class _SearchCompanyState extends State<SearchCompany>
    with AutomaticKeepAliveClientMixin {
  late GZXDropdownMenuController geographyMenuController; //国家下拉框
  late GZXDropdownMenuController industryMenuController; //行业下拉框
  late GZXDropdownMenuController moreMenuController; //条件下拉框
  int _tapTabIndex = -1;
  late SearchFilter searchFilter = SearchFilter();
  @override
  void initState() {
    super.initState();
    geographyMenuController = GZXDropdownMenuController();
    industryMenuController = GZXDropdownMenuController();
    moreMenuController = GZXDropdownMenuController();
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
              Consumer3<BaseListProvider<CompanyModel>, UserInfoProvider,
                      BaseListProvider<BrandItemModel>>(
                  builder: (_, provider, userInfoProvider,
                      searcBrandListProvider, __) {
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      if (searcBrandListProvider.list.isNotEmpty)
                        SliverAppBar(
                          expandedHeight: 170.w,
                          pinned: false,
                          leading: Gaps.empty,
                          flexibleSpace: FlexibleSpaceBar(
                            background: BrandSearchListPage(
                              searcBrandListProvider: searcBrandListProvider,
                              keyword: widget.searchValue ?? '',
                              backOnPressed: () {
                                if (userInfoProvider.userInfoModel != null &&
                                    provider.list.length < 4) {
                                  widget.searchPresenter.searchonRefresh();
                                }
                              },
                            ),
                          ),
                        )
                    ];
                  },
                  body: Column(
                    children: [
                      Gaps.vGap5,
                      SearchExportWidget(
                          metaModel: provider.metaModel,
                          isShowExport: true,
                          onTap: () {
                            widget.searchPresenter.exportParam(
                                widget.searchPresenter.searchCompanyFilter,
                                provider.metaModel);
                            widget.searchPresenter.sendAnalyticsEvent();

                            if (userInfoProvider.isVip) {
                              AnalyticEventUtil.analyticsUtil
                                  .sendAnalyticsEvent('Export_Click');
                            } else {
                              AnalyticEventUtil.analyticsUtil
                                  .sendAnalyticsEvent('Export_Click_GoVip');
                            }
                          }),
                      Expanded(
                        child: DeerListView(
                          key: const Key('search_company'),
                          itemCount: provider.list.length,
                          stateType: provider.stateType,
                          onRefresh: widget.searchPresenter.searchonRefresh,
                          loadMore: widget.searchPresenter.searchloadMore,
                          totalPages:
                              provider.metaModel?.pagination?.totalPages ?? 1,
                          hasMore: provider.hasMore,
                          fuzzyImg: 'company/company_fuzzy',
                          isLogin: (userInfoProvider.userInfoModel == null &&
                                  (provider.metaModel?.pagination?.total ?? 0) >
                                      3) ||
                              (!userInfoProvider.isVip &&
                                  (provider.metaModel?.pagination?.total ?? 0) >
                                      10),
                          loginName: 'View all search results',
                          vipName: 'Upgrade  Plan for unlimited search results',
                          itemBuilder: (_, index) {
                            final CompanyModel model = provider.list[index];
                            return CompanyCellWidget(
                              highlightText: widget.searchValue,
                              collectSuccessful: (StatusModel statusModel) {
                                model.isCollect = !(model.isCollect ?? false);
                              },
                              isLead: true,
                              companyModel: model,
                              onTap: () {
                                // if (index == 0) {
                                //   NavigatorUtils.push(context,
                                //       '${CompanyRouder.companyDetailsPage}?companyId=MvkVRA3wdodgOKb1');
                                //   return;
                                // }
                                if (model.entityType == 2) {
                                  NavigatorUtils.push(context,
                                      '${BrandRouder.brandDetailPage}?brandId=${model.id}');
                                } else {
                                  NavigatorUtils.pushResult(context,
                                      '${CompanyRouder.companyDetailsPage}?companyId=${model.id}',
                                      (value) {
                                    if (userInfoProvider.userInfoModel !=
                                            null &&
                                        provider.list.length < 4) {
                                      widget.searchPresenter.searchonRefresh();
                                    }
                                  }, arguments: model);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
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
                  onConfirmTap: updateData),
            ],
          ),
        ),
      ],
    );
  }

  Future updateData(SearchFilter? model) async {
    searchFilter = model!;
    widget.searchPresenter.searchCompanyFilter = model;
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
