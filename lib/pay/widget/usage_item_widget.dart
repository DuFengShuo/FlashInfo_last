import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class UsageItemWidget extends StatelessWidget {
  const UsageItemWidget(
      {Key? key,
      required this.title,
      this.onPressed,
      this.balanceVip = 0,
      this.balanceQuantity = 0})
      : super(key: key);
  final String title;
  final int balanceVip;
  final int balanceQuantity;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.textSize13,
          ),
          Gaps.vGap4,
          Expanded(
            child: GestureDetector(
                onTap: () {
                  showToast(
                      '${balanceVip.toString()} is cubscribe credit,${balanceQuantity.toString()} is additional credit',
                      position: ToastPosition.center);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.hGap10,
                    Padding(
                      padding: EdgeInsets.only(top: Dimens.gap_dp5),
                      child: Text(
                        (balanceQuantity + balanceVip).toString(),
                        style: TextStyles.textBold15
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gaps.hGap4,
                    IconFont(
                        name: 0xe64d,
                        size: Dimens.font_sp12,
                        color: Colours.text_gray_c),
                  ],
                )),
          ),
          Container(
            color: Colors.transparent,
            height: 28.h,
            child: MyButton(
              minWidth: 80.w,
              fontSize: 13.sp,
              onPressed: onPressed,
              text: 'Recharge',
            ),
          ),
        ],
      ),
    );
  }
}
