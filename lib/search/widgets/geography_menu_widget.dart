import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/search/presenter/search_presenter.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'menu_btn_text_widget.dart';
import 'menu_button_widget.dart';

class GeographyMenuWidget extends StatefulWidget {
  const GeographyMenuWidget({
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
  _GeographyMenuWidgetState createState() => _GeographyMenuWidgetState();
}

class _GeographyMenuWidgetState extends State<GeographyMenuWidget> {
  String _selectTitle = '';
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
                                provider.initializeModel!.search!.country!
                                    .isNotEmpty
                            ? _boxs(provider.initializeModel!.search!.country!)
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
                _selectTitle = '';
              });
            },
            onConfirmTap: () {
              if (widget.dropdownMenuController.isShow) {
                widget.dropdownMenuController.hide();
              }
              if (widget.searchFilter?.country != _selectTitle) {
                widget.searchFilter?.country = _selectTitle;
                widget.onConfirmTap!(widget.searchFilter);
              }
            },
          ),
        ],
      ),
    );
  }

  /*一个渐变颜色的正方形集合*/
  List<Widget> _boxs(List<String> geographyList) =>
      List.generate(geographyList.length, (index) {
        final String context = geographyList[index];
        return MenuBtnTextWidget(
          onTap: () {
            setState(() {
              _selectTitle = context;
            });
          },
          text: context,
          selectTitle: _selectTitle,
          minWidth: 80.0.w,
        );
      });
}
