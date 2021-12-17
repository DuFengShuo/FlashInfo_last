import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSubWidget extends StatelessWidget {
  const PaymentSubWidget({Key? key, required this.payIndex, this.onPressed})
      : super(key: key);
  final int payIndex;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
      return ((payIndex == 1 || payIndex == 0) &&
                  userInfoProvider.userInfoModel?.isVip == 0) ||
              payIndex == 2
          ? Container(
              color: Colours.material_bg,
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp16,
                  right: Dimens.gap_dp16,
                  top: Dimens.gap_dp16),
              child: Column(
                children: [
                  Visibility(
                    visible: payIndex != 2,
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              'Featuress:',
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.text_gray_c),
                            ),
                            Gaps.hGap5,
                            Text(
                              payIndex == 0 ? 'Pro' : 'Starter',
                              style: TextStyles.textSize12.copyWith(
                                  color: Colours.app_main,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Total amout',
                              style: TextStyles.textSize12
                                  .copyWith(color: Colours.text_gray_c),
                            ),
                            Gaps.hGap10,
                            Text(
                              payIndex == 0
                                  ? (Device.isAndroid ? '\$250' : '\$999')
                                  : (Device.isAndroid ? '\$125' : '\$499'),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Gaps.vGap10,
                  MyButton(
                    key: const Key('Subscribe'),
                    minHeight: 45.h,
                    onPressed: onPressed,
                    text: payIndex == 2 ? 'Recharge' : 'Subscribe',
                  ),
                ],
              ))
          : Gaps.empty;
    });
  }
}
