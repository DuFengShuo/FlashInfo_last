import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportFormatWidget extends StatelessWidget {
  const ExportFormatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colours.material_bg,
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap5,
          Text(
            'Format',
            style: TextStyles.textBold17,
          ),
          Gaps.vGap20,
          Row(
            children: [
              IconFont(name: 0xe651, size: 18.sp, color: Colours.app_main),
              Gaps.hGap5,
              Text(
                'CSV',
                style: TextStyles.textSize14,
              ),
              const Spacer(),
              IconFont(name: 0xe63b, size: 16.sp, color: Colours.app_main),
            ],
          ),
          Gaps.vGap20,
        ],
      ),
    );
  }
}
