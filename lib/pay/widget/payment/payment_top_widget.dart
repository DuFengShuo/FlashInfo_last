import 'package:flashinfo/login/model/user_info_model.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentTopWidget extends StatelessWidget {
  const PaymentTopWidget({Key? key, this.skuIdType, this.exportCount = ''})
      : super(key: key);
  final SkuIdType? skuIdType;
  final String? exportCount;
  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Consumer<UserInfoProvider>(builder: (_, provider, __) {
        final UserInfoModel? userInfoModel = provider.userInfoModel;
        return Container(
          height: 140.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp16, vertical: Dimens.gap_v_dp12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Sorry! your credit is not enough for export file',
                style: TextStyles.textBold14,
              ),
              Gaps.line,
              _exportItem(
                  'Your Current Status:',
                  '',
                  provider.isVip
                      ? userInfoModel?.vipData?.vipInfo?.vipName ?? ''
                      : ' Free Trail'),
              if (skuIdType == SkuIdType.csv)
                _exportItem(
                    'Export csv Costs：', exportCount.toString(), ' credit')
              else
                _exportItem('Unlock contact Costs:：', '1', ' credit'),
              if (skuIdType == SkuIdType.csv)
                _exportItem('Your current export csv credit：',
                    provider.exportCount.toString(), ' credit')
              else
                _exportItem('Your current Unlock contact credit:',
                    provider.unlockCount.toString(), ' credit'),
            ],
          ),
        );
      }),
    );
  }

  Widget _exportItem(String title, String text, String content) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyles.textSize13,
          ),
        ),
        Text(text, style: TextStyles.textSize13.copyWith(color: Colours.red)),
        Text(content, style: TextStyles.textSize13),
      ],
    );
  }
}
