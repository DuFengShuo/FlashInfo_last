import 'package:flashinfo/favourites/page/group_list_page.dart';
import 'package:flashinfo/favourites/page/group_name_page.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/firedata_analytics.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/toast_utils.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeGroupName extends StatelessWidget {
  const ChangeGroupName({Key? key, this.groupListParam, this.onTap})
      : super(key: key);
  final GroupListParam? groupListParam;
  final void Function(String)? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.material_bg,
        border: Border(
          top: Divider.createBorderSide(context, width: Dimens.gap_v_dp1),
        ),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp8),
      child: Row(
        children: [
          Text(
            'Group name',
            style: TextStyles.textSize12,
          ),
          Gaps.hGap10,
          Expanded(
              child: GestureDetector(
            onTap: (){
              _sendAnalyticsEvent();
              _showChangeNameDialog(context);
            } ,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
              decoration: BoxDecoration(
                color: Colours.bg_color,
                borderRadius: BorderRadius.circular(4.w),
              ),
              alignment: Alignment.centerLeft,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    groupListParam?.tagsModel?.name ?? '',
                    style: TextStyles.textGray12,
                  ),
                  IconFont(
                      name: 0xe63f,
                      size: 14.sp,
                      color: Colours.unselected_item_color),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
  //修改分组
  Future<void> _sendAnalyticsEvent() async {
    await FireBaseAnalyticUtil
        .analytics
        .logEvent(name: 'edit_group',
    ).then((value) {
      print('修改分组名称');
    });
    // DataFinder.onEventV3("add_group", params: {
    //   "add_group": "value",
    // });
  }

  void _showChangeNameDialog(BuildContext context) {
    if (groupListParam?.indexItem == 0) {
      Toast.show('Default group cannot edit!');
    } else {
      showElasticDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GroupNamePage(
            onPressed: onTap,
          );
        },
      );
    }
  }
}
