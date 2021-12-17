import 'package:flashinfo/profile/page/export/export_page.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportEmailWidget extends StatelessWidget {
  const ExportEmailWidget(
      {Key? key,
      this.exportStoreParams,
      required this.numController,
      required this.nodeText})
      : super(key: key);
  final ExportStoreParams? exportStoreParams;
  final TextEditingController numController;
  final FocusNode nodeText;
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
            'Recipient Information',
            style: TextStyles.textBold17,
          ),
          Gaps.vGap20,
          Row(
            children: [
              IconFont(name: 0xe62a, size: 16.sp, color: Colours.app_main),
              Gaps.hGap10,
              Text(
                'E-mail',
                style: TextStyles.textSize14,
              ),
              Gaps.hGap10,
              Expanded(
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    border:
                        new Border.all(color: Colours.text_gray_c, width: 0.5),
                  ),
                  child: TextField(
                    key: const Key('fund_input'),
                    controller: numController,
                    focusNode: nodeText,
                    maxLines: 1,
                    style: TextStyles.textSize13,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 6.0.h, left: 5.0.w, right: 0.0.w, bottom: 0.0.h),
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: TextStyles.textSize13.copyWith(
                        color: Colours.text_gray_c,
                      ),
                      hintText: 'The report is sent to your email',
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              Gaps.hGap20,
            ],
          ),
          Gaps.vGap20,
        ],
      ),
    );
  }
}
