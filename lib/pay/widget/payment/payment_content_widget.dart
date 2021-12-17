import 'package:flashinfo/pay/widget/vip_agreement_widget.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentContentWidget extends StatelessWidget {
  const PaymentContentWidget({Key? key, required this.payIndex, this.skuIdType})
      : super(key: key);
  final int payIndex;
  final SkuIdType? skuIdType;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
      return Column(
        children: [
          Visibility(
            visible: payIndex == 0 || payIndex == 1,
            child: Column(
              children: [
                if (userInfoProvider.isVip)
                  MyCard(
                      child: Container(
                          width: double.infinity,
                          height: 60.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.gap_dp10,
                              vertical: Dimens.gap_v_dp12),
                          child: Text(
                            'You are now on the status of professional plan',
                            textAlign: TextAlign.center,
                            style: TextStyles.textBold16,
                          )))
                else
                  LoadAssetImage(
                    (skuIdType == SkuIdType.csv)
                        ? Device.isIOS
                            ? 'pay/export_ios'
                            : 'pay/export_android'
                        : Device.isIOS
                            ? 'pay/unlock_ios'
                            : 'pay/unlock_android',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                Gaps.vGap20,
                GestureDetector(
                  onTap: () => _showPriceDialog(context),
                  child: Container(
                    width: 105.w,
                    height: 26.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: new Border.all(color: Colours.app_main, width: 1),
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(13.0.h)),
                    ),
                    child: Text(
                      'View all right',
                      style: TextStyles.textSize12
                          .copyWith(color: Colours.app_main),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap20,
          VipAgreementWidget(
            payIndex: payIndex,
          ),
          Gaps.vGap20,
        ],
      );
    });
  }

  void _showPriceDialog(BuildContext context) {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadAssetImage(
                Device.isIOS ? 'pay/vip_ios' : 'pay/vip_android',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Gaps.vGap20,
              GestureDetector(
                onTap: () => NavigatorUtils.goBack(context),
                child: IconFont(
                    name: 0xe639,
                    size: Dimens.font_sp28,
                    color: Colours.material_bg),
              ),
            ],
          ),
        );
      },
    );
  }
}
