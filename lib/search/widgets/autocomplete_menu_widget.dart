import 'package:flashinfo/provider/common_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/search/model/autocomplete_bean.dart';
import 'package:flashinfo/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AutocompleteMenuWidget extends StatelessWidget {
  const AutocompleteMenuWidget(
      {Key? key,
      required this.dropdownMenuController,
      this.dropdownMenuChanged,
      required this.autocompleteList,
      this.onTap})
      : super(key: key);
  final List<AutocompleteModel> autocompleteList;
  final GZXDropdownMenuController dropdownMenuController;
  final Function(bool, int?)? dropdownMenuChanged;
  final void Function(String)? onTap;
  @override
  Widget build(BuildContext context) {
    return GZXDropDownMenu(
      controller: dropdownMenuController,
      // 下拉菜单显示或隐藏动画时长
      animationMilliseconds: 100,
      dropdownMenuChanged: dropdownMenuChanged,
      menus: [
        GZXDropdownMenuBuilder(
          dropDownHeight: 40.h * 10.0,
          dropDownWidget: _buildConditionListWidget(),
        ),
      ],
    );
  }

  Widget _buildConditionListWidget() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: autocompleteList.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0.h),
      itemBuilder: (BuildContext context, int index) {
        final AutocompleteModel model = autocompleteList[index];
        return InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onTap!(model.name ?? '');
          },
          child: Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
            height: 50.h,
            child: Row(
              children: [
                Visibility(
                  visible: model.countryImg?.imgName != null &&
                      (model.countryImg?.imgName ?? '').isNotEmpty,
                  child: Consumer<CommonProvider>(
                    builder: (_, commonProvider, __) {
                      final Map<String, String>? nationalFlag =
                          commonProvider.initializeModel?.icon?.nationalFlag;
                      return CircleAvatar(
                        radius: 18.0.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: ImageUtils.getImageProvider(
                            nationalFlag?[model.countryImg?.imgName] ?? '',
                            holderImg: 'me/avatar'),
                      );
                    },
                  ),
                ),
                Gaps.hGap10,
                Expanded(
                    child: Text(
                  model.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
