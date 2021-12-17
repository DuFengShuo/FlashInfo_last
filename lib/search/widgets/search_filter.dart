import 'package:flashinfo/search/widgets/industry_menu_widget.dart';
import 'package:flashinfo/search/widgets/more_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';

import 'geography_menu_widget.dart';

class SearchFilter extends StatelessWidget {
  SearchFilter({Key? key, this.dropdownShow}) : super(key: key);
  final void Function(int)? dropdownShow;
  final GZXDropdownMenuController geographyMenuController =
      GZXDropdownMenuController(); //国家下拉框
  final GZXDropdownMenuController industryMenuController =
      GZXDropdownMenuController(); //行业下拉框
  final GZXDropdownMenuController moreMenuController =
      GZXDropdownMenuController(); //条件下拉框
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GeographyMenuWidget(
          //国家下拉框
          dropdownMenuController: geographyMenuController,
        ),
        IndustryMenuWidget(
          dropdownMenuController: industryMenuController,
        ),
        MoreMenuWidget(
          dropdownMenuController: moreMenuController,
          dropdownMenuChange: (bool isShow, int? index) {},
        )
      ],
    );
  }

  void dropdownMenuShow(int menuType) {
    switch (menuType) {
      case 0:
        if (geographyMenuController.isShow) {
          geographyMenuController.hide();
        } else {
          geographyMenuController.show(0);
        }
        industryMenuController.hide();
        moreMenuController.hide();
        break;
      case 1:
        if (industryMenuController.isShow) {
          industryMenuController.hide();
        } else {
          industryMenuController.show(0);
        }
        geographyMenuController.hide();
        moreMenuController.hide();
        break;
      case 2:
        if (moreMenuController.isShow) {
          moreMenuController.hide();
        } else {
          moreMenuController.show(0);
        }
        geographyMenuController.hide();
        industryMenuController.hide();
        break;
      default:
    }
  }
}
