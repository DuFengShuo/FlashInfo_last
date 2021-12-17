import 'package:flashinfo/common/common.dart';
import 'package:flashinfo/login/login_router.dart';
import 'package:flashinfo/pay/page/price_list_dialog.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/pay/widget/vip_agreement_widget.dart';
import 'package:flashinfo/profile/page/business/widget/business_center_log_widget.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/device_utils.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/load_image.dart';
import 'package:flashinfo/widgets/login_toast_dialog.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BusinessCenterPage extends StatefulWidget {
  const BusinessCenterPage({Key? key, this.isShowLog = true}) : super(key: key);
  final bool isShowLog;
  @override
  _BusinessCenterPageState createState() => _BusinessCenterPageState();
}

class _BusinessCenterPageState extends State<BusinessCenterPage> {
  late SkuIdType _skuIdType = SkuIdType.pro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Business Center',
      ),
      backgroundColor: Colours.bg_color,
      body: MyScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
        crossAxisAlignment: CrossAxisAlignment.center,
        isSafeArea: true,
        bottomButton: Consumer<UserInfoProvider>(builder: (_, provider, __) {
          return Visibility(
              visible: !provider.isVip,
              child: SafeArea(
                child: Container(
                    color: Colours.material_bg,
                    padding: EdgeInsets.only(
                        left: Dimens.gap_dp16,
                        right: Dimens.gap_dp16,
                        top: Dimens.gap_dp16),
                    child: Column(
                      children: [
                        Row(
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
                                  _skuIdType == SkuIdType.pro
                                      ? 'Pro'
                                      : 'Starter',
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
                                  _skuIdType == SkuIdType.pro
                                      ? (Device.isAndroid ? '\$250' : '\$999')
                                      : (Device.isAndroid ? '\$125' : '\$499'),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colours.app_main,
                                  ),
                                )
                              ],
                            )),
                          ],
                        ),
                        Gaps.vGap10,
                        MyButton(
                          key: const Key('Subscribe'),
                          minHeight: 45.h,
                          onPressed: _showPackageDialog,
                          text: 'Subscribe',
                        ),
                      ],
                    )),
              ));
        }),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap15,
      if (widget.isShowLog)
        const BusinessCenterLogWidget()
      else
        Container(
          width: double.infinity,
          color: Colours.material_bg,
          margin: EdgeInsets.only(bottom: Dimens.gap_v_dp10),
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp10, vertical: Dimens.gap_v_dp10),
          child: Text(
            'Upgrade members can enjoy more rights',
            textAlign: TextAlign.left,
            style: TextStyles.textBold13,
          ),
        ),
      LoadAssetImage(
        Device.isIOS ? 'pay/vip_ios' : 'pay/vip_android',
        width: double.infinity,
        fit: BoxFit.fill,
      ),
      Gaps.vGap10,
      Consumer<UserInfoProvider>(builder: (_, provider, __) {
        return Visibility(
            visible: !provider.isVip,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        backgroundColor: _skuIdType == SkuIdType.pro
                            ? Colours.app_main
                            : Colours.text_gray_c,
                        onPressed: () {
                          setState(() {
                            _skuIdType = SkuIdType.pro;
                          });
                        },
                        text: 'Pro',
                      ),
                    ),
                    Gaps.hGap32,
                    Expanded(
                      child: MyButton(
                        backgroundColor: _skuIdType == SkuIdType.starter
                            ? Colours.app_main
                            : Colours.text_gray_c,
                        onPressed: () {
                          setState(() {
                            _skuIdType = SkuIdType.starter;
                          });
                        },
                        text: 'Starter',
                      ),
                    ),
                  ],
                ),
                Gaps.vGap10,
                const VipAgreementWidget(),
                Gaps.vGap10,
              ],
            ));
      }),
    ];
  }

  Future _showPackageDialog() async {
    if (!(SpUtil.getBool(Constant.isLogin, defValue: false) ?? false)) {
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => LoginToastDialog(onPressed: () {
                Navigator.pop(context);
                NavigatorUtils.push(context, LoginRouter.smsLoginPage);
              }));
      return;
    }
    //订阅会员
    AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Subscribe_Click');

    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceListDialog(
            onPressed: () {
              NavigatorUtils.push(context, PayRouter.paySuccessPage);
            },
            skuIdType: _skuIdType);
      },
    );
  }
}
