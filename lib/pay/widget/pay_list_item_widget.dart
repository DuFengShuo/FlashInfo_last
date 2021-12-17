import 'package:flashinfo/pay/model/pay_ments_list_bean.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayListItemWidget extends StatelessWidget {
  const PayListItemWidget({Key? key, this.payMentsListModel}) : super(key: key);
  final PayMentsListModel? payMentsListModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.gap_v_dp10),
      child: MyCard(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  payMentsListModel?.skuInfo?.name ?? '',
                  style: TextStyles.textBold13,
                ),
                Text(
                  payMentsListModel?.createdAt ?? '',
                  style: TextStyles.textBold13,
                )
              ],
            ),
            Gaps.vGap12,
            Gaps.line,
            Gaps.vGap16,
            payListItem(
                payMentsListModel?.skuInfo?.skuType == 1
                    ? 'Expiry Date:'
                    : 'Amount:',
                payMentsListModel?.skuInfo?.skuType == 1
                    ? payMentsListModel?.skuInfo?.expiredAt ?? ''
                    : payMentsListModel?.skuInfo?.pieces.toString() ?? '0',
                ''),
            Gaps.vGap12,
            payListItem('Payment:', payMentsListModel?.skuInfo?.price ?? '',
                payMentsListModel?.orderStatus == 1 ? 'Success' : 'Failed',
                color: payMentsListModel?.orderStatus == 1
                    ? const Color(0xff8AD043)
                    : const Color(0xffFF0000)),
            Gaps.vGap4,
          ],
        ),
      )),
    );
  }

  Widget payListItem(String title, String text, String stateString,
      {Color? color = Colours.app_main}) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            title,
            style: TextStyles.textSize13,
          ),
        ),
        Expanded(
            child: Text(
          text,
          style: TextStyles.textBold13,
        )),
        Text(stateString, style: TextStyles.textSize13.copyWith(color: color))
      ],
    );
  }
}
