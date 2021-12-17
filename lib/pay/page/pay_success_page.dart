import 'package:flashinfo/provider/user_info_provider.dart';
import 'package:flashinfo/res/colors.dart';
import 'package:flashinfo/res/gaps.dart';
import 'package:flashinfo/res/resources.dart';
import 'package:flashinfo/res/styles.dart';
import 'package:flashinfo/routers/fluro_navigator.dart';
import 'package:flashinfo/widgets/icon_font.dart';
import 'package:flashinfo/widgets/my_app_bar.dart';
import 'package:flashinfo/widgets/my_button.dart';
import 'package:flashinfo/widgets/my_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaySuccessPage extends StatefulWidget {
  const PaySuccessPage({Key? key}) : super(key: key);

  @override
  _PaySuccessPageState createState() => _PaySuccessPageState();
}

class _PaySuccessPageState extends State<PaySuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// 拦截返回，关闭键盘，否则会造成上一页面短暂的组件溢出
        FocusManager.instance.primaryFocus?.unfocus();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: MyAppBar(
          backOnPressed: () {
            NavigatorUtils.goBack(context);
            NavigatorUtils.goBackWithParams(context, true);
          },
        ),
        body: MyScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          crossAxisAlignment: CrossAxisAlignment.center,
          bottomButton: Consumer<UserInfoProvider>(builder: (_, provider, __) {
            return Container(
              color: Colours.material_bg,
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp16,
                  right: Dimens.gap_dp16,
                  top: Dimens.gap_dp16),
              child: MyButton(
                key: const Key('Confirm'),
                minHeight: 45.h,
                onPressed: () {
                  NavigatorUtils.goBack(context);
                },
                text: 'Confirm',
              ),
            );
          }),
          children: [
            Gaps.line,
            Gaps.vGap32,
            IconFont(
              name: 0xe63b,
              color: Colours.app_main,
              size: 75.sp,
            ),
            Gaps.vGap18,
            Text(
              'Successful purchase',
              style: TextStyles.textBold16,
            ),
            Gaps.vGap18,
            Consumer<UserInfoProvider>(builder: (_, userInfoProvider, __) {
              return Text(
                'Membership expiration date :${userInfoProvider.userInfoModel?.vipData?.vipInfo?.expiredAt ?? '-'}',
                style: TextStyles.textGray13,
              );
            }),
          ],
        ),
      ),
    );
  }
}
