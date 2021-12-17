import 'package:flashinfo/home/model/initialize_model.dart';
import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/search/widgets/menu_button_widget.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'menu_btn_text_widget.dart';

class IndustryMenuWidget extends StatefulWidget {
  const IndustryMenuWidget({
    Key? key,
    required this.dropdownMenuController,
    this.dropdownMenuChanged,
    this.onConfirmTap,
    this.searchFilter,
  }) : super(key: key);
  final GZXDropdownMenuController dropdownMenuController;
  final Function(bool, int?)? dropdownMenuChanged;
  final Function(SearchFilter?)? onConfirmTap;
  final SearchFilter? searchFilter;
  @override
  _IndustryMenuWidgetState createState() => _IndustryMenuWidgetState();
}

class _IndustryMenuWidgetState extends State<IndustryMenuWidget> {
  final List<String> _selectTitleList = [];
  @override
  Widget build(BuildContext context) {
    return GZXDropDownMenu(
      controller: widget.dropdownMenuController,
      // 下拉菜单显示或隐藏动画时长
      animationMilliseconds: 100,
      menus: [
        GZXDropdownMenuBuilder(
            dropDownHeight: 280.h, dropDownWidget: _buildConditionListWidget()),
      ],
      dropdownMenuChanged: widget.dropdownMenuChanged,
    );
  }

  Widget _buildConditionListWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colours.material_bg,
            height: 210.h,
            child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.0.h),
                child: MyScrollView(children: [
                  Consumer<CommonProvider>(
                    builder: (_, provider, __) {
                      return Wrap(
                        spacing: 20.w, //主轴上子控件的间距
                        runSpacing: 15.h, //交叉轴上子控件之间的间距
                        children: provider.initializeModel != null &&
                                provider.initializeModel?.search != null &&
                                provider.initializeModel!.search!.industry!
                                    .isNotEmpty
                            ? _boxs(provider.initializeModel!.search!.industry!)
                            : [], //要显示的子控件集合
                      );
                    },
                  ),
                ])),
          ),
          Gaps.line,
          MenuButtonWidget(
            onClearTap: () {
              setState(() {
                _selectTitleList.clear();
              });
            },
            onConfirmTap: () {
              if (widget.dropdownMenuController.isShow) {
                widget.dropdownMenuController.hide();
              }
              bool isParam = false;
              List<String> industryList = [];
              if (widget.searchFilter != null &&
                  widget.searchFilter?.industry != null &&
                  widget.searchFilter!.industry!.isNotEmpty) {
                industryList = widget.searchFilter!.industry!.split(',');
              }

              if (industryList.length == _selectTitleList.length) {
                if (industryList.isNotEmpty && _selectTitleList.isNotEmpty) {
                  industryList.forEach((industryItem) {
                    if (!_selectTitleList.contains(industryItem)) {
                      isParam = true;
                    }
                  });
                  if (isParam) {
                    widget.searchFilter?.industry = _selectTitleList.join(',');
                    widget.onConfirmTap!(widget.searchFilter);
                  }
                }
              } else {
                widget.searchFilter?.industry = _selectTitleList.join(',');
                widget.onConfirmTap!(widget.searchFilter);
              }
            },
          ),
        ],
      ),
    );
  }

  /*一个渐变颜色的正方形集合*/
  List<Widget> _boxs(List<Industry> industryList) =>
      List.generate(industryList.length, (index) {
        final Industry model = industryList[index];
        final bool isSelecdtitle = _selectTitleList.contains(model.name ?? '');
        return MenuBtnTextWidget(
          onTap: () {
            if (isSelecdtitle) {
              _selectTitleList.removeWhere((v) => v == model.name);
            } else {
              _selectTitleList.add(model.name ?? '');
            }
            setState(() {});
          },
          text: model.name ?? '',
          selectTitle: isSelecdtitle ? (model.name ?? '') : '',
          minWidth: 80.0.w,
        );
      });
}
