import 'package:flashinfo/personal/model/peoples_bean.dart';
import 'package:flashinfo/personal/personal_router.dart';
import 'package:flashinfo/personal/widget/personl_cell_widget.dart';
import 'package:flashinfo/provider/base_list_provider.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/geography_menu_widget.dart';
import 'package:flashinfo/search/widgets/search_export_widget.dart';
import 'package:flashinfo/search/widgets/search_tab_widget.dart';
import 'package:flashinfo/widgets/my_refresh_list.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';

const List<String> _topTabList = ['Region'];

class SearchPeople extends StatefulWidget {
  const SearchPeople(
      {Key? key, required this.searchPresenter, this.searchValue = ''})
      : super(key: key);
  final SearchPresenter searchPresenter;
  final String? searchValue;
  @override
  _SearchPeopleState createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople>
    with AutomaticKeepAliveClientMixin {
  late GZXDropdownMenuController geographyMenuController; //国家下拉框
  int _tapTabIndex = -1;
  late SearchFilter searchFilter = SearchFilter();
  @override
  void initState() {
    super.initState();
    geographyMenuController = GZXDropdownMenuController();
    widget.searchPresenter.searchonRefresh();
  }

  @override
  void dispose() {
    geographyMenuController.dispose();
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
            Consumer2<BaseListProvider<PeoplesModel>, UserInfoProvider>(
              builder: (_, provider, userInfoProvider, __) {
                return Column(
                  children: [
                    SearchExportWidget(
                      metaModel: provider.metaModel,
                    ),
                    Expanded(
                      child: DeerListView(
                        key: const Key('search_company'),
                        itemCount: provider.list.length,
                        stateType: provider.stateType,
                        onRefresh: widget.searchPresenter.searchonRefresh,
                        loadMore: widget.searchPresenter.searchloadMore,
                        hasMore: provider.hasMore,
                        fuzzyImg: 'personnel/personnel_fuzzy',
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
                          final PeoplesModel model = provider.list[index];
                          return PersonalCellWidget(
                            highlightText: widget.searchValue,
                            peoplesModel: model,
                            collectSuccessful: (bool isCollect) {
                              model.isCollect = isCollect;
                            },
                            onTap: () => NavigatorUtils.pushResult(context,
                                '${PersonalRouter.personalDetailsPage}?personalId=${model.id}',
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
          ],
        ))
      ],
    );
  }

  Future updateData(SearchFilter? model) async {
    searchFilter = model!;
    widget.searchPresenter.searchPersonnelFilter = model;
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
        break;
      default:
    }
  }

  @override
  bool get wantKeepAlive => true;
}
