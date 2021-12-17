import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/more_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'menu_btn_text_widget.dart';
import 'menu_button_widget.dart';

class MoreMenuWidget extends StatefulWidget {
  const MoreMenuWidget(
      {Key? key,
      required this.dropdownMenuController,
      required this.dropdownMenuChange,
      this.searchFilter,
      this.onConfirmTap})
      : super(key: key);
  final GZXDropdownMenuController dropdownMenuController;
  final Function(bool isShow, int? index) dropdownMenuChange;
  final SearchFilter? searchFilter;
  final Function(SearchFilter?)? onConfirmTap;
  @override
  _MoreMenuWidgetState createState() => _MoreMenuWidgetState();
}

class _MoreMenuWidgetState extends State<MoreMenuWidget> {
  late SearchFilter searchFilterModel;
  int _revenueMin = 0; //最小规模
  int _revenueMax = 0; //最大规模
  final TextEditingController _revenueMinController = TextEditingController();
  final TextEditingController _revenueMaxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchFilterModel = SearchFilter()
      ..revenueMin = widget.searchFilter?.revenueMin
      ..revenueMax = widget.searchFilter?.revenueMax
      ..isContact = widget.searchFilter?.isContact
      ..isWebsite = widget.searchFilter?.isWebsite
      ..yearMin = widget.searchFilter?.yearMin
      ..yearMax = widget.searchFilter?.yearMax;

    if (searchFilterModel.revenueMin == 0 &&
        searchFilterModel.revenueMax == 0) {
      _revenueMinController.text =
          _revenueMin == 0 ? '' : _revenueMin.toString();
      _revenueMaxController.text =
          _revenueMax == 0 ? '' : _revenueMax.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GZXDropDownMenu(
      controller: widget.dropdownMenuController,
      // 下拉菜单显示或隐藏动画时长
      animationMilliseconds: 100,
      menus: [
        GZXDropdownMenuBuilder(
            dropDownHeight: 420.h, dropDownWidget: _buildConditionListWidget()),
      ],
      dropdownMenuChanged: widget.dropdownMenuChange,
    );
  }

