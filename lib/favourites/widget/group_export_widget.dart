import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupExportWidget extends StatelessWidget {
  const GroupExportWidget(
      {Key? key, this.count, this.onExportTap, this.isShowExport = false})
      : super(key: key);
  final int? count;
  final void Function()? onExportTap;
  final bool isShowExport;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_dp8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_v_dp8),
              child: RichText(
                text: TextSpan(
                    text: 'Quantity ',
                    style: TextStyles.textSize12.copyWith(color: Colours.text),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$count',
                        style: TextStyles.textBold12
                            .copyWith(color: Colours.app_main),
                      )
                    ]),
              )),
          Visibility(
            visible: !isShowExport || count == 0 ? false : true,
            child: InkWell(
              onTap: onExportTap,
              child: Row(
                children: [
                  const IconFont(
                      name: 0xe64f,
                      size: 20,
                      isNewIcon: true,
                      color: Colours.app_main),
                  Gaps.hGap4,
                  Container(
                    alignment: Alignment.center,
                    height: 28.0.h,
                    child: Text(
                      'Export',
                      style: TextStyles.textGray12,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
