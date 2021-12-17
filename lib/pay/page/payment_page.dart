import 'package:flashinfo/pay/page/price_list_dialog.dart';
import 'package:flashinfo/pay/pay_router.dart';
import 'package:flashinfo/pay/widget/payment/payment_package_widget.dart';
import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/dimens.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/util/other_utils.dart';
import 'package:flashinfo/util/pay_manger.dart';
import 'package:flashinfo/util/send_analytics_event.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flashinfo/pay/widget/payment/payment_top_widget.dart';
import 'package:flashinfo/pay/widget/payment/payment_content_widget.dart';
import 'package:flashinfo/pay/widget/payment/payment_sub_widget.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {Key? key, this.skuIdType = SkuIdType.csv, this.exportCount})
      : super(key: key);
  final SkuIdType skuIdType;
  final String? exportCount;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late int payIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (context.read<UserInfoProvider>().isVip) {
        setState(() {
          payIndex = 2;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: const MyAppBar(),
      body: MyScrollView(
        crossAxisAlignment: CrossAxisAlignment.center,
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
        bottomButton: PaymentSubWidget(
          payIndex: payIndex,
          onPressed: (){
            _showPackageDialog();
           if(payIndex == 2 ){
             AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Contact_Click_Recharge');
           } else {
             AnalyticEventUtil.analyticsUtil.sendAnalyticsEvent('Subscribe_Click');
           }
          }
        ),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Gaps.vGap10,
      PaymentTopWidget(
          skuIdType: widget.skuIdType, exportCount: widget.exportCount),
      Gaps.vGap10,
      PaymentPackageWidget(
        payIndex: payIndex,
        skuIdType: widget.skuIdType,
        onTap: (int index) {

          setState(() {
            payIndex = index;
          });
        },
      ),
      Gaps.vGap10,
      PaymentContentWidget(payIndex: payIndex, skuIdType: widget.skuIdType),
    ];
  }

  Future _showPackageDialog() async {
    showElasticDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PriceListDialog(
          skuIdType: getSkuIdType()!,
          onPressed: () {
            NavigatorUtils.goBack(context);
            if (getSkuIdType() == SkuIdType.pro ||
                getSkuIdType() == SkuIdType.starter) {
              NavigatorUtils.push(context, PayRouter.paySuccessPage);
            }
          },
        );
      },
    );
  }

  SkuIdType? getSkuIdType() {
    switch (payIndex) {
      case 0:
        return SkuIdType.pro;
      case 1:
        return SkuIdType.starter;
      case 2:
        return widget.skuIdType;
    }
  }
}