  Widget _buildConditionListWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fundView(),
          Gaps.line,
          _founded(),
          Gaps.line,
          _websiteNumView('Website', 1),
          Gaps.line,
          _websiteNumView('Contact Number', 2),
          Gaps.line,
          MenuButtonWidget(
            onClearTap: () {
              _revenueMaxController.clear();
              _revenueMinController.clear();
              setState(() {
                _revenueMax = 0;
                _revenueMin = 0;
                searchFilterModel = SearchFilter();
              });
            },
            onConfirmTap: () {
              bool isParm = false;
              if (_revenueMax == 0 && _revenueMin == 0) {
                if (widget.searchFilter?.revenueMin !=
                    searchFilterModel.revenueMin) {
                  widget.searchFilter?.revenueMin =
                      searchFilterModel.revenueMin;
                  isParm = true;
                }
                if (widget.searchFilter?.revenueMax !=
                    searchFilterModel.revenueMax) {
                  widget.searchFilter?.revenueMax =
                      searchFilterModel.revenueMax;
                  isParm = true;
                }
              } else {
                widget.searchFilter?.revenueMax = _revenueMax;
                widget.searchFilter?.revenueMin = _revenueMin;
                isParm = true;
              }

              if (widget.searchFilter?.isContact !=
                  searchFilterModel.isContact) {
                widget.searchFilter?.isContact = searchFilterModel.isContact;
                isParm = true;
              }
              if (widget.searchFilter?.isWebsite !=
                  searchFilterModel.isWebsite) {
                widget.searchFilter?.isWebsite = searchFilterModel.isWebsite;
                isParm = true;
              }
              if (widget.searchFilter?.yearMin != searchFilterModel.yearMin) {
                widget.searchFilter?.yearMin = searchFilterModel.yearMin;
                isParm = true;
              }
              if (widget.searchFilter?.yearMax != searchFilterModel.yearMax) {
                widget.searchFilter?.yearMax = searchFilterModel.yearMax;
                isParm = true;
              }
              if (widget.dropdownMenuController.isShow) {
                widget.dropdownMenuController.hide();
              }
              if (isParm) {
                widget.onConfirmTap!(widget.searchFilter);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _fundView() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp20, vertical: Dimens.gap_v_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fund Amount(millions)',
            style: TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
          ),
          Gaps.vGap10,
          Consumer<CommonProvider>(builder: (_, provider, __) {
            return Wrap(
              spacing: Dimens.gap_dp5, //主轴上子控件的间距
              runSpacing: Dimens.gap_v_dp10, //交叉轴上子控件之间的间距
              children: provider.initializeModel != null &&
                      provider.initializeModel?.search != null &&
                      provider.initializeModel!.search!.fundAmount!.isNotEmpty
                  ? _boxList(provider.initializeModel!.search!.fundAmount!)
                  : [], //要显示的子控件集合
            );
          }),
          Gaps.vGap10,
          Container(
            width: 220.0.w,
            padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
            decoration: BoxDecoration(
              color: (_revenueMin == 0 && _revenueMax == 0)
                  ? Colours.bg_color
                  : Colours.app_main,
              borderRadius: BorderRadius.circular(5.0.w),
            ),
            child: Row(
              children: [
                MoreFieldWidget(
                    hintText: 'Min',
                    controller: _revenueMinController,
                    isText: _revenueMin == 0 && _revenueMax == 0 ? false : true,
                    onCleanTap: () {
                      setState(() {
                        _revenueMin = 0;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        _revenueMin = value.isEmpty ? 0 : int.parse(value);
                      });
                    }),
                Gaps.hGap10,
                const Text(
                  '---',
                  style: TextStyle(color: Colours.text_gray_c),
                ),
                MoreFieldWidget(
                    hintText: 'Max',
                    isText: _revenueMin == 0 && _revenueMax == 0 ? false : true,
                    controller: _revenueMaxController,
                    onCleanTap: () {
                      setState(() {
                        _revenueMax = 0;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        _revenueMax = value.isEmpty ? 0 : int.parse(value);
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _founded() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp20, vertical: Dimens.gap_v_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Founded year',
            style: TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
          ),
          Gaps.vGap10,
          Row(
            children: [
              MenuBtnTextWidget(
                onTap: () {
                  searchFilterModel.yearMax = 0;
                  searchFilterModel.yearMin = 0;
                  setState(() {});
                },
                text: 'All',
                selectTitle: (searchFilterModel.yearMin == 0 &&
                        searchFilterModel.yearMax == 0)
                    ? 'All'
                    : '',
                minWidth: 20.0.w,
              ),
              Gaps.hGap10,
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 7.0.h, horizontal: 12.0.w),
                constraints: BoxConstraints(minWidth: 120.w),
                decoration: BoxDecoration(
                  color: (searchFilterModel.yearMin == 0 &&
                          searchFilterModel.yearMax == 0)
                      ? Colours.bg_color
                      : Colours.app_main,
                  borderRadius: BorderRadius.circular(5.0.w),
                ),
                child: Row(
                  children: [
                    TextIconBtn(
                        hitText: 'Min',
                        text: searchFilterModel.yearMin.toString(),
                        selectTap: () {
                          _showPickerModal(context, true);
                        },
                        selectIcon: () {
                          setState(() {
                            searchFilterModel.yearMin = 0;
                          });
                        }),
                    Gaps.hGap10,
                    const Text(
                      '---',
                      style: TextStyle(color: Colours.material_bg),
                    ),
                    Gaps.hGap10,
                    TextIconBtn(
                        hitText: 'Max',
                        text: searchFilterModel.yearMax.toString(),
                        selectTap: () {
                          _showPickerModal(context, false);
                        },
                        selectIcon: () {
                          setState(() {
                            searchFilterModel.yearMax = 0;
                          });
                        }),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _websiteNumView(String title, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp20, vertical: Dimens.gap_v_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.textSize12.copyWith(color: Colours.text_gray_c),
          ),
          Gaps.vGap10,
          Wrap(
            spacing: Dimens.gap_dp10, //主轴上子控件的间距
            runSpacing: Dimens.gap_v_dp10, //交叉轴上子控件之间的间距
            children: _boxNum(['All', 'with', 'without'], index), //要显示的子控件集合
          ),
        ],
      ),
    );
  }

  List<Widget> _boxNum(List<String> list, int indexItem) {
    return List.generate(list.length, (index) {
      final String context = list[index];
      return MenuBtnTextWidget(
        onTap: () {
          if (indexItem == 1) {
            searchFilterModel.isWebsite = index;
          } else {
            searchFilterModel.isContact = index;
          }
          setState(() {});
        },
        text: context,
        selectTitle: list[(indexItem == 1
                ? searchFilterModel.isWebsite
                : searchFilterModel.isContact) ??
            0],
        minWidth: 20.0.w,
      );
    });
  }

  List<Widget> _boxList(List<FundAmount> list) {
    return List.generate(list.length, (index) {
      final FundAmount context = list[index];
      bool isSelecdtitle = searchFilterModel.revenueMin == context.revenueMin &&
          searchFilterModel.revenueMax == context.revenueMax;
      if (_revenueMax != 0 || _revenueMin != 0) {
        isSelecdtitle = false;
      }
      String numText = '';
      if (context.revenueMin == 0 && context.revenueMax == 0) {
        numText = 'All';
      } else if (context.revenueMin == 0 && context.revenueMax != 0) {
        numText = '<${context.revenueMax}';
      } else if (context.revenueMin != 0 && context.revenueMax == 0) {
        numText = '>${context.revenueMin}';
      } else {
        numText = '${context.revenueMin}-${context.revenueMax}';
      }
      return MenuBtnTextWidget(
        onTap: () {
          searchFilterModel.revenueMin = context.revenueMin;
          searchFilterModel.revenueMax = context.revenueMax;
          _revenueMax = 0;
          _revenueMin = 0;
          _revenueMaxController.clear();
          _revenueMinController.clear();
          setState(() {});
        },
        text: numText,
        selectTitle: isSelecdtitle ? numText : '',
        minWidth: 20.0.w,
      );
    });
  }

  Future _showPickerModal(BuildContext context, bool isMin) async {
    final List<int> yearList = List.generate(122, (index) => 1900 + index);
    int selectedIndex = 0;
    if (isMin) {
      selectedIndex = (searchFilterModel.yearMin ?? 0) == 0
          ? yearList.last
          : (searchFilterModel.yearMin ?? 0);
    } else {
      selectedIndex = (searchFilterModel.yearMax ?? 0) == 0
          ? yearList.last
          : (searchFilterModel.yearMax ?? 0);
    }
    selectedIndex = selectedIndex - 1900;
    await Picker(
        adapter: PickerDataAdapter<String>(pickerdata: yearList),
        changeToFirst: true,
        hideHeader: false,
        selectedTextStyle: const TextStyle(color: Colours.app_main),
        height: 200.h,
        itemExtent: 32.0.h,
        cancelTextStyle:
            const TextStyle(color: Colours.app_main, fontSize: 16.0),
        confirmTextStyle:
            const TextStyle(color: Colours.app_main, fontSize: 16.0),
        title: Text(
          isMin ? 'Select Start Year' : 'Select end Year',
          style: TextStyles.textSize16,
        ),
        selecteds: [selectedIndex],
        onConfirm: (picker, value) {
          print(value.toString());
          print(picker.adapter.text);
          final int numYear = int.parse(
              picker.adapter.text.substring(1, picker.adapter.text.length - 1));

          if (isMin) {
            if (numYear > (searchFilterModel.yearMax ?? 0) &&
                (searchFilterModel.yearMax ?? 0) != 0) {
              showToast(
                  'The minimum year cannot be greater than the maximum year');
              return;
            }
            setState(() {
              searchFilterModel.yearMin = int.parse(picker.adapter.text
                  .substring(1, picker.adapter.text.length - 1));
            });
          } else {
            if (numYear < (searchFilterModel.yearMin ?? 0) &&
                (searchFilterModel.yearMin ?? 0) != 0) {
              showToast(
                  'The maximum year cannot be greater than the minimum year');
              return;
            }
            setState(() {
              searchFilterModel.yearMax = int.parse(picker.adapter.text
                  .substring(1, picker.adapter.text.length - 1));
            });
          }
        }).showModal<void>(this.context); //_sca
  }
}
