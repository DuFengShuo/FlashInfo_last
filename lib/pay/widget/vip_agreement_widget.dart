import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/net/net.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VipAgreementWidget extends StatelessWidget {
  const VipAgreementWidget({Key? key, this.payIndex = 0}) : super(key: key);
  final int payIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.material_bg,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: Dimens.gap_dp10,
          right: Dimens.gap_dp10,
          top: Dimens.gap_v_dp10),
      child: Column(
        children: [
          Text(
            payIndex == 0 || payIndex == 1
                ? 'Automatic Renewal Service Statement'
                : 'Pay-per-use Serivice Statement',
            style: TextStyles.textBold12,
          ),
          Gaps.vGap10,
          Text(
            payIndex == 0 || payIndex == 1
                ? '1. Payment: After confirming the purchase of the auto-renewable product, your Apple ITunes account will be deducted \n2. Renewal: After your subscription period expires within 24 hours, Apple will automatically deduct the fee from the ITunes account, and the membership validity period will be automatically extended after success\n3. If you need to cancel the automatic renewal, please manually turn off the automatic renewal in the Apple ID account settings at least 24 hours before the expiration of the subscription period. After the closure, no charge will be charged'
                : 'The pay-per-use model means that a certain amount of credit will be consumed every time you use the paid function. When the purchased quota is used up, you need to repurchase',
            style: TextStyles.textSize12
                .copyWith(color: Colours.text_gray_c, height: 1.5),
          ),
          Gaps.vGap10,
          GestureDetector(
            onTap: () => _launchWebURL(
                context, 'Service agreement', HttpApi.treatyTerms),
            child: Container(
              height: 44.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: Divider.createBorderSide(context, width: Dimens.gap_dp1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service agreement', style: TextStyles.textSize14),
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Images.arrowRight,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                _launchWebURL(context, 'Privacy policy', HttpApi.privacyPolicy),
            child: Container(
              height: 44.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: Divider.createBorderSide(context, width: Dimens.gap_dp1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Privacy policy', style: TextStyles.textSize14),
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Images.arrowRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchWebURL(BuildContext context, String title, String url) {
    final String uels = Constant.baseUrl.replaceAll('api/', '') + url;
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, uels);
    } else {
      Utils.launchWebURL(url);
    }
  }
}
