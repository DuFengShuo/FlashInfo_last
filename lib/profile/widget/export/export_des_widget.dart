import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ExportDesWidget extends StatelessWidget {
  const ExportDesWidget({Key? key, this.count = 0, this.onTabCount})
      : super(key: key);
  final int count;
  final void Function(bool)? onTabCount;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, provider, __) {
      final UserInfoModel? userInfoModel = provider.userInfoModel;
      final int balanceVip =
          userInfoModel?.vipData?.balanceExport?.balanceVip ?? 0;
      final int balanceQuantity =
          userInfoModel?.vipData?.balanceExport?.balanceQuantity ?? 0;
      int proCount = 0;
      int csvCount = 0;
      if (count >= balanceVip) {
        proCount = balanceVip;
        final int remaCount = count - proCount;
        if (remaCount > balanceQuantity) {
          csvCount = balanceQuantity;
        } else {
          csvCount = remaCount;
        }
      } else {
        proCount = count;
      }
      if (count > provider.exportCount) {
        onTabCount!(false);
      } else {
        onTabCount!(true);
      }

      return Container(
          width: double.infinity,
          height: count > provider.exportCount ? 200.h : 160.h,
          color: Colours.material_bg,
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Description：',
                style: TextStyles.textBold17,
              ),
              _descriptionItem('Export csv Costs：', count.toString(), false,
                  color: Colours.red),
              _descriptionItem('Your current export csv credit：',
                  provider.exportCount.toString(), false),
              Gaps.line,
              _descriptionItem('Pro（${balanceVip.toString()} csv credit）：',
                  '-${proCount.toString()}', true),
              _descriptionItem(
                  'Aditional credit（${balanceQuantity.toString()} csv credit）:',
                  '-${csvCount.toString()}',
                  true),
              // if (count > provider.exportCount)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         child: Text(
              //           'Current balance is insufficient, please recharge.',
              //           style:
              //               TextStyles.textBold10.copyWith(color: Colours.red),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 70.w,
              //         height: 25.h,
              //         child: MyButton(
              //           onPressed: () => NavigatorUtils.pushResult(
              //               context, PayRouter.paymentPage, (value) {
              //             print(value);
              //           }, arguments: SkuIdType.csv),
              //           text: 'pay',
              //           fontSize: Dimens.font_sp10,
              //         ),
              //       ),
              //     ],
              //   )
              // else
              //   Gaps.empty,
            ],
          ));
    });
  }

  Widget _descriptionItem(String title, String text, bool isLeft,
      {Color color = Colours.text}) {
    return Row(
      children: [
        if (isLeft) Gaps.hGap20 else Gaps.empty,
        Expanded(child: Text(title, style: TextStyles.textSize10)),
        Text(
          text,
          style: TextStyles.textSize10.copyWith(color: color),
        ),
        Gaps.hGap5,
        Text(
          'credit',
          style: TextStyles.textSize10,
        ),
      ],
    );
  }
}
